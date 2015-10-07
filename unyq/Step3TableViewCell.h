//
//  Step3TableViewCell.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 26/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Step3TableViewCell : UITableViewCell
- (IBAction)infoAction:(id)sender;
- (IBAction)botonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageLeftTop;
@property (weak, nonatomic) IBOutlet UIImageView *imageRightTop;
@property (weak, nonatomic) IBOutlet UIImageView *imageBottomLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imageBottomLeftTrue;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property NSString *valor;
@property (weak, nonatomic) IBOutlet UIButton *buttonRightTop;
@property (weak, nonatomic) IBOutlet UIButton *buttonRightBottom;

@property (weak, nonatomic) IBOutlet UIButton *buttonleftTop;
@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBottom;

@end
