//
//  Step1ImageTableViewCell.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 20/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Step1ImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageFull;

@end
