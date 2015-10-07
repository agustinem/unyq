//
//  DetailContactTableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "DetailContactTableViewController.h"

#import "Constants.h"
@interface DetailContactTableViewController ()
@property NSArray *datos;
@property NSArray *labels;
@property NSArray *telefonos;

@end

@implementation DetailContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _telefonos =@[@"+1(866)2869773",@"(+34)955223425"];
        _labels=@[@"mapa",@"Phone",@"Email",@"Address"];
    if(_isUS){
        _datos =@[@"CONTACT_USA_map.jpg",@"+1 (866) 286-9773",@"hello@unyq.com",@"44 Tehama Street San Francisco, CA94105 USA"];
    }else{
        _datos =@[@"CONTACT_EU_map.jpg",@"(+34) 955 22 34 25",@"hello@unyq.com",@"Isaac Newton 4 41092 Seville Spain"];
    }
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

    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row ==0){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        image.image = [UIImage imageNamed:_datos[0]];
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:image];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        cell.textLabel.text = _labels[indexPath.row];
        cell.detailTextLabel.numberOfLines = 3;
        cell.detailTextLabel.text = _datos[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row ==1){
        if(_isUS){
        NSString *phoneNumber = [@"tel://" stringByAppendingString:_telefonos[0]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        }else{
            NSString *phoneNumber = [@"tel://" stringByAppendingString:_telefonos[1]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row ==0){
        return 300;
    }else
    return 80;
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
