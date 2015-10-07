
//
//  MainTabBarController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 18/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//


#import "MainTabBarController.h"
#import "SDZOrderrWS.h"
#import "Constants.h"
#import "BDService.h"
#import "WSService.h"

#import "APLViewController.h"
#define sizePhoto CGSizeMake(600, 960)
@import Photos;


@interface MainTabBarController ()
@property UIView *customView;
@property UILabel *label;
@property UIProgressView *p;
@end

@implementation MainTabBarController

-(void)sendOK:(NSNotification *)not{
    NSString *visualcurrentPhoto =[NSString stringWithFormat:@"%ld",[[Util loadKey:@"currentFoto"] integerValue]+1];
    NSString *visualPhotoTotal =[NSString stringWithFormat:@"%ld",[[Util loadKey:@"totalFotos"] integerValue]+1];
        _label.text=[NSString stringWithFormat:@"Uploading %@/%@ photos",visualcurrentPhoto,visualPhotoTotal];
        [_p setProgress:[[Util loadKey:@"currentFoto"] floatValue]/[[Util loadKey:@"totalFotos"] floatValue] ];
}

-(void)sendEnd:(NSNotification *)not{
    _customView.hidden= YES;

}

-(void)startUpload:(NSNotification *)not{
    for(int i=0;i<64;i++) {
        [Util removeImage:[NSString stringWithFormat:@"%d" ,i]];
    }
    [Util saveKey:@"currentFoto" value:@"0"];
    SDZOrderrWS *order= [[Util loadObjects:fileObjects] objectAtIndex:0];
    if(order._id && !([order._id isEqualToString:@""])){
        __block NSString *order_id = order._id;
        [Util saveKey:@"order_photoSend" value:order_id];
        PHImageManager * imageManager = [[PHCachingImageManager alloc] init];
        NSString *identifier =[[NSUserDefaults standardUserDefaults] objectForKey:@"album"];
        PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[identifier] options:nil];
        PHAssetCollection *assetCollection = fetchResult.firstObject;
        PHFetchOptions *fetchOptions = [PHFetchOptions new];
        fetchOptions.sortDescriptors = @[
                                         [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES],
                                         ];
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
        NSString *totalFotos = [NSString stringWithFormat:@"%ld",[assetsFetchResult count]-1];
        [Util saveKey:@"totalFotos" value:totalFotos];
//        [assetsFetchResult enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            PHAsset *asset = obj;
//            [imageManager requestImageDataForAsset:asset options:PHImageRequestOptionsVersionCurrent resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
//                //después de guardar el último en el dictionary llamo al conection
//                if(idx == ([assetsFetchResult count]-1))
//                    [[UtilConnection instance ]sendPhoto:[Util loadKey:kIdUser]  pass:@"lacasita" idorder:order_id nombre:@"0" imagen:[Util readImageFromFile:@"0"]];
//                
//            }];
//        }];
        [UtilConnection instance].assetsFetchResult = assetsFetchResult;
        PHAsset *asset = [assetsFetchResult objectAtIndex:0];
        [imageManager requestImageDataForAsset:asset options:PHImageRequestOptionsVersionCurrent resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
            [[UtilConnection instance ]sendPhoto:[Util loadKey:kIdUser]  pass:@"lacasita" idorder:order_id nombre:@"0" imagen:imageData];
        }];
        
    }
    NSString *visualcurrentPhoto =[NSString stringWithFormat:@"%ld",[[Util loadKey:@"currentFoto"] integerValue]+1];
    NSString *visualPhotoTotal =[NSString stringWithFormat:@"%ld",[[Util loadKey:@"totalFotos"] integerValue]+1];
        _label.text=[NSString stringWithFormat:@"Uploading %@/%@ photos",visualcurrentPhoto,visualPhotoTotal];
        _customView.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startUpload:) name:@"startUpload" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendEnd:) name:@"sendEnd" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendOK:) name:@"sendOK" object:nil];
    //inicializo el singleton para el imagepicker!
    [UtilConnection instance];
    self.selectedIndex =1;
    [self configureTab];

     _customView= [[UIView alloc] initWithFrame:CGRectMake(0,10,SCREEN_WIDTH,60)];
    [_customView setBackgroundColor:[UIColor clearColor]];
    
    _p = [[UIProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, 35, SCREEN_WIDTH*0.8,20)];    // Here pass frame as per your requirement
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, 30)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor blackColor];
//    _p.progress = [[Util loadKey:@"currentFoto"] integerValue]/[[Util loadKey:@"totalFotos"] integerValue];
    [_customView addSubview:_p];
    [_customView addSubview:_label];
    _customView.hidden = YES ;
    self.navigationItem.titleView = _customView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)registerDeviceHandler:(id)value{
    if([value isEqualToString:@"1"]){

        [Util saveKey:kRegisterDevice value:@"OK"];
    }
    [JTProgressHUD hide];
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    if([Util loadKey:kIsFirstLogin] == nil){
            [[BDService instance] addPhotos];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *registerVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:controllerRegister];
        [self.navigationController presentViewController:registerVC animated:NO completion:nil];
    }else if([Util loadKey:kRegisterDevice] == nil){
        [JTProgressHUD show];
        [[WSService instance] registerDevice:self];
    }

//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    APLViewController *registerVC = (APLViewController *)[storyboard instantiateViewControllerWithIdentifier:@"preview"];
//    [self.navigationController presentViewController:registerVC animated:NO completion:nil];

//    OBTENER LA URL DE LA FOTO
//    NSURL *imageURL = contentEditingInput.fullSizeImageURL;
//    [[NSUserDefaults standardUserDefaults] setObject:imageURL forKey:key];

}

-(void)configureTab{
UITabBar *tabBar = self.tabBar;
UITabBarItem *tabBarItemInicio = [tabBar.items objectAtIndex:0];
[tabBarItemInicio setTitle:@"MY ORDERS"];
[tabBarItemInicio setSelectedImage:[[UIImage imageNamed:@"bar1B"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
[tabBarItemInicio setImage:[[UIImage imageNamed:@"bar1A"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

UITabBarItem *tabBarItemDestiny = [tabBar.items objectAtIndex:1];
[tabBarItemDestiny setTitle:@"ORDERS"];
[tabBarItemDestiny setSelectedImage:[[UIImage imageNamed:@"bar2b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
[tabBarItemDestiny setImage:[[UIImage imageNamed:@"bar2a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

UITabBarItem *tabBarItemRoute = [tabBar.items objectAtIndex:2];
[tabBarItemRoute setTitle:@"+ INFO"];
[tabBarItemRoute setSelectedImage:[[UIImage imageNamed:@"bar3b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
[tabBarItemRoute setImage:[[UIImage imageNamed:@"bar3a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica" size:7.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
}
@end
