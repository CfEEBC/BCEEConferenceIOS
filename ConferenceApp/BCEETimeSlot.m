//
//  BCEETimeSlot.m
//  ConferenceApp
//
//  Created by Napon Taratan on 10/26/2013.
//  Copyright (c) 2013 Tim Cheung Napon Taratan Arianne Dee.
//  All rights reserved.

#import "BCEETimeSlot.h"

@implementation BCEETimeSlot

- (id)initTimeSlot:(NSString *)timeSlot
      withSessions:(NSMutableArray *) sessions
{
    if ([super init]) {
        _timeSlot = timeSlot;
        _sessions = sessions;
    }
    return self;
}

- (id)initTimeSlot:(NSString *)timeSlot
{
    if ([super init]) {
        _timeSlot = timeSlot;
        _sessions = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)addSession:(BCEESession *)session
{
    [_sessions addObject: session];
}


@end
