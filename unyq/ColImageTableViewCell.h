//
//  ColImageTableViewCell.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 25/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageCol2;
@property (weak, nonatomic) IBOutlet UIImageView *imageCol1;
@property (weak, nonatomic) IBOutlet UILabel *labelCol1;
@property (weak, nonatomic) IBOutlet UILabel *labelCol2;
@property NSInteger indexVal;
@property (weak, nonatomic) IBOutlet UIButton *buttonOdd;
@property (weak, nonatomic) IBOutlet UIButton *buttonPar;

@end
