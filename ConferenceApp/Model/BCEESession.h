//
//  BCEESession.h
//  ConferenceApp
//
//  Created by Napon Taratan on 10/26/2013.
//  Copyright (c) 2013 Tim Cheung Napon Taratan Arianne Dee.
//  All rights reserved.

#import <Foundation/Foundation.h>

@interface BCEESession : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *speakers;
@property (nonatomic, strong) NSString *biography;
@property (nonatomic, strong) NSString *surveyLink;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

- (id)initWithName:(NSString *)name
       Description:(NSString *)description
          Location:(NSString *)location
          Speakers:(NSString *)speakers
         Biography:(NSString *)biography
        surveyLink:(NSString *)surveyLink
         startTime:(NSDate *)startTime
           endTime:(NSDate *)endTime;


@end
