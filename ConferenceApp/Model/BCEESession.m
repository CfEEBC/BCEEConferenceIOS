//
//  BCEESession.m
//  ConferenceApp
//
//  Created by Arianne Dee on 2013-10-25.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import "BCEESession.h"

@implementation BCEESession

- (id)initWithName:(NSString *)name
       Description:(NSString *)description
          Location:(NSString *)location
          Speakers:(NSString *)speakers
         Biography:(NSString *)biography
        surveyLink:(NSString *)surveyLink
         startTime:(NSDate *)startTime
           endTime:(NSDate *)endTime
{
    if ([super init]) {
        _name = name;
        _description = description;
        _location = location;
        _speakers = speakers;
        _biography = biography;
        _surveyLink = surveyLink;
        _startTime = startTime;
        _endTime = endTime;
    }
    return self;
}

@end
