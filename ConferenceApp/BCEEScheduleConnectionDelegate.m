//
//  BCEEScheduleConnectionDelegate.m
//  ConferenceApp
//
//  Created by Tim C on 10/27/2013.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import "BCEEScheduleConnectionDelegate.h"
#import "BCEESplashViewController.h"
#import "BCEESession.h"
#import "BCEETimeSlot.h"

@implementation BCEEScheduleConnectionDelegate

// Constants
NSString* const SESSION_INFO_URL = @"http://bceeconference.appspot.com/machine";
NSString* const DATE_FORMAT = @"yyyy-MM-dd HH:mm:ss";

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    _sessionArray = [[NSMutableArray alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    
    // Request Session Information Data from Server, parse it to an array of BCEETimeSlot.
    NSError * myerror = nil;
    NSArray * res = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableLeaves error:&myerror];
    
    // Instantiate NSDateFormatter for parsing dates
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:DATE_FORMAT];
    
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
        
        [_sessionArray addObject:session];
        
    }
    
    // sort the list of sessions by start time
    NSArray * sortedSessions = [_sessionArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(BCEESession *)a startTime];
        NSDate *second = [(BCEESession *)b startTime];
        return [first compare:second];
    }];
    
    // group sessions with the same start time into the a timeSlot object
    // now we have a list of timeSlot objects
    _sessionSchedule = [[NSMutableArray alloc] init];
    int count = -1;
    NSDate *prevStartDate = Nil;
    for(BCEESession *session in sortedSessions){
        NSDate *currStartTime = [session startTime];
        if ([currStartTime isEqualToDate:prevStartDate]) {
            [_sessionSchedule[count] addSession:session];
        } else {
            
            // Convert currStartTime to a NSString
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *currStartTimeStr = [formatter stringFromDate:currStartTime];
            
            // Create next time slot
            BCEETimeSlot *nextTimeSlot = [[BCEETimeSlot alloc] initTimeSlot:currStartTimeStr];
            [nextTimeSlot addSession:session];
            [_sessionSchedule addObject:nextTimeSlot];
            count++;
        }
        prevStartDate = currStartTime;
    }
    
    timeSlots = _sessionSchedule;
    
    // Unhide buttons in beginning spalsh view after parsing is done
    [[BCEESplashViewInstance btn_start] setHidden:FALSE];
    [[BCEESplashViewInstance btn_endSurvey] setHidden:FALSE];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _responseData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Connection Error!"
                                                      message:@"We are unable to retrieve the conference schedule. Please check your internet connection settings."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [[BCEESplashViewInstance lbl_connectionFailed] setHidden:FALSE];


}

@end
