//
//  MyOrderTableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "MyOrderTableViewController.h"
#import <JTProgressHUD/JTProgressHUD.h>
#import "WSService.h"
#import "BDService.h"
#import "SDZArrayOfOrderr.h"
#import "Order.h"
#import "Constants.h"
#import "MyOrderDetailTableViewController.h"

@interface MyOrderTableViewController ()

@property NSArray *pedidos;
@property Order *orderSelected;
@end

@implementation MyOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [JTProgressHUD show];
    _pedidos = [[BDService instance] getOrders];
    [[WSService instance]getAllOrderByUser:self];
        self.navigationController.topViewController.navigationItem.rightBarButtonItem = nil;
}

-(void)getAllOrderrByIduserHandler:(id)value{
    [JTProgressHUD hide];
    SDZArrayOfOrderr* result = (SDZArrayOfOrderr*)value;
    NSLog(@"getAllOrderrByIduser returned the value: %@", result);
    [[BDService instance] addOrders:result.orderrs];
    _pedidos = [[BDService instance] getOrders];
    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(_pedidos == nil)
        return 0;
    else
        return [_pedidos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellname = @"ident";
        Order *order =[_pedidos objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellname];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellname];
    cell.textLabel.text = [[order.patient stringByAppendingString:@" || "] stringByAppendingString:order.serialnumber];
    cell.detailTextLabel.text = order.order_date;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _orderSelected = [_pedidos objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailOrder" sender:nil];

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
    MyOrderDetailTableViewController *detail = segue.destinationViewController;
    detail.selectedOrder = _orderSelected;
}


@end
