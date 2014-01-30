//
//  BCEESession.m
//  ConferenceApp
//
//  Created by Napon Taratan on 10/26/2013.
//  Copyright (c) 2013 Tim Cheung Napon Taratan Arianne Dee.
//  All rights reserved.

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
