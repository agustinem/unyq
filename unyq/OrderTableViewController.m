//
//  OrderTableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//
#import "Constants.h"
#import "SDZOrderrWS.h"
#import "OrderTableViewController.h"
#import "SelectableTableViewController.h"
@interface OrderTableViewController ()

@property NSArray *imagesName;
@property NSInteger heightCell;
@end

@implementation OrderTableViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = nil;}


- (void)viewDidLoad {
    [super viewDidLoad];
    _heightCell = SCREEN_HEIGHT/4-40;
    self.title =@"Order";
    _imagesName = @[@"ORDER_PAGE_ak.jpg",@"ORDER_PAGE_bk.jpg",@"ORDER_PAGE_bkmini.jpg",@"ORDER_PAGE_ux.jpg"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _heightCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellImage = @"cellImage";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellImage];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellImage];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _heightCell)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.accessoryView = imageView;        
    }
    ((UIImageView *)cell.accessoryView).image = [UIImage imageNamed:[_imagesName objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==3){
        [Util alertInfo:self title:@"Coming soon" text:@"Coming soon"];
    }else{
        [self selectForm:indexPath];
        [self performSegueWithIdentifier:segueSelectDemo sender:nil];
    }
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
    SelectableTableViewController *selectVC = (SelectableTableViewController *)segue.destinationViewController;
    selectVC.isLeg = false;
}

-(void)selectForm:(NSIndexPath *)indexPath{
    SDZOrderrWS *orderSelect = [SDZOrderrWS new];
    if(indexPath.row == 0){
        orderSelect.cover = @"AK";
    }else if(indexPath.row == 1){
        orderSelect.cover = @"BK";
    }else if(indexPath.row == 2){
        orderSelect.cover = @"BK mini";
    }
    [Util saveObject:orderSelect file:fileObjects];
}
@end
