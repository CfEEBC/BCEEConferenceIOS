//
//  BCEESession.h
//  ConferenceApp
//
//  Created by Arianne Dee on 2013-10-25.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCEESession : NSObject

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSMutableArray *speakers;

- (id)initWithDate:(NSDate *)startTime
          location:(NSString *)location;

- (void)updateSessionWithStart:(NSDate *)start
                      location:(NSString *)loc
                   description:(NSString *)desc
                    andSpeaker:(NSString *)speaker1;
- (void)test;

- (void)updateSessionWithStart:(NSDate *)start;

@end
