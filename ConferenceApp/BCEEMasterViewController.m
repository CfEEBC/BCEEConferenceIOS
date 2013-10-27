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
    
    self.detailViewController = (BCEEDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // Create Test Session Groups
    BCEESession *session1 = [[BCEESession alloc] initWithName:@"Session A" Description:@"UBC Hackathon" Location:@"ICICS" Speakers:@"Kim, Kurt" Biography:@"They are awesome professors :)" surveyLink:@"http://www.engadget.com/" startTime:[NSDate date] endTime:[NSDate date]];
    BCEESession *session2 = [[BCEESession alloc] initWithName:@"Session B" Description:@"UBC Hackathon" Location:@"ICICS" Speakers:@"Kim, Kurt" Biography:@"They are awesome professors :)" surveyLink:@"http://www.arstechnica.com/" startTime:[NSDate date] endTime:[NSDate date]];
    BCEESession *session3 = [[BCEESession alloc] initWithName:@"Session C" Description:@"UBC Hackathon" Location:@"ICICS" Speakers:@"Kim, Kurt" Biography:@"They are awesome professors :)" surveyLink:@"http://www.google.com/" startTime:[NSDate date] endTime:[NSDate date]];
    BCEESession *session4 = [[BCEESession alloc] initWithName:@"Session D" Description:@"UBC Hackathon" Location:@"ICICS" Speakers:@"Kim, Kurt" Biography:@"They are awesome professors :)" surveyLink:@"http://www.yahoo.com/" startTime:[NSDate date] endTime:[NSDate date]];
    BCEETimeSlot *timeSlot1 = [[BCEETimeSlot alloc] initTimeSlot:@"Time Slot 1" withSessions:[[NSMutableArray alloc] initWithObjects:session1, session2, nil]];
    BCEETimeSlot *timeSlot2 = [[BCEETimeSlot alloc] initTimeSlot:@"Time Slot 2" withSessions:[[NSMutableArray alloc] initWithObjects:session3, nil]];
    _timeSlots = [[NSMutableArray alloc] initWithObjects:timeSlot1, timeSlot2, nil];
    
    // Testing Adding sessions with TimeSlot
    [timeSlot2 addSession:session4];

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

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (NSString*)tableView: (UITableView*)tableView titleForHeaderInSection: (NSInteger)section {
    return [[_timeSlots objectAtIndex: section] timeSlot];
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
