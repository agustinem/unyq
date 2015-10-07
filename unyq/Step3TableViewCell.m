//
//  Step3TableViewCell.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 26/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "Step3TableViewCell.h"


@implementation Step3TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)infoAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"info" object:nil userInfo:@{@"info":_valor}];
}

- (IBAction)botonAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"button" object:nil userInfo:@{@"info":[[NSNumber alloc] initWithInteger:button.tag]}];
}
@end
