//
//  Step2TableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "Step2TableViewController.h"
#import "Step2TableViewCell.h"
#import "SDZOrderrWS.h"
#import "Constants.h"
#import "WSService.h"
@interface Step2TableViewController () <UITextFieldDelegate>
@property NSIndexPath *indexPath1;
@property NSIndexPath *indexPath2;
@property NSString *length1;
@property NSString *length2;
@property NSString *knee;
@end

@implementation Step2TableViewController

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [super viewDidLoad];
    self.title = @"STEP 2/3";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.view layoutIfNeeded];
    [self.tableView layoutIfNeeded];
    Step2TableViewCell *cell = (Step2TableViewCell *)[self.tableView cellForRowAtIndexPath:_indexPath1];
    
    [Util setRoundedView:cell.viewRound toDiameter:cell.viewRound.frame.size.height];
    [Util setRoundedView:cell.viewRound2 toDiameter:cell.viewRound.frame.size.height];
    [Util setRoundedView:cell.viewRound3 toDiameter:cell.viewRound.frame.size.height];
    [Util setRoundedView:cell.viewRound4 toDiameter:cell.viewRound.frame.size.height];
    [Util setRoundedView:cell.viewRound5 toDiameter:cell.viewRound.frame.size.height];
    [Util setRoundedView:cell.viewRound5 toDiameter:cell.viewRound.frame.size.height];
    SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
    if([order.cover isEqualToString:@"AK"]){
        Step2TableViewCell *cell = (Step2TableViewCell *)[self.tableView cellForRowAtIndexPath:_indexPath2];
        [Util setRoundedView:cell.viewround6 toDiameter:cell.viewround6.frame.size.height];
        [Util setRoundedView:cell.viewRound7 toDiameter:cell.viewround6.frame.size.height];
    }
    [self clearAll];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
    if([order.cover isEqualToString:@"AK"]){
        return 3;
    }else
        return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int substring = ([[Util loadKey:kMeas] isEqualToString: @"cm"]) ? 2:6;
     SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
    NSArray *valores = [order.knee_ankle_axis componentsSeparatedByString:@"*"];
    if(indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"step2cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else     if(indexPath.row == 1){
        Step2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"step2cell2" forIndexPath:indexPath];
        _indexPath1 = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lengthTF.delegate = self;
        cell.maxTF.delegate= self;
        cell.midTF.delegate= self;
        cell.topTF.delegate= self;
        cell.lowerTF.delegate= self;
        if([valores count]>0 && ![valores[0] isEqualToString:@"(null)"])
            cell.lengthTF.text = ([valores[0] containsString:[Util loadKey:kMeas]])? [valores[0] substringToIndex:[valores[0] length]-substring]:@"";
        else
            cell.lengthTF.text = @"";

        cell.maxTF.text= ([order.max_calf containsString:[Util loadKey:kMeas]])? [order.max_calf substringToIndex:[order.max_calf length]-substring]:@"";
        cell.midTF.text= ([order.mid_calf containsString:[Util loadKey:kMeas]])?[order.mid_calf substringToIndex:[order.mid_calf length]-substring]:@"";
        cell.topTF.text= ([order.top_calf containsString:[Util loadKey:kMeas]])?[order.top_calf substringToIndex:[order.top_calf length]-substring]:@"";
        cell.lowerTF.text= ([order.low_calf containsString:[Util loadKey:kMeas]])?[order.low_calf substringToIndex:[order.low_calf length]-substring]:@"";
        
        return cell;
    }else if(indexPath.row==2){
        Step2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"step2cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _indexPath2 = indexPath;
        cell.length2.delegate=self;
        cell.kneetf.delegate=self;
        
        if([valores count]>2 && ![valores[0] isEqualToString:@"(null)"]){
            cell.length2.text=([valores[1] length]== substring)?[valores[1] substringToIndex:[valores[1] length]-substring]:@"";
            cell.kneetf.text=([valores[2] length]== substring)?[valores[2] substringToIndex:[valores[2] length]-substring]:@"";
        }else{
            cell.length2.text=@"";
            cell.kneetf.text=@"";
        }
        return cell;
    }
    return nil;
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"YOUR MEASUREMENTS";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor whiteColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 80)];
    
    [footerView setBackgroundColor:[UIColor blackColor]];
    UIButton *addguardar=[UIButton buttonWithType:UIButtonTypeCustom];
    [addguardar setTitle:@"NEXT" forState:UIControlStateNormal];
    [addguardar addTarget:self action:@selector(addguardar:) forControlEvents:UIControlEventTouchUpInside];
    [addguardar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
    addguardar.frame = footerView.frame;
    [footerView addSubview:addguardar];
    return footerView;
}

- (void)addguardar:(id)sender{
    [self.tableView endEditing:YES];
    if([self validate]){
        [JTProgressHUD show];
        [[WSService instance] editOrder:self];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){return  300;}
    if(indexPath.row==1){
        return 200;
    }if(indexPath.row==2){return 400;}return 0;
}


