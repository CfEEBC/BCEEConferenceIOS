//
//  BCEESession.m
//  ConferenceApp
//
//  Created by Arianne Dee on 2013-10-25.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import "BCEESession.h"

@implementation BCEESession

- (id)initWithDate:(NSDate *)startTime
          location:(NSString *)location
{
    if ([super init]) {
        _startTime = startTime;
        _location = location;
    }
    return self;
}

@end
