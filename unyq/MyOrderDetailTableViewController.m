//
//  MyOrderDetailTableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "MyOrderDetailTableViewController.h"

@interface MyOrderDetailTableViewController ()

@property NSArray *titles;
@property NSArray *values;
@end

@implementation MyOrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"ORDER DATE",@"ORDER DETAILS",@"SERIAL NUMBER",@"STATUS",@"ESTIMATED DELIVERY DATE"];

    NSString *colores = _selectedOrder.colour1;
    if([colores length]>1){
        if(_selectedOrder.colour2 && ![_selectedOrder.colour2 isEqualToString:@""])
            colores =[colores stringByAppendingString:[NSString stringWithFormat:@"_%@",_selectedOrder.colour2]];
        if(_selectedOrder.colour3 && ![_selectedOrder.colour3 isEqualToString:@""])
            colores = [colores stringByAppendingString:[NSString stringWithFormat:@"_%@",_selectedOrder.colour3]];
    }
//        colores =[colores stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
    NSString *auxModel = _selectedOrder.model;
    if([_selectedOrder.model containsString:@"-"])
        auxModel = [[_selectedOrder.model componentsSeparatedByString:@"-"] objectAtIndex:1];
        NSString *reference = [NSString stringWithFormat:@"%@ %@ %@",_selectedOrder.cover,auxModel,colores];
        _values =@[_selectedOrder.order_date,reference,_selectedOrder.serialnumber,_selectedOrder.status, _selectedOrder.estimated_date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor whiteColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_selectedOrder.patient stringByAppendingString:[NSString stringWithFormat:@"\n%@",_selectedOrder.order_date]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titles count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellident = @"identifierdetail";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellident];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellident];
    }
    cell.textLabel.text =[_titles objectAtIndex:indexPath.row];
    cell.detailTextLabel.text =[_values objectAtIndex:indexPath.row];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
