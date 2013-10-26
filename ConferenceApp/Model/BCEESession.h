//
//  BCEESession.h
//  ConferenceApp
//
//  Created by Arianne Dee on 2013-10-25.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

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


- (id)initWithDate:(NSDate *)startTime
          location:(NSString *)location;

- (id)initWithName:(NSString *)name
       Description:(NSString *)description
          Location:(NSString *)location
          Speakers:(NSString *)speakers
         Biography:(NSString *)biography
        surveyLink:(NSString *)surveyLink
         startTime:(NSDate *)startTime
           endTime:(NSDate *)endTime;


@end
