//
//  BCEESplashViewController.m
//  ConferenceApp
//
//  Created by sNapZ on 10/26/2013.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import "BCEESplashViewController.h"
#import "BCEESession.h"
#import "BCEETimeSlot.h"

@interface BCEESplashViewController ()

@property (nonatomic, strong) NSMutableData * responseData;

@end

@implementation BCEESplashViewController

@synthesize responseData = _responseData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    sessionArray = [[NSMutableArray alloc] init];
    
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bceeconference.appspot.com/machine"]];
    NSURLConnection * conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    
    // Send a web request to the server.
    // Call the function connectionDidFinishLoading after done.
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *) connection {
    
    // Request Session Information Data from Server, parse it to an array of BCEETimeSlot.
    NSError * myerror = nil;
    NSArray * res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myerror];
    
    // Instantiate NSDateFormatter for parsing dates
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    // loop through JSON Dictionary and convert it into a BCEESession object
    for (int i = 0; i < [res count] ; i++){
        
        BCEESession *session = [[BCEESession alloc] init];
        NSDictionary * d = [res objectAtIndex:(i)];

        // loop through each key value in the dictionary
        for(id key in d){
            id value = [d objectForKey:key];
            
            NSString *keyAsString = (NSString *) key;
            NSString *valueAsString = (NSString *) value;
            
            if([keyAsString isEqualToString:@"session_name"]){
                [session setName:valueAsString];
            } else if([keyAsString isEqualToString:@"location"]){
                [session setLocation:valueAsString];
            } else if ([keyAsString isEqualToString:@"speakers"]){
                [session setSpeakers:valueAsString];
            } else if([keyAsString isEqualToString:@"stime"]){
                NSDate *start_time = [df dateFromString:valueAsString];
                [session setStartTime:start_time];
            } else if([keyAsString isEqualToString:@"etime"]){
                NSDate *end_time = [df dateFromString:valueAsString];
                [session setEndTime:end_time];
            } else if([keyAsString isEqualToString:@"description"]){
                [session setDescription:valueAsString];
            } else if([keyAsString isEqualToString:@"biography"]){
                [session setBiography:valueAsString];
            } else if([keyAsString isEqualToString:@"survey_link"]){
                [session setSurveyLink:valueAsString];
            }
            
        }
    
        [sessionArray addObject:session];
        
    }
    
    // sort the list of sessions by start time
    NSArray * sortedSessions = [sessionArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(BCEESession *)a startTime];
        NSDate *second = [(BCEESession *)b startTime];
        return [first compare:second];
    }];
    
    // group sessions with the same start time into the a timeSlot object
    // now we have a list of timeSlot objects
    timeSlots = [[NSMutableArray alloc] init];
    int count = -1;
    NSDate *prevStartDate = Nil;
    for(BCEESession *session in sortedSessions){
        NSDate *currStartTime = [session startTime];
        if ([currStartTime isEqualToDate:prevStartDate]) {
            [timeSlots[count] addSession:session];
        } else {
            
            // Convert currStartTime to a NSString
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *currStartTimeStr = [formatter stringFromDate:currStartTime];
            
            // Create next time slot
            BCEETimeSlot *nextTimeSlot = [[BCEETimeSlot alloc] initTimeSlot:currStartTimeStr];
            [nextTimeSlot addSession:session];
            [timeSlots addObject:nextTimeSlot];
            count++;
        }
        prevStartDate = currStartTime;
    }
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