-(void)editOrderrHandler:(id)value{
    [JTProgressHUD hide];
    SDZOrderrWS *orderWS = (SDZOrderrWS *)value;
    if(orderWS._id > 0){
        [Util saveObject:orderWS file:fileObjects];
        [self performSegueWithIdentifier:segueStep3 sender:nil];
    }else{
        [Util alertErrorConexion:self];
        [JTProgressHUD hide];
    }
    
}



-(bool) validate{
    bool isError= false;
    SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
    
    NSString *error = @"";
    if((!order.low_calf || [order.low_calf isEqualToString:@""])||
       (!order.mid_calf || [order.mid_calf isEqualToString:@""])||
       (!order.top_calf || [order.top_calf isEqualToString:@""])||
       (!order.max_calf || [order.max_calf isEqualToString:@""])||
       (!order.amp_side || [order.amp_side isEqualToString:@""])
       ){
        isError=true;
    }
    if([order.cover isEqualToString:@"AK"]){
        NSArray * array = [order.knee_ankle_axis componentsSeparatedByString:@"*"];
        for(NSString *cadena in array){
            if([cadena isEqualToString:@"(null)"] || [cadena isEqualToString:@""] )
                isError=true;
        }
    }
    if(isError)
    {
        error = [error stringByAppendingString:@"Please, insert measurements\n"];
        [[[UIAlertView alloc]initWithTitle:@"Oops!" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return false;
    }
    return  true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag > 14)
        [self.tableView scrollToRowAtIndexPath:_indexPath2 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    else
        [self.tableView scrollToRowAtIndexPath:_indexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
            NSString *text=@"";
    if (![textField.text isEqualToString:@""]) {
        text = [textField.text stringByAppendingString:[Util loadKey:kMeas] ];
    }
    
    if (textField.tag ==10) {
        _length1 = text;
        order.knee_ankle_axis = [NSString stringWithFormat:@"%@*%@*%@",text,order.knee_ankle_axis,text];
        order.amp_side = [Util loadKey:kLeg];
    }else if (textField.tag ==11) {
        order.low_calf = text;
    }else if (textField.tag ==12) {
        order.mid_calf = text;
    }else if (textField.tag ==13) {
        order.max_calf = text;
    }else if (textField.tag ==14) {
        order.top_calf = text;
    }else if (textField.tag ==15) {
        _length2 = text;
    }else if (textField.tag ==16) {
        _knee=text;
    }
    order.knee_ankle_axis= [NSString stringWithFormat:@"%@*%@*%@",_length1,_length2,_knee];
    [Util saveObject:order file:fileObjects];
    return YES;
}

- (IBAction)actionInfo:(id)sender {
    NSString *valor=@"";
    SDZOrderrWS *order =[[Util loadObjects:fileObjects] objectAtIndex:0];
    if([order.cover isEqualToString:@"AK"]){
        valor =@"·Knee-to-Ankle Axis:\nLength between center of knee and center of lateral ankle bone.\n\n·Mid Calf:\n50% of the knee-to-ankle measurement.\n\n·Lower Calf:\n25% of the knee-to-ankle measurement, as measured from the ankle up.\n\n·Top Calf:\n75% of the knee-to-ankle measurement, as measured from the ankle up\n\n·Max Calf:\nThe largest circumference of the sound leg. Usually located between mid and top calf.\n\n·Length:\nMeasure from bottom edge of prosthetic knee to top edge of foot shell.\n\n·Length at Max Heel Strike:\nWith patient putting all weight into heel, measure from rear edge of prosthetic knee to top rear edge of foot shell.";
    }else{
        valor =@"·Knee-to-Ankle Axis:\nLength between center of knee and center of lateral ankle bone.\n\n·Mid Calf:\n50% of the knee-to-ankle measurement.\n\n·Lower Calf:\n25% of the knee-to-ankle measurement, as measured from the ankle up.\n\n·Top Calf:\n75% of the knee-to-ankle measurement, as measured from the ankle up\n\n·Max Calf:\nThe largest circumference of the sound leg. Usually located between mid and top calf.";
        
    }
    [Util alertInfo:self title:@"INFO" text:valor];
    
}

- (void)keyboardWillShow:(NSNotification *)sender
{
    CGSize kbSize = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
        [self.tableView setContentInset:edgeInsets];
        [self.tableView setScrollIndicatorInsets:edgeInsets];
    }];
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        [self.tableView setContentInset:edgeInsets];
        [self.tableView setScrollIndicatorInsets:edgeInsets];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)clearAll
{
    SDZOrderrWS *order = [[Util loadObjects:fileObjects] objectAtIndex:0];
    order.amp_side  = @"";
    order.low_calf  = @"";
    order.mid_calf  = @"";
    order.max_calf = @"";
    order.top_calf = @"";
    order.knee_ankle_axis= @"(null)*(null)*(null)";
    _length2=@"";
    _length1=@"";
    _knee =@"";
    [Util saveObject:order file:fileObjects];
    [self.tableView reloadData];
}

@end






