//
//  RegsitroTableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "RegisterTableViewController.h"
#import "Constants.h"
#import "WSService.h"
#import "BDService.h"
#import "SDZUserWS.h"
#import "User.h"
@interface RegisterTableViewController () <UITextFieldDelegate>

@property NSArray *labelClinic;
@property NSArray *labelAddreess;
@property NSArray *labelShipping;
@property NSArray *labelShippingAddress;
@property NSArray *labelContact;
@property NSArray *labelSections;
@property UISwitch *onoff;
@property int tagTF;
@end

@implementation RegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _onoff = [[UISwitch alloc] initWithFrame: CGRectZero];
    [_onoff setSelected:YES];
    [_onoff addTarget: self action: @selector(showAddress:) forControlEvents: UIControlEventValueChanged];
    [self titles];
}

-(void)showAddress:(id)value{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _labelSections[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self calculateRowSections:section];
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor whiteColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
    if(section ==0)
        header.textLabel.textAlignment = NSTextAlignmentCenter;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellFormText";
    static NSString *identifier2 = @"cellFormCheck";
    NSArray *sectionArray = [self sectionArray:(NSInteger)indexPath.section];
    NSArray *sectionValueArray = [self sectionValueArray:(NSInteger)indexPath.section];
    if(indexPath.section == 2 && indexPath.row== 0){
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
    if(cell2 ==nil){
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
            cell2.accessoryView = _onoff;
            cell2.textLabel.text = sectionArray[indexPath.row];
    }
        return cell2;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell ==nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, 0, SCREEN_WIDTH*0.9, 40)];
            textField.delegate = self;
            textField.borderStyle = UITextBorderStyleNone;
            cell.accessoryView = textField;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ((UITextField*)cell.accessoryView).placeholder = sectionArray[indexPath.row];
        if([sectionValueArray count]>indexPath.row)
            ((UITextField*)cell.accessoryView).text = sectionValueArray[indexPath.row];
        else
            ((UITextField*)cell.accessoryView).text = nil;
        return cell;
    }
}




#pragma mark -OK button


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 3)
        return 60.0f;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==3){
        UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
        [footerView setBackgroundColor:[UIColor blackColor]];
        UIButton *addguardar=[UIButton buttonWithType:UIButtonTypeCustom];
        [addguardar setTitle:@"Save" forState:UIControlStateNormal];
        [addguardar addTarget:self action:@selector(addguardar:) forControlEvents:UIControlEventTouchUpInside];
        [addguardar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
        addguardar.frame=CGRectMake(self.tableView.frame.size.width/2 -50, 5, 100, 30); //set some large width to ur title
        [footerView addSubview:addguardar];
        return footerView;
    }else return nil;
}

- (void)addguardar:(id)sender{
    [self.tableView endEditing:YES];
        [JTProgressHUD show];
        [[WSService instance]editUser:self user:_userRegister];
    
}

-(bool) validate{
    bool isError = false;
    NSString *error = @"Error register:\n";
    if(!_userRegister.clinic_name || [_userRegister.clinic_name isEqualToString:@""]){
        isError=true;
        error = [error stringByAppendingString:@"Clinic name\n"];
    }if(!_userRegister.cpo_name || [_userRegister.cpo_name isEqualToString:@""]){
        isError=true;
        error = [error stringByAppendingString:@"CLINICIAN name\n"];
    }if(!_userRegister.cpo_email || [_userRegister.cpo_email isEqualToString:@""]){
        isError=true;
        error = [error stringByAppendingString:@"CPO email\n"];
    }
    if(isError)
    {
        [[[UIAlertView alloc]initWithTitle:@"Oops!" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return false;
    }
    
    if(_onoff.on){
        _userRegister.ship_street = _userRegister.bill_street;
        _userRegister.ship_city = _userRegister.bill_city;
        _userRegister.ship_contact = _userRegister.bill_contact;
        _userRegister.ship_country = _userRegister.bill_country;
        _userRegister.ship_phone = _userRegister.bill_phone;
        _userRegister.ship_zipcode = _userRegister.bill_zipcode;
    }
    return  true;
}

-(void)editUserHandler:(id)value{
    SDZUserWS *userWS = (SDZUserWS *)value;
    NSString *titulo= @"Oops!";
    NSString * mensaje =@"Error, please try again";
    if([userWS._id intValue] > 0){
        [[BDService instance] addUser:userWS];
        [Util saveKey:kIsFirstLogin value:@"RegistrOK"];
        [Util saveKey:kIdUser value:userWS._id];
        [[WSService instance] registerDevice:self];
    }else{
        [JTProgressHUD hide];
        [Util alertInfo:self title:titulo text:mensaje];
    }
}

-(void)registerDeviceHandler:(id)value{
    if([value isEqualToString:@"1"]){
        [Util saveKey:kRegisterDevice value:@"OK"];
    }
    [JTProgressHUD hide];
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)titles{
    if(_userRegister!=nil){
        _labelSections = @[@"MY INFO",@"BILLING ADDRESS",@"SHIPPING ADDRESS",@"CONTACT PERSON"];
    }else
        _labelSections = @[@"SIGN IN",@"BILLING ADDRESS",@"SHIPPING ADDRESS",@"CONTACT PERSON"];
    _labelAddreess = @[@"Street",@"City",@"Country",@"Zip code",@"Contact person",@"Phone"];
    _labelContact = @[@"CLINICIAN name",@"CLINICIAN email"];
    _labelClinic =@[@"Hub/Clinic name"];
    _labelShipping=@[@"Same as billing",@"VAT number"];
    _labelShippingAddress=@[@"Same as billing",@"VAT number",@"Street",@"City",@"Country",@"Zip code",@"Contact person",@"Phone"];
    [_onoff setOn:true];
    if(_valueSection0==nil){
    _valueSection0 = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@""]];
    _valueSection1 = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@""]];
    _valueSection2 = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    _valueSection3 = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@""]];
        AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context= [appDelegate managedObjectContext];
        _userRegister = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        
    }

}

