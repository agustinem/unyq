//
//  PhotoViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 18/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "PhotoViewController.h"
#import "Constants.h"
#import "APLViewController.h"

@import Photos;
@import MediaPlayer;
@interface PhotoViewController ()

@property     MPMoviePlayerViewController *moviePlayer;
@property (nonatomic, weak)  UIImagePickerController *imagePicker;
@property bool showCamera;
@end

@implementation PhotoViewController


#pragma mark -view controller



- (void)viewDidLoad {
    [super viewDidLoad];
    _viewPhotoBackground.hidden= YES;
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"animacion" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    _textViewInfo.hidden = YES;
    _viewVideo.hidden=YES;
    _contentViewVideoInfo.hidden=YES;
    _botonClose.hidden = YES;
    _moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _imagePicker.delegate = nil;
    _imagePicker = nil;
    [self.navigationController popViewControllerAnimated:YES];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstStep4"] == nil){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstStep4"];
        [self infoAction:nil];
    }
}




- (IBAction)playMovie:(id)sender
{
    [self presentMoviePlayerViewControllerAnimated:_moviePlayer];

}

- (IBAction)videoButtonAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLVideo]];

}

- (IBAction)tipsButtonAction:(id)sender {

    _contentViewVideoInfo.hidden=false;
    _textViewInfo.hidden=false;
    _botonClose.hidden = false;
}

- (IBAction)infoAction:(id)sender {
    _botonClose.hidden=false;
    _contentViewVideoInfo.hidden=true;
    _textViewInfo.hidden=true;
    [self playMovie:nil];
}

- (IBAction)startAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    APLViewController *registerVC = (APLViewController *)[storyboard instantiateViewControllerWithIdentifier:@"preview"];
    
    [self.navigationController presentViewController:registerVC animated:YES completion:nil];
    registerVC.nav = self.navigationController;
    registerVC.isReturn = false;
    registerVC.fileName = @"";
    registerVC.imageNameOverlay = @"";

    //[self presentCamera:nil];
}

- (IBAction)guideAction:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLGuide]];
}

- (IBAction)closeAction:(id)sender {
    _contentViewVideoInfo.hidden =true;
    _textViewInfo.hidden =true;
    _viewVideo.hidden=true;
    _botonClose.hidden = true;
}


@end
