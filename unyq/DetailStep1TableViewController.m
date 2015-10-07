//
//  DetailStep1TableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "DetailStep1TableViewController.h"
#import "Step1ImageTableViewCell.h"
#import "Constants.h"
#import "SDZOrderrWS.h"
#import "DetailModelColorTableViewController.h"
#import "SelectableTableViewController.h"
#import "WSService.h"


@interface DetailStep1TableViewController ()
@property NSArray *titlesSection;
@property bool isColor;
@property NSString *imagenModelo;
@property NSString *imagenColor;
@end

@implementation DetailStep1TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titles];
}

-(void)viewWillAppear:(BOOL)animated{
      [self.tableView reloadData]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _titlesSection[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"indentifierStep1";
    if(indexPath.section <2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell ==nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, 0, SCREEN_WIDTH*0.9, 40)];
//          textField.borderStyle = UITextBorderStyleBezel;
            textField.delegate = self;
            textField.placeholder= @"Type here";
            cell.accessoryView = textField;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }if (indexPath.section >=2) {
        Step1ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
         SDZOrderrWS *order =  [[Util loadObjects:fileObjects] objectAtIndex:0];
        if(indexPath.section == 2){
            if([order.model isEqualToString:@""]){
                cell.imageFull.hidden = NO;
                cell.imageTitle.hidden= YES;
                cell.labelTitle.hidden= YES;
                cell.imageFull.image = [UIImage imageNamed:@"modelos.jpg"];
            }else{
                cell.imageFull.hidden = YES;
                cell.imageTitle.hidden= NO;
                cell.labelTitle.hidden= NO;
                
                NSString *model =[order.model stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
                if([model containsString:@"-"]){
                    model =[[model componentsSeparatedByString:@"-"] objectAtIndex:1];
                }
                cell.labelTitle.text = model;
                NSString *imagen = [[Util convertCover:order.cover] stringByAppendingString:[NSString stringWithFormat:@"_%@.jpg",order.model]];
                NSString *colores = order.colour1;
                if([colores length]>1){
                if(order.colour2 && ![order.colour2 isEqualToString:@""])
                    colores =[colores stringByAppendingString:[NSString stringWithFormat:@"_%@",order.colour2]];
                if(order.colour3 && ![order.colour3 isEqualToString:@""])
                    colores = [colores stringByAppendingString:[NSString stringWithFormat:@"_%@",order.colour3]];
                colores =[colores stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
                imagen = [[[Util convertCover:order.cover] stringByAppendingString:[NSString stringWithFormat:@"_%@",order.model]] stringByAppendingString:[NSString stringWithFormat:@"_%@.jpg",colores]];
                if([order.model containsString:@"-"]){
                        _imagenModelo = imagen;
                }else{
                    imagen = _imagenModelo;
                }
                }
                cell.imageTitle.image = [UIImage imageNamed:imagen];
                if(cell.imageTitle.image == nil){
                    NSString *aux2= [[order.model componentsSeparatedByString:@"_"] objectAtIndex:0];
                    NSString *aux =@"bkmini_";
                    if([order.cover isEqualToString:@"AK"]){
                        aux = @"ak_";
                    }else if([order.cover isEqualToString:@"BK"]){
                        aux = @"bk_";
                    }
                     cell.imageTitle.image = [UIImage imageNamed:[aux stringByAppendingString:[aux2 stringByAppendingString:@"_custom.jpg"]]];
                }
            }
        }else if(indexPath.section ==3){
            if([order.colour1 isEqualToString:@""]){
                cell.imageFull.image = [UIImage imageNamed:@"colores.jpg"];                
                cell.imageFull.hidden = NO;
                cell.imageTitle.hidden= YES;
                cell.labelTitle.hidden= YES;
            }else{
                cell.imageFull.hidden = YES;
                cell.imageTitle.hidden= NO;
                cell.labelTitle.hidden= NO;
                NSString *imagen =@"";
                if([order.model containsString:@"-"]){

                NSString *colores = order.colour1;
                if(order.colour2 && ![order.colour2 isEqualToString:@""])
                    colores =[colores stringByAppendingString:[NSString stringWithFormat:@"_%@",order.colour2]];
                if(order.colour3 && ![order.colour3 isEqualToString:@""])
                   colores = [colores stringByAppendingString:[NSString stringWithFormat:@"_%@",order.colour3]];
                colores =[colores stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
                cell.labelTitle.text = colores;
                imagen = [[[Util convertCover:order.cover] stringByAppendingString:[NSString stringWithFormat:@"_%@",order.model]] stringByAppendingString:[NSString stringWithFormat:@"_%@.jpg",colores]];
                    _imagenColor = imagen;                    
                UIImage *image = [UIImage imageNamed:imagen];
                if(image==nil){
                    imagen = [[[Util convertCover:order.cover] stringByAppendingString:[NSString stringWithFormat:@"_%@",order.model]] stringByAppendingString:@"_custom.jpg"];
                    _imagenColor = imagen;
                }
                }else{
                    imagen = _imagenColor;
                }
                cell.imageTitle.image = [UIImage imageNamed:imagen];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==2){
        _isColor = false;
        [self performSegueWithIdentifier:segueStep1Detail sender:nil];
    }if(indexPath.section ==3){
        SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
        if ([order.model isEqualToString:@""]) {
            [[[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Select model, please" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }else{
            _isColor = true;
            [self performSegueWithIdentifier:segueStep1Detail sender:nil];
        }
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:segueStep1Detail]){
    DetailModelColorTableViewController * detail = segue.destinationViewController;
        detail.isColor = _isColor;
    }if([segue.identifier isEqualToString:segueSelectMeasure]){
        SelectableTableViewController *selectMeasure = segue.destinationViewController;
        selectMeasure.isMeasurement = YES;
    }
}


-(void)titles{
    if([[Util loadKey:kMode] isEqualToString:modeDemo]){
        self.title=@"DEMO";
    }else
        self.title = @"STEP 1/3";
    _titlesSection=@[@"CLINICIAN NAME",@"PATIENT NAME",@"DESIGNS",@"COLORS"];
    if ([[Util loadKey:kMode]  isEqualToString:modeDemo]){
        _titlesSection=@[@"CLINICIAN NAME",@"DEMO REFERENCE",@"DESIGNS",@"COLORS"];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 3)
        return 80.0f;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section <2)
        return 60;
    else if(indexPath.section ==2)
        return 160;
    else if(indexPath.section ==3)
        return 160;
    return 0;
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor whiteColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==3){
        UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 80)];
        [footerView setBackgroundColor:[UIColor blackColor]];
        UIButton *addguardar=[UIButton buttonWithType:UIButtonTypeCustom];
        if([[Util loadKey:kMode] isEqualToString:modeDemo])
            [addguardar setTitle:@"ORDER" forState:UIControlStateNormal];
        else
            [addguardar setTitle:@"NEXT" forState:UIControlStateNormal];
        [addguardar addTarget:self action:@selector(addguardar:) forControlEvents:UIControlEventTouchUpInside];
        [addguardar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
//        addguardar.frame=CGRectMake(self.tableView.frame.size.width/2 -50, 5, 100, 30); //set some large width to ur title
        addguardar.frame = footerView.frame;
        [footerView addSubview:addguardar];
        return footerView;
    }else return nil;
}

- (void)addguardar:(id)sender{
    [self.tableView endEditing:YES];
    if([self validate]){
        if([[Util loadKey:kMode] isEqualToString:modeDemo]){
            [JTProgressHUD show];
            [[WSService instance] editOrder:self];
        }else if([[Util loadKey:kMode] isEqualToString:modePatient]){
            [self performSegueWithIdentifier:segueSelectMeasure sender:nil];
        }
        
    }
}

-(void)editOrderrHandler:(id)value{
    [JTProgressHUD hide];
    SDZOrderrWS *orderWS = (SDZOrderrWS *)value;
    NSString *titulo= @"Oops!";
    NSString * mensaje =@"Error, please try again";
    if(orderWS._id > 0){
        UIAlertController *alertController =    [UIAlertController
                                                 alertControllerWithTitle:@"Order Sent"
                                                 message:@"This order is a DEMO"
                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action) {
                                           [self.navigationController popToRootViewControllerAnimated:YES];
                                       }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }else{
        [Util alertInfo:self title:titulo text:mensaje];
    }
    
}

-(bool) validate{
    bool isError = false;
    SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
    NSString *error = @"Please insert required information:\n";
    if(!order.cpo_name || [order.cpo_name isEqualToString:@""]){
        isError = true;
        error = [error stringByAppendingString:@"CLINICIAN name\n"];
    }if(!order.patient || [order.patient isEqualToString:@""]){
                isError = true;
        if ([[Util loadKey:kMode]  isEqualToString:modeDemo]){
            error = [error stringByAppendingString:@"Demo reference\n"];}
        else{
                    isError = true;
            error = [error stringByAppendingString:@"Patient name\n"];}
    }if(!order.model || [order.model isEqualToString:@""]){
                isError = true;
        error = [error stringByAppendingString:@"Model\n"];
    }if(!order.colour1 || [order.colour1 isEqualToString:@""]){
                isError = true;
        error = [error stringByAppendingString:@"Color\n"];
    }
    if(isError)
    {
        [[[UIAlertView alloc]initWithTitle:@"Oops!" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return false;
    }
    return  true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
    UITableViewCell *cell= (UITableViewCell *)textField.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath !=nil){
    if(indexPath.section ==0){
        order.cpo_name = textField.text;
    }else if(indexPath.section ==1){
        order.patient = textField.text;
    }
    
    [Util saveObject:order file:fileObjects];
    }
    return YES;
}


@end