-(NSInteger)calculateRowSections:(NSInteger)section{
    switch (section) {
        case 0:{
            return 1;
            break;
        }
        case 1:{
            return [_labelAddreess count];
            break;
        }
        case 2:{
            if (_onoff.on) {
                return [_labelShipping count];
            }else{
                return [_labelShippingAddress count];
            }
            break;
        }
        case 3:{
            return [_labelContact count];
            break;
        }
            
        default:
            break;
    }
    return 0;
}

-(NSArray *) sectionArray:(NSInteger)section{
    switch (section) {
        case 0:
            return _labelClinic;
            break;
        case 1:
            return _labelAddreess;
            break;
        case 2:{
            return _labelShippingAddress;
            break;
        }case 3:
            return _labelContact;
            break;
        default:
            return nil;
            break;
    }
}

-(NSMutableArray *) sectionValueArray:(NSInteger)section{
    switch (section) {
        case 0:
            return _valueSection0;
            break;
        case 1:
            return _valueSection1;
            break;
        case 2:{
                return _valueSection2;
            break;
        }case 3:
                return _valueSection3;
            break;
        default:
            return nil;
            break;
    }
}


#pragma mark -
#pragma mark textfields delegate


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    UITableViewCell *cell= (UITableViewCell *)textField.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath!=nil){
    if(indexPath.section ==0){
        _userRegister.clinic_name = textField.text;
    [_valueSection0 setObject:textField.text atIndexedSubscript:indexPath.row];
    }else if(indexPath.section ==1){
        if(indexPath.row == 0){
            _userRegister.bill_street = textField.text;
        }else if (indexPath.row == 1){
            _userRegister.bill_city = textField.text;
        }else if (indexPath.row == 2){
            _userRegister.bill_country = textField.text;
        }else if (indexPath.row == 3){
            _userRegister.bill_zipcode = textField.text;
        }else if (indexPath.row == 4){
            _userRegister.bill_contact = textField.text;
        }else if (indexPath.row == 5){
            _userRegister.bill_phone = textField.text;
        }
    [_valueSection1 setObject:textField.text atIndexedSubscript:indexPath.row];
    }else if(indexPath.section ==2){
        if(indexPath.row == 1){
            _userRegister.vat = textField.text;
        } if (indexPath.row == 2){
            _userRegister.ship_street = textField.text;
        }else if (indexPath.row == 3){
            _userRegister.ship_city = textField.text;
        }else if (indexPath.row == 4){
            _userRegister.ship_country = textField.text;
        }else if (indexPath.row == 5){
            _userRegister.ship_zipcode = textField.text;
        }else if (indexPath.row == 6){
            _userRegister.ship_contact = textField.text;
        }else if (indexPath.row == 7){
            _userRegister.ship_phone = textField.text;
        }
    [_valueSection2 setObject:textField.text atIndexedSubscript:indexPath.row];
    }else if(indexPath.section ==3){
        if(indexPath.row == 0){
            _userRegister.cpo_name = textField.text;
        }else if (indexPath.row == 1){
            _userRegister.cpo_email = textField.text;
        }
    [_valueSection3 setObject:textField.text atIndexedSubscript:indexPath.row];
    }
    }
    return YES;
}

@end
