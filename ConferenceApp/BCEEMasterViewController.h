//
//  BCEEMasterViewController.h
//  ConferenceApp
//
//  Created by Arianne Dee on 10/26/2013.
//  Copyright (c) 2013 Tim Cheung Napon Taratan Arianne Dee.
//  All rights reserved.

#import <UIKit/UIKit.h>
#import "BCEESplashViewController.h"


NSMutableArray *timeSlots;

@class BCEEDetailViewController;

@interface BCEEMasterViewController : UITableViewController

@property (strong, nonatomic) BCEEDetailViewController *detailViewController;

- (void)setTimeSlots:(NSMutableArray *)newTimeSlots;

@end
