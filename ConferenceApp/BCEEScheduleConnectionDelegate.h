//
//  BCEEScheduleConnectionDelegate.h
//  ConferenceApp
//
//  Created by Tim C on 10/27/2013.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const SESSION_INFO_URL;
extern NSString* const DATE_FORMAT;


@interface BCEEScheduleConnectionDelegate : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
    NSMutableArray *_sessionArray;
    NSMutableArray *_sessionSchedule;
}
@end
