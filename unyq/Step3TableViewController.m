//
//  Step3TableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "Step3TableViewController.h"
#import "Constants.h"
#import "WSService.h"
#import "BDService.h"
#import "Step3TableViewCell.h"
#import "SDZOrderrWS.h"
#import "APLViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
@import Photos;
@interface Step3TableViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property NSArray *labels;
@property NSArray *labelsSection;
@property UIImageView *imageView;
@property NSArray *imagesName;
@property NSArray *imagesOverlay;
@property NSArray *alerts;
@property NSNumber * buttonSelected;
@property NSArray *album;
@property PHObjectPlaceholder *albumPlaceholder;

@end

@implementation Step3TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create album if no exists
    [self createAlbum];
    [self titles];
//    _imagePicker=   [UtilConnection getPicker];
//    _imagePicker.delegate = self;
//    _imagePicker.showsCameraControls = NO;
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.1, SCREEN_WIDTH, SCREEN_HEIGHT*0.8)];
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonAction:) name:@"button" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonInfo:) name:@"info" object:nil];
}

-(void)buttonAction:(NSNotification *)value{
    NSDictionary *user = value.userInfo;
    //va de 0 a 7 numerandose de arriba abajo y de izq a derecha
    _buttonSelected = [user objectForKey:@"info"] ;
    [self presentCamera];
}

-(void)buttonInfo:(NSNotification *)value{
    NSDictionary *user = value.userInfo;
    NSString *valor = [user objectForKey:@"info"];
    [Util alertInfo:self title:@"INFO" text:valor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_labelsSection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Step3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"step3Cell" forIndexPath:indexPath];
    
    cell.labelText.text= _labels[indexPath.section];
    NSData *data = [Util readImageFromFile:[NSString stringWithFormat:@"%ld" ,4*indexPath.section]];
    UIImage *image0 =[UIImage imageWithData:data];
    cell.imageLeftTop.image = (image0 == nil)?[UIImage imageNamed:_imagesName[4*indexPath.section]]:image0;
    
    
    NSData *data1 = [Util readImageFromFile:[NSString stringWithFormat:@"%ld" ,4*indexPath.section+1]];
    UIImage *image1 =[UIImage imageWithData:data1];
    cell.imageRightTop.image = (image1 == nil)?[UIImage imageNamed:_imagesName[4*indexPath.section+1]]:image1;
    
    NSData *data2 = [Util readImageFromFile:[NSString stringWithFormat:@"%ld" ,4*indexPath.section+2]];
    UIImage *image2 =[UIImage imageWithData:data2];
    cell.imageBottomLeftTrue.image =(image2 == nil)? [UIImage imageNamed:_imagesName[4*indexPath.section+2]]:image2;
    
    NSData *data3 = [Util readImageFromFile:[NSString stringWithFormat:@"%ld" ,4*indexPath.section+3]];
    UIImage *image3 =[UIImage imageWithData:data3];
    cell.imageBottomLeft.image = (image3 == nil)?[UIImage imageNamed:_imagesName[4*indexPath.section+3]]:image3;
    
    NSString *texto = [_alerts objectAtIndex:0];
    if ([_alerts count]> indexPath.section) {
        texto =[_alerts objectAtIndex:indexPath.section];
    }
    
    cell.valor =texto;
    cell.buttonleftTop.tag=4*indexPath.section;
    cell.buttonRightTop.tag=4*indexPath.section+1;
    cell.buttonLeftBottom.tag=4*indexPath.section+2;
    cell.buttonRightBottom.tag =4*indexPath.section+3;
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _labelsSection[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==([_labelsSection count]-1))
        return 80.0f;
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 500;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor whiteColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==([_labelsSection count]-1)){
        UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 80)];
        [footerView setBackgroundColor:[UIColor blackColor]];
        UIButton *addguardar=[UIButton buttonWithType:UIButtonTypeCustom];
        SDZOrderrWS *order =[[Util loadObjects:fileObjects] objectAtIndex:0];
        if([order.cover isEqualToString:@"BK"])
            [addguardar setTitle:@"NEXT" forState:UIControlStateNormal];
        else
            [addguardar setTitle:@"ORDER" forState:UIControlStateNormal];
        [addguardar addTarget:self action:@selector(addguardar:) forControlEvents:UIControlEventTouchUpInside];
        [addguardar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
        //addguardar.frame=CGRectMake(self.tableView.frame.size.width/2 -50, 5, 100, 30); //set some large width to ur title
        addguardar.frame = footerView.frame;        
        [footerView addSubview:addguardar];
        return footerView;
    }else return nil;
}

