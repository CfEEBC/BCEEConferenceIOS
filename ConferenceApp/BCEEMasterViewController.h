//
//  BCEEMasterViewController.h
//  ConferenceApp
//
//  Created by Arianne Dee on 2013-10-25.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCEESplashViewController.h"


NSMutableArray *timeSlots;

@class BCEEDetailViewController;

@interface BCEEMasterViewController : UITableViewController

@property (strong, nonatomic) BCEEDetailViewController *detailViewController;

- (void)setTimeSlots:(NSMutableArray *)newTimeSlots;

@end
