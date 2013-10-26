//
//  BCEETimeSlot.m
//  ConferenceApp
//
//  Created by Tim C on 10/26/2013.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

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

@end