- (void)addguardar:(id)sender{
    [self.tableView endEditing:YES];
    
    if([self validate]){
            [JTProgressHUD show];
            [self savePhotosInAlbum];
        }
    
}


-(bool) validate{
    
    NSString *error = @"Please, take missing pictures.";
    bool isError =false;
    for(int i=0;i<[_labelsSection count]*4;i++) {
        NSString *imageFile =[NSString stringWithFormat:@"%d" ,i];
        if([Util readImageFromFile:imageFile]==nil){
            isError=true;
            break;}
    }
    if(isError)
    {
        [[[UIAlertView alloc]initWithTitle:@"Oops!" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return false;
    }
    return  true;
}





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)titles{
    self.title = @"STEP 3/3";
    SDZOrderrWS *order =[[Util loadObjects:fileObjects] objectAtIndex:0];
    if([order.cover isEqualToString:@"AK"]){
        _labels = @[@"Take 4 pictures of the patient wearing the prosthesis as shown in the examples below.",@"Take 4 pictures of the prosthetic leg as shown in the examples below. Click on more info for further instructions."];
        _labelsSection = @[@"SOUND LEG & PROSTHESIS PHOTOS",@"PROSTHESIS LEG PHOTOS"];
        _imagesName = @[@"AK_STEP2_leg_front.jpg",@"AK_STEP2_leg_leftside.jpg",@"AK_STEP2_leg_back.jpg",@"AK_STEP2_leg_rightside.jpg",@"AK_STEP2_prothesis-toplateral.jpg",@"AK_STEP2_prosthesis-lateral.jpg",@"AK_STEP2_prosthesis-back.jpg",@"AK_STEP2_prosthesis_maxflexion.jpg"];
        _alerts=@[@"Use a camera or phone with at least 5MP high quality settings.\nDo not use flash or zoom and make sure all photos are in sharp focus.\nCamera must look straight on the person and prosthesis.\nThe top of the foot shell and all componentry must be visible, including knee joint and proximal connector.\nRemove any foam cover.\nPosition camera approximately 5” from the ground.",@"Lateral & Back:\n\nPosition the camera so the top of the foot shell looks like a straight line.\nYou can place the prosthesis on a bench to get this low photo.\n\nTop lateral: position the camera next to the lateral side of the socket looking straight down.\n\nMax Flexion:\nHave the wearer sit in a chair if needed and fully flex the knee.\nPhotograph the prosthetic knee at maximum flexion from the outside."];        _imagesOverlay=@[@"AKSL_L_front",@"AKSL_L_left_side",@"AKSL_L_back",@"AKSL_L_right_side",@"AKSL_R_front",@"AKSL_R_left-side",@"AKSL_R_back",@"AKSL_R_right-side",@"AK_PROS_L_FOOT_SHELL",@"AK_PROS_L_FS_PROFILE_SIDE",@"AK_PROS_L_FS_PROFILE_REAR",@"AK_PROS_L_MAXIMUM_FLEXION",@"AK_PROS_R_FOOT_SHELL",@"AK_PROS_R_FS_PROFILE_SIDE",@"AK_PROS_R_FS_PROFILE_REAR",@"AK_PROS_R_MAXIMUM_FLEXION"];
        
    }else if([order.cover isEqualToString:@"BK"]){
        _labels = @[@"Take 4 pictures of the patient wearing the prosthesis as shown in the examples below. Click on more info for further instructions."];
        _labelsSection = @[@"SOUND LEG PHOTOS"];
        _imagesName = @[@"BK_STEP2_leg_front.jpg",@"BK_STEP2_leg_leftside.jpg",@"BK_STEP2_leg_back.jpg",@"BK_STEP2_leg_rightside.jpg"];
        _alerts=@[@"Use a camera or phone with at least 5MP high quality settings.\nDo not use flash or zoom and make sure all photos are in sharp focus.\nCamera must look straight on the person and prosthesis.\nThe top of the foot shell and all componentry must be visible, including knee joint and proximal connector.\nRemove any foam cover.\nPosition camera approximately 5” from the ground."];
        _imagesOverlay=@[@"BKL_L_front",@"BKL_L_left",@"BKL_L_back",@"BKL_L_right_side",@"BKL_R_front",@"BKL_R_left_side",@"BKL_R_back",@"BKL_R_right_side"];
    }else{
        _labels = @[@"Take 4 pictures of the patient wearing the prosthesis as shown in the examples below.  Click on more info for further instructions.",@"Take 4 pictures of the prosthetic leg as shown in the examples below. Click on more info for further instructions.",@"Take 4 pictures of the foot and the socket as shown in the example below. Click on more info for more instructions."];
        _labelsSection= @[@"SOUND LEG PHOTOS", @"PROSTHESIS PHOTOS", @"FOOT & SOCKET PHOTOS"];
        _imagesName = @[@"BK_STEP2_leg_front.jpg",@"BK_STEP2_leg_leftside.jpg",@"BK_STEP2_leg_back.jpg",@"BK_STEP2_leg_rightside.jpg",@"BK_MINI_STEP3_prosthesis_front.jpg",@"BK_MINI_STEP3_prosthesis_lefsite.jpg",@"BK_MINI_STEP3_prosthesis_backside.jpg",@"BK_MINI_STEP3_prosthesis_rightside.jpg",@"BK_MINI_STEP3_foot.jpg",@"BK_MINI_STEP3_socket.jpg",@"BK_MINI_STEP3_foot_back.jpg",@"BK_MINI_STEP3_foot_rightside.jpg"];
        
        _alerts=@[@"Use a camera or phone with at least 5MP high quality settings.\nDo not use flash or zoom and make sure all photos are in sharp focus.\nCamera must look straight on the person and prosthesis.\nThe top of the foot shell and all componentry must be visible, including knee joint and proximal connector.\nRemove any foam cover.\nPosition camera approximately 5” from the ground."];
    _imagesOverlay=@[@"BKSL_L_front",@"BKSL_L_left",@"BKSL_L_back",@"BKSL_L_right_side",@"BKSL_R_front",@"BKSL_R_left_side",@"BKSL_R_back",@"BKSL_R_right_side",@"BKMINI_front",@"BKMINI_left",@"BKMINI_rear",@"BKMINI_right",@"BKMINI_front",@"BKMINI_left",@"BKMINI_rear",@"BKMINI_right",@"BKMINI_footshell",@"BKMINI_socket-profile",@"BKMINI_footshell-profile-rear",@"BKMINI_footshell-profile-side",@"BKMINI_footshell",@"BKMINI_socket-profile",@"BKMINI_footshell-profile-rear",@"BKMINI_footshell-profile-side"];
    }
    
    
    
    
    
    
}


//#pragma mark -delegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    NSString *mediaType = [info
//                           objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
//        UIImage *image = [info
//                          objectForKey:UIImagePickerControllerOriginalImage];
//        [Util writeImageToFile:[_buttonSelected stringValue] image:UIImageJPEGRepresentation(image,1)];
//    }
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    [self.tableView reloadData];
//    
//    
//}
//
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}
//


