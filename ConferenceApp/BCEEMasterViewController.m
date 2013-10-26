//
//  BCEEMasterViewController.m
//  ConferenceApp
//
//  Created by Arianne Dee on 2013-10-25.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import "BCEEMasterViewController.h"
#import "BCEEDetailViewController.h"
#import "BCEETimeSlot.h"

@interface BCEEMasterViewController () {
    NSMutableArray *_sessions;
    NSMutableArray *_sessionGroups;
    NSMutableArray *_timeSlots;
}
@end

@implementation BCEEMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    
    self.detailViewController = (BCEEDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    _sessions = [[NSMutableArray alloc] initWithObjects:@(1), @(3), @"Hello", nil];
    
    // Create Test Session Groups
    _sessionGroups = [[NSMutableArray alloc] init];
    NSMutableArray *session1 = [[NSMutableArray alloc] initWithObjects:@"Session1", @"Session2", @"Session3", nil];
    BCEETimeSlot *timeSlot1 = [[BCEETimeSlot alloc] initTimeSlot:@"Time Slot 1" withSessions:session1];
    NSMutableArray *session2 = [[NSMutableArray alloc] initWithObjects:@"Session4", @"Session5", nil];
    BCEETimeSlot *timeSlot2 = [[BCEETimeSlot alloc] initTimeSlot:@"Time Slot 2" withSessions:session2];
    _timeSlots = [[NSMutableArray alloc] initWithObjects:timeSlot1, timeSlot2, nil];

    _sessionGroups[0] = session1;
    _sessionGroups[1] = session2;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    
//}
//- (void)viewDidDisappear:(BOOL)animated
//{
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_sessions) {
        _sessions = [[NSMutableArray alloc] init];
    }
    [_sessions insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sessionGroups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sessionGroups[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //NSDate *object = _sessions[indexPath.row];
    //cell.textLabel.text = [object description];
    
    //NSString *sessionName = _sessionGroups[indexPath.section][indexPath.row];
    NSString *sessionName = [_timeSlots[indexPath.section] sessions][indexPath.row];
    cell.textLabel.text = sessionName;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_sessions removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (NSString*)tableView: (UITableView*)tableView titleForHeaderInSection: (NSInteger)section {
    return [[_timeSlots objectAtIndex: section] timeSlot];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //NSDate *object = _sessions[indexPath.row];
        NSString *sessionName = [_timeSlots[indexPath.section] sessions][indexPath.row];
        self.detailViewController.detailItem = sessionName;
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _sessions[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
