#import "APLViewController.h"
#import <JTProgressHUD/JTProgressHUD.h>
#import "Constants.h"
@import  Photos;
@interface APLViewController ()



@property (nonatomic, weak) IBOutlet UIBarButtonItem *takePictureButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageOver;
@property (weak, nonatomic) IBOutlet UIToolbar *overlayToolBar;
@property (weak, nonatomic) IBOutlet UIImageView *overlayFigure;

@property (nonatomic) UIImagePickerController *imagePicker;

@property    UIImage *imageSave;

@property bool isVisiblePreview;
@property NSNumber * contador;
@property NSMutableArray *overlayNames;

@property bool takeInUse;

@property NSOperationQueue *queue;
@end



@implementation APLViewController


- (void)viewDidLoad
{
    _takeInUse = false;
    [super viewDidLoad];
    _queue= [[NSOperationQueue alloc] init];
    
    _isVisiblePreview = false;
    //empiezo en 4 pq tengo 3 guardadas de la pantalla anterior
    _contador = [[NSNumber alloc] initWithInt:4];
    _overlayNames = [NSMutableArray new];
    for(int i=1;i<61;i++){
        [_overlayNames addObject:[NSString stringWithFormat:@"png_bk_x%d",i]];
    }
    // Do any additional setup after loading the view.
    
}


-(void)presentCamera:(id)value{
    _imagePicker=   [UtilConnection getPicker];
    [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
    self.viewOver.frame =     CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*4/3);

    _imagePicker.cameraOverlayView = self.viewOver;
    NSString *imageName= [_overlayNames objectAtIndex:[_contador intValue] -4];
    if(_isReturn)
        imageName = _imageNameOverlay;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    _imageOver.image = [UIImage imageWithContentsOfFile:filePath];
    _overlayFigure.image = _imageOver.image;
    _overlayFigure.hidden=true;
    _imagePicker.delegate = self;
    [self presentViewController:_imagePicker animated:YES completion:^{
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    if (_isReturn & !_OnlyOne) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self  presentCamera:nil];
        _OnlyOne = false;
    }
}



#pragma mark - Toolbar actions

- (IBAction)done:(id)sender{
    _takeInUse=false;
    [_takePictureButton setEnabled:YES];
    if(_isVisiblePreview){
        [self hidePreview];
    }
}

-(void)hidePreview{

    if([_contador intValue] == 64){
        [_queue waitUntilAllOperationsAreFinished];
        [self exito];
    }else{
        int val= [_contador intValue] -4;
        if ([_overlayNames count]-1 >= val) {
            NSString *imageName= [_overlayNames objectAtIndex:val];
            if(_isReturn)
                imageName = _imageNameOverlay;
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            _imageOver.image = [UIImage imageWithContentsOfFile:filePath];
            _overlayFigure.image = _imageOver.image;
        }
        _isVisiblePreview=false;
        [_imageOver setBackgroundColor:[UIColor clearColor]];
        _overlayFigure.hidden=true;
        [_takePictureButton setTitle:@"Take"];
        [_doneButton setEnabled:NO];
        _takeInUse =false;
        [_takePictureButton setEnabled:YES];
    
    }
}

-(void)showPreview{
    
    [_doneButton setEnabled:YES];
    [_takePictureButton setTitle:@"Save"];
    _takeInUse =false;
    [_takePictureButton setEnabled:YES];
    [_imageOver setBackgroundColor:[UIColor blackColor]];
    _overlayFigure.hidden=false;
    _isVisiblePreview=true;
}

- (IBAction)takePhoto:(id)sender{
    if(!_takeInUse){
        _takeInUse=true;
    if(_isVisiblePreview){
        if(!_isReturn){
            _imageSave = [_imageOver.image copy];
        NSBlockOperation* saveOp = [NSBlockOperation blockOperationWithBlock: ^{
            [Util writeImageToFile:@"temp" image:UIImageJPEGRepresentation(_imageSave,1.0)];
        }];

            // guarda en el album
            [saveOp setCompletionBlock:^{
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    NSString *identifier =[[NSUserDefaults standardUserDefaults] objectForKey:@"album"];
                    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[identifier] options:nil];
                    PHAssetCollection *assetCollection= fetchResult.firstObject;
                    PHAssetCollectionChangeRequest *assetCollectionChangeRequest =[PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                    PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:[UIImage imageWithData: [Util readImageFromFile:@"temp"]]];
                    [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
                } completionHandler:nil];
                
            }];
            
            
            [_queue addOperation:saveOp];
            _queue.maxConcurrentOperationCount = 5;
            _contador = [NSNumber numberWithInt:[_contador intValue]+1];
            [self hidePreview];
            //then push in OK
        }else{
            [Util writeImageToFile:_fileName image:UIImageJPEGRepresentation(_imageOver.image,1.0)];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        //push in Take
        [self.imagePicker takePicture];
        _takeInUse=true;
        [_takePictureButton setEnabled:NO];
    }
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if(!_fileName || [_fileName isEqualToString:@""]) {
        _fileName = @"temp.txt";
    }
        _imageOver.clipsToBounds = YES;
    _imageOver.image = image;
    _imageOver.frame = [self getFrameOfImage:_imageOver];
    _overlayFigure.frame = _imageOver.frame;
//    _imageOver.frame = CGRectMake(0, 0, _imageOver.frame.size.width,  _imageOver.frame.size.width);

//    _overlayFigure.frame =   CGRectMake(0,     _imageOver.frame.size.height - image.size.height,     image.size.width,     image.size.height);
//    [_overlayFigure setFrame:AVMakeRectWithAspectRatioInsideRect(image.size, _overlayFigure.frame)];
//        _overlayFigure.frame =   CGRectMake(0,     0  , 20,20   );
    [self showPreview];
}



-(void)exito{
    _OnlyOne = false;
    _isReturn=true;
    [_imagePicker dismissViewControllerAnimated:YES completion:^{
        UIAlertController *alertController =    [UIAlertController
                                                 alertControllerWithTitle:@"Order Sent"
                                                 message:@"Photos are sending in background"
                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action) {
                                           [[NSNotificationCenter defaultCenter]postNotificationName:@"startUpload" object:nil];
                                           [self dismissViewControllerAnimated:NO completion:^{
                                               [_nav popToRootViewControllerAnimated:YES];
                                           }];
                                           
                                       }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
    
}

- (BOOL)shouldAutorotate
{
    [super shouldAutorotate];
    return NO;
}

- (CGRect) getFrameOfImage:(UIImageView *) imgView
{
    
    CGSize imgSize      = imgView.image.size;
    CGSize frameSize    = imgView.frame.size;
    
    CGRect resultFrame;
    
    if(imgSize.width < frameSize.width && imgSize.height < frameSize.height)
    {
        resultFrame.size    = imgSize;
    }
    else
    {
        float widthRatio  = imgSize.width  / frameSize.width;
        float heightRatio = imgSize.height / frameSize.height;
        
        float maxRatio = MAX (widthRatio , heightRatio);
        NSLog(@"widthRatio = %.2f , heightRatio = %.2f , maxRatio = %.2f" , widthRatio , heightRatio , maxRatio);
        
        resultFrame.size = CGSizeMake(imgSize.width / maxRatio, imgSize.height / maxRatio);
    }
    
//    resultFrame.origin  = CGPointMake(imgView.center.x - resultFrame.size.width/2 , imgView.center.y - resultFrame.size.height/2);
      resultFrame.origin  = CGPointMake(0,0);
    return resultFrame;
}
@end

