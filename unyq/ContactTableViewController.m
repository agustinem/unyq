//
//  ContactTableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "ContactTableViewController.h"
#import "DetailContactTableViewController.h"
#import "ColImageTableViewCell.h"
#import "RegisterTableViewController.h"
#import "BDService.h"
#import "Constants.h"
#import "User.h"
#import "SDZUserWS.h"
@interface ContactTableViewController ()

@property NSArray *fotos;
@property NSArray *titles;
@property bool isUSA;
@property     UIBarButtonItem *btnReload ;
@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles =@[@"",@"DOWNLOAD PRICES",@"TUTORIAL AK",@"TUTORIAL BK",@"TUTORIAL BK MINI"];
    _fotos = @[@"MOREINFOPAGE_contacteu.jpg",@"MOREINFOPAGE_contactus.jpg",@"MOREINFOPAGE_pricedollar.jpg",@"MOREINFOPAGE_priceeuro.jpg",@"MOREINFOPAGE_video.jpg",@"MOREINFOPAGE_guide.jpg",@"MOREINFOPAGE_video.jpg",@"MOREINFOPAGE_guide.jpg",@"MOREINFOPAGE_video.jpg",@"MOREINFOPAGE_guide.jpg"];
    
    _btnReload = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(btnReloadPressed:)];
    _btnReload.enabled=TRUE;
    _btnReload.style=UIBarButtonSystemItemRefresh;
}


-(void)btnReloadPressed:(id)value{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegisterTableViewController *registerVC = (RegisterTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"registerController"];
    
    User *user =[[BDService instance]getUSer:[Util loadKey:kIdUser]];
    registerVC.valueSection0 = [[NSMutableArray alloc] initWithArray:@[user.clinic_name,@"",@"",@"",@"",@""]];
    registerVC.valueSection1 = [[NSMutableArray alloc] initWithArray:@[user.bill_street,user.bill_city,user.bill_country,user.bill_zipcode,user.bill_contact,user.bill_phone]];
    registerVC.valueSection2 = [[NSMutableArray alloc] initWithArray:@[@"",user.vat, user.ship_street,user.ship_city,user.ship_country,user.ship_zipcode,user.ship_contact,user.ship_phone]];
    registerVC.valueSection3 = [[NSMutableArray alloc] initWithArray:@[user.cpo_name,user.cpo_email,@"",@"",@"",@"",@""]];
    registerVC.userRegister = user;
     [self.navigationController presentViewController:registerVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = _btnReload;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return 0;
    else
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor whiteColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_titles objectAtIndex:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT/5;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCellStep1" forIndexPath:indexPath];
    if(indexPath.section ==0){
        cell.imageCol1.image = [UIImage imageNamed:_fotos[0]];
        cell.imageCol2.image = [UIImage imageNamed:_fotos[1]];
        cell.buttonOdd.tag = 10;
        cell.buttonPar.tag = 11;
    }else if(indexPath.section ==1){
        cell.imageCol1.image = [UIImage imageNamed:_fotos[2]];
        cell.imageCol2.image = [UIImage imageNamed:_fotos[3]];
        cell.buttonOdd.tag = 12;
        cell.buttonPar.tag = 13;
    }else if(indexPath.section ==2){
        cell.imageCol1.image = [UIImage imageNamed:_fotos[4]];
        cell.imageCol2.image = [UIImage imageNamed:_fotos[5]];
        cell.buttonOdd.tag = 14;
        cell.buttonPar.tag = 15;
    }else if(indexPath.section ==3){
        cell.imageCol1.image = [UIImage imageNamed:_fotos[4]];
        cell.imageCol2.image = [UIImage imageNamed:_fotos[5]];
        cell.buttonOdd.tag = 16;
        cell.buttonPar.tag = 17;
    }else if(indexPath.section ==4){
        cell.imageCol1.image = [UIImage imageNamed:_fotos[4]];
        cell.imageCol2.image = [UIImage imageNamed:_fotos[5]];
        cell.buttonOdd.tag = 18;
        cell.buttonPar.tag = 19;
        
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailContactTableViewController *contact = [segue destinationViewController];
    contact.isUS = _isUSA;
}


- (IBAction)actionBoton1:(id)sender {
    UIButton *button = (UIButton *)sender;
    if(button.tag ==10){
        _isUSA =false;
            [self performSegueWithIdentifier:@"detailContact" sender:nil];
    }else if(button.tag ==11){
        _isUSA = true;
        [self performSegueWithIdentifier:@"detailContact" sender:nil];
    }else if(button.tag ==12){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLDolars]];
    }else if(button.tag ==13){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLEuros]];
    }else if(button.tag ==14){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLVideoAK]];
    }else if(button.tag ==15){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLGuideAK]];
    }else if(button.tag ==16){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLVideo]];
    }else if(button.tag ==17){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLGuide]];
    }else if(button.tag ==18){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLVideoBKMini]];
    }else if(button.tag ==19){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLGuideBKMini]];
    }
    
}
@end
