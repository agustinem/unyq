//
//  PhotoViewController.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 18/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface PhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentViewVideoInfo;
- (IBAction)videoButtonAction:(id)sender;
- (IBAction)tipsButtonAction:(id)sender;
- (IBAction)infoAction:(id)sender;
- (IBAction)startAction:(id)sender;
- (IBAction)guideAction:(id)sender;
- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewVideo;
@property (weak, nonatomic) IBOutlet UITextView *textViewInfo;
@property (weak, nonatomic) IBOutlet UIView *viewPhotoBackground;
@property (weak, nonatomic) IBOutlet UIButton *botonClose;

@end