-(void)presentCamera{
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        APLViewController *registerVC = (APLViewController *)[storyboard instantiateViewControllerWithIdentifier:@"preview"];
    
    
        NSString *imageName;
        
        if([_buttonSelected integerValue]<4){
            if([[Util loadKey:kLeg] isEqualToString:leftLeg]){
                imageName = [_imagesOverlay objectAtIndex:[_buttonSelected integerValue]];
            }else{
                imageName = [_imagesOverlay objectAtIndex:[_buttonSelected integerValue]+4];
            }
        }
        else if([_buttonSelected integerValue]<8){
            if([[Util loadKey:kLeg] isEqualToString:leftLeg]){
                imageName = [_imagesOverlay objectAtIndex:[_buttonSelected integerValue]+4];
            }else{
                imageName = [_imagesOverlay objectAtIndex:[_buttonSelected integerValue]+8];
            }
        }
        else{
            if([[Util loadKey:kLeg] isEqualToString:leftLeg]){
                imageName = [_imagesOverlay objectAtIndex:[_buttonSelected integerValue]+8];
            }else{
                imageName = [_imagesOverlay objectAtIndex:[_buttonSelected integerValue]+12];
            }
        }
    registerVC.imageNameOverlay = imageName;
    registerVC.isReturn = true;
    registerVC.OnlyOne = true;
    registerVC.fileName = [_buttonSelected stringValue];
    
    [self.navigationController presentViewController:registerVC animated:YES completion:nil];
    
    
}

