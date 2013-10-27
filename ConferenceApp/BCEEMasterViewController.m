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
    NSMutableArray *_timeSlots;
}
@end

@implementation BCEEMasterViewController

#pragma mark - Managing informations on sessions

- (void)setTimeSlots:(NSMutableArray *)newTimeSlots
{
    if (_timeSlots != newTimeSlots) {
        _timeSlots = newTimeSlots;
        
        //_lblName.text = newDetailItem.location;
        
        // Update the view.
        //[self configureView];
    }
}

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
    // Navigation bar bg
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"navbar_bg.png"]];
    self.navigationController.navigationBar.backgroundColor = background;
    
  //  self.tableView.backgroundColor = [UIColor clearColor];
  //  self.parentViewController.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.58 blue:0.0 alpha:1.0];
    
    [super viewDidLoad];
    
   // self.parentViewController.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    

    
    self.detailViewController = (BCEEDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_timeSlots count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_timeSlots[section] sessions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    BCEESession *session = [_timeSlots[indexPath.section] sessions][indexPath.row];
    NSString *sessionName = [session name];
    cell.textLabel.text = sessionName;
   // cell.textLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
  //  cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.68 blue:0.1 alpha:1.0];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (NSString*)tableView: (UITableView*)tableView titleForHeaderInSection: (NSInteger)section {
    return [[_timeSlots objectAtIndex: section]timeSlot] ;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        BCEESession *session = [_timeSlots[indexPath.section] sessions][indexPath.row];
        self.detailViewController.detailItem = session;
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BCEESession *session = [_timeSlots[indexPath.section] sessions][indexPath.row];
        [[segue destinationViewController] setDetailItem:session];
    }
}

@end
