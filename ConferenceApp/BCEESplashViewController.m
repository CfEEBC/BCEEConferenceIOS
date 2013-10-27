//
//  BCEESplashViewController.m
//  ConferenceApp
//
//  Created by sNapZ on 10/26/2013.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import "BCEESplashViewController.h"
#import "BCEEScheduleConnectionDelegate.h"
#import "BCEESession.h"
#import "BCEETimeSlot.h"

@interface BCEESplashViewController ()

@property (nonatomic, strong) NSMutableData * responseData;
@property (nonatomic, strong) NSMutableData * connection;


@end

@implementation BCEESplashViewController

@synthesize connection = _connection;
@synthesize responseData = _responseData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Call BCEEScheduleConnectionDelegate to get session schedule
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:SESSION_INFO_URL]];
    NSURLConnection * conn = [[NSURLConnection alloc] initWithRequest:request delegate:[[BCEEScheduleConnectionDelegate alloc] init]];
    [conn start];
    
}

- (void)onBCEEScheduleRecieved:(NSMutableArray *)receievedSchedule
{
    timeSlots = receievedSchedule;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onEnterClicked:(id)sender {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Pass the parsed session information to the Agenda view
    if ([[segue identifier] isEqualToString:@"showTimeSlots"]) {
        [[segue destinationViewController] setTimeSlots: timeSlots];
    }
}


@end