-(void)savePhotosInAlbum{
    NSString *identifier =[[NSUserDefaults standardUserDefaults] objectForKey:@"album"];
    if([identifier length] > 0){
        
        PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[identifier] options:nil];
        PHAssetCollection *assetCollection = fetchResult.firstObject;
        
        // Add it to the photo library
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
            NSMutableArray *array = [NSMutableArray new];
            for(int i=0;i<[_labelsSection count]*4;i++) {
                UIImage *image = [UIImage imageWithData:[Util readImageFromFile:[NSString stringWithFormat:@"%d" ,i]]];
                if(image != nil){
                    PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
                    [array addObject:[assetChangeRequest placeholderForCreatedAsset]];
                    
                }
            }
            [assetCollectionChangeRequest addAssets:array];
        } completionHandler:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [JTProgressHUD hide];
                SDZOrderrWS *order =[[Util loadObjects:fileObjects] objectAtIndex:0];
                if([order.cover isEqualToString:@"BK"])
                    [self performSegueWithIdentifier:segueStep4 sender:nil];
                else 
                    [self exito];
            });
            
        }];
        
    }else{
        [JTProgressHUD hide];
        [Util alertErrorConexion:nil];
        NSLog(@"Error , el album no existe");
    }
    
}

-(void)exito{
    
    UIAlertController *alertController =    [UIAlertController
                                             alertControllerWithTitle:@"Order Sent"
                                             message:@"Photos are sending in background"
                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action) {
                                       [[NSNotificationCenter defaultCenter]postNotificationName:@"startUpload" object:nil];
                                       [self.navigationController popToRootViewControllerAnimated:YES];
                                   }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)createAlbum{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    SDZOrderrWS *order =[[Util loadObjects:fileObjects] objectAtIndex:0];
    NSString *name =[[NSUserDefaults standardUserDefaults] objectForKey:@"albumName"];
    NSString *currentName = [NSString stringWithFormat:@"UNYQ-%@-%@",order.patient ,stringFromDate];
    if(![currentName isEqualToString:name]){
        [[NSUserDefaults standardUserDefaults] setObject:currentName forKey:@"albumName"];
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:currentName];
            _albumPlaceholder = changeRequest.placeholderForCreatedAssetCollection;
            [[NSUserDefaults standardUserDefaults] setObject:_albumPlaceholder.localIdentifier forKey:@"album"];
        } completionHandler:nil];
    }
}



@end
