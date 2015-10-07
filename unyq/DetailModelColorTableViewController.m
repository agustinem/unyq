//
//  DetailModelColorTableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 25/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "DetailModelColorTableViewController.h"
#import "ColImageTableViewCell.h"
#import "BDService.h"
#import "Constants.h"
#import "SDZOrderrWS.h"
#import "Photo.h"
@interface DetailModelColorTableViewController ()

@property NSArray *models;
@property bool isOdd;

@end

@implementation DetailModelColorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
    NSString *section = [Util convertCover:order.cover];
    if(_isColor)
        _models =[[BDService instance] getColorsByModel:section model:order.model];
    else
        _models = [[BDService instance] getModelsBySection:section];
    _isOdd = ([_models count]%2 > 0) ? true:false;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_isOdd) ? [_models count]/2+1:[_models count]/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCellStep1" forIndexPath:indexPath];
    NSInteger val = indexPath.row * 2;

    Photo *photo1 = [_models objectAtIndex:val];
    cell.imageCol1.image = [UIImage imageNamed:photo1.name];
    cell.labelCol1.text = [self getTitle:photo1];
    cell.indexVal = val;
    cell.buttonOdd.tag = val;
    if ([_models count]>(val+1)) {
        Photo *photo2 = [_models objectAtIndex:val+1];
        cell.imageCol2.image = [UIImage imageNamed:photo2.name];
        cell.labelCol2.text =  [self getTitle:photo2];
        cell.indexVal = val+1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.buttonPar.tag = val+1;
        cell.imageCol2.hidden= NO;
        cell.labelCol2.hidden = NO;

    }else{
        cell.imageCol2.hidden= YES;
        cell.labelCol2.hidden = YES;
    }
    return cell;
}


-(NSString *)getTitle:(Photo *)photo{
    if(_isColor){
        NSString *colores = photo.color1;
        if(photo.color2)
           colores = [colores stringByAppendingString:[NSString stringWithFormat:@"_%@",photo.color2]];
        if(photo.color3)
           colores =   [colores stringByAppendingString:[NSString stringWithFormat:@"_%@",photo.color3]];
        colores =[colores stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        return colores;
    }else{
        NSString *model =[photo.model stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        model =[[model componentsSeparatedByString:@"-"] objectAtIndex:1];
        return model;
    }
}


- (IBAction)selectButtonAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    Photo *photo = [_models objectAtIndex:button.tag];
    SDZOrderrWS *order= [[Util loadObjects:fileObjects] objectAtIndex:0];
    if(!_isColor){
        order.model = [photo.model stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        order.colour1 = @"";
        order.colour2 = @"";
        order.colour3 = @"";
        [Util saveObject:order file:fileObjects];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if([photo.color1 isEqualToString:@"custom.jpg"]){
            [self alertTF];
        }else{
        order.colour1 = [photo.color1 stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        order.colour2 = [photo.color2 stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        order.colour3 = [photo.color3 stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
            [Util saveObject:order file:fileObjects];
            [self.navigationController popViewControllerAnimated:YES];

        }
    }
}

-(void)alertTF{
     SDZOrderrWS *order= [[Util loadObjects:fileObjects] objectAtIndex:0];
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Select color"
                                          message:@"Write your prefer color"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"color 1";
     }];
    if (!([order.model containsString:@"STYLE Xtreme"] || [order.model isEqualToString:@"STYLE U"] || [order.model containsString:@"vittra"] || [order.model isEqualToString:@"ranger"])) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
         {
             textField.placeholder = @"color 2";
         }];

    }if ([order.model containsString:@"STYLE Styilis"] || [order.model containsString:@"STYLE Venus"]) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
         {
             textField.placeholder = @"color 3";
         }];
    }
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   SDZOrderrWS *order =[[Util loadObjects:fileObjects] objectAtIndex:0];
                                   UITextField *tf = alertController.textFields.firstObject;
                                   order.colour1 = tf.text;
                                   if([alertController.textFields count]>=2){
                                    UITextField *tf2 = [alertController.textFields objectAtIndex:1];
                                       order.colour2 = tf2.text;}
                                   if([alertController.textFields count]>=3){
                                       UITextField *tf3 = [alertController.textFields objectAtIndex:2];
                                       order.colour3 = tf3.text;
                                   }
                                   
                                   [Util saveObject:order file:fileObjects];
                                   [self.navigationController popViewControllerAnimated:YES];

                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
