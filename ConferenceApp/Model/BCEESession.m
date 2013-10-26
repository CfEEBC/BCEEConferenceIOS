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
        _speakers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)test
{
    // Calling a method on an object
    [self initWithDate:nil location:@"String"];
    
    // Strings are called NSString
    NSString *myString = @"this is a message";
    [myString uppercaseString];
    
    // Arrays
    NSMutableArray *myArray = [[NSMutableArray alloc] initWithObjects:@(1), @(3), nil];
    myArray[1];
    myArray[2] = @"string";
    
    // Dictionaries
    NSMutableDictionary *myDict = [[NSMutableDictionary alloc] init];
    myDict[@"name"] = @"session1";
    [myDict setObject:@"session2" forKey:@"name"];
    
    // Object setters:
    _location = @"room 1"; // can use if currently in class who owns property
    self.location = @"room 2"; // dot notation for accessing an object's property
    [self setLocation:@"room 3"]; // standard notation
    
    // Object getters:
    _location;      // can use if currently in class
    self.location;  // dot notation
    [self location]; // standard notation
    
    NSLog(@"Hello world: %@", _location);
    
}

- (void)updateSessionWithStart:(NSDate *)start location:(NSString *)loc description:(NSString *)desc andSpeaker:(NSString *)speaker1
{
    self.startTime = start;
    self.location = loc;
    self.description = desc;
    [_speakers addObject:speaker1];
}

- (void)updateSessionWithStart:(NSDate *)start
{
    [self updateSessionWithStart:start
                        location:@"none"
                     description:nil
                      andSpeaker:nil];
}

@end
