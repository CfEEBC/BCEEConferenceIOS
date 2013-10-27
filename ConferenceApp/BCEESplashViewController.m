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
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    sessionArray = [[NSMutableArray alloc] init];
    
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bceeconference.appspot.com/machine"]];
    NSURLConnection * conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSString * parsedUrl;
    NSString * parsedName;
    NSString * parsedLocation;
    NSString * parsedStartTime;
    NSString * parsedEndTime;
    NSString * parsedBio;
    NSString * parsedDescription;
    NSString * parsedSpeakers;
    NSDate * start_time = [[NSDate alloc] init];
    NSDate * end_time = [[NSDate alloc] init];
    
    NSError * myerror = nil;
    NSArray * res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myerror];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    for (int i = 0; i < [res count] ; i++){
        
        NSDictionary * d = [res objectAtIndex:(i)];
        
        //NSLog(@"===NEW SESSION===");

        for(id key in d){
            id value = [d objectForKey:key];
            
            NSString *keyAsString = (NSString *) key;
            NSString *valueAsString = (NSString *) value;
            

            if([keyAsString isEqualToString:@"session_name"]){
                parsedName = valueAsString;
                //NSLog(@"Name: %@", parsedName);

            } else if([keyAsString isEqualToString:@"location"]){
                parsedLocation = valueAsString;
                //NSLog(@"Location: %@", parsedLocation);

            } else if ([keyAsString isEqualToString:@"speakers"]){
                parsedSpeakers = valueAsString;
            } else if([keyAsString isEqualToString:@"stime"]){
                parsedStartTime = valueAsString;
                start_time = [df dateFromString:parsedStartTime];
                //NSLog(@"StartTime: %@", parsedStartTime);

                start_time = [df dateFromString:parsedStartTime];
            } else if([keyAsString isEqualToString:@"etime"]){
                parsedEndTime = valueAsString;
                end_time = [df dateFromString:parsedEndTime];
                //NSLog(@"EndTime: %@", parsedEndTime);

            } else if([keyAsString isEqualToString:@"description"]){
                parsedDescription = valueAsString;
            } else if([keyAsString isEqualToString:@"biography"]){
                parsedBio = valueAsString;
            } else if([keyAsString isEqualToString:@"survey_link"]){
                parsedUrl = valueAsString;
            }
            
        }
    
        BCEESession * a = [[BCEESession alloc] initWithName:parsedName
                                                Description:parsedDescription Location:parsedLocation Speakers:parsedSpeakers Biography:parsedBio surveyLink:parsedUrl startTime:start_time endTime:end_time];
        [sessionArray addObject:a];
        
    }
    //sort
    NSArray * sortedSessions = [sessionArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(BCEESession *)a startTime];
        NSDate *second = [(BCEESession *)b startTime];
        return [first compare:second];
    }];
    
//    NSMutableArray * timeSlots = [[NSMutableArray alloc] init];
//    for (BCEESession *session in sessionArray) {
//        NSDate *startTime = [session startTime];
//        if (timeSlots containsObject:startTime) {
//            
//        }
//    }
    
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
    // Dispose of any resources that can be recreated.
}

- (IBAction)onEnterClicked:(id)sender {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTimeSlots"]) {
        [[segue destinationViewController] setTimeSlots: timeSlots];
    }
}


@end
