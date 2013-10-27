//
//  BCEETimeSlot.h
//  ConferenceApp
//
//  Created by Tim C on 10/26/2013.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCEESession.h"

@interface BCEETimeSlot : NSObject

@property (nonatomic, strong) NSString *timeSlot;
@property (nonatomic, strong) NSMutableArray *sessions;

- (id)initTimeSlot:(NSString *)timeSlot
      withSessions:(NSMutableArray *) sessions;

- (id)initTimeSlot:(NSString *)timeSlot;

- (void)addSession:(BCEESession *)session;

@end
