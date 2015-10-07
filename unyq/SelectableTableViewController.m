//
//  SelectableTableViewController.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "SelectableTableViewController.h"
#import "Constants.h"
@interface SelectableTableViewController ()
@property NSArray *titles;
@end

@implementation SelectableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    if(_isMeasurement){
        _titles=@[@"INCHES",@"CM"];
        self.title =@"Select measurement";
    }else if(_isLeg){
        _titles=@[@"LEFT Prosthesis",@"RIGHT Prosthesis"];
        self.title =@"Select leg";
    }else{
        _titles=@[@"DEMO UNIT",@"PATIENT"];
        self.title =@"Select mode";        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT/2 -40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierSelect =@"selectIDCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierSelect];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierSelect];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:30];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [_titles objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger fileSelected = indexPath.row;
    if(_isMeasurement){
        (fileSelected == 0)?[Util saveKey:kMeas value:measIN]:[Util saveKey:kMeas value:measCM];
        [self performSegueWithIdentifier:segueStep2 sender:nil];

    }else if(_isLeg){
        
        (fileSelected == 0)?[Util saveKey:kLeg value:leftLeg]:[Util saveKey:kLeg value:rightLeg];
        [self performSegueWithIdentifier:segueStep1 sender:nil];
     }else{
        
        (fileSelected == 0)?[Util saveKey:kMode value:modeDemo]:[Util saveKey:kMode value:modePatient];
         if(fileSelected==0){
             [self performSegueWithIdentifier:segueStep1 sender:nil];
         }else{
             [self performSegueWithIdentifier:segueSelectLeg sender:nil];
         }

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
    if([segue.identifier isEqualToString:segueSelectLeg]){
        SelectableTableViewController *selectLeg = segue.destinationViewController;
        selectLeg.isLeg = true;
    }
}


@end
