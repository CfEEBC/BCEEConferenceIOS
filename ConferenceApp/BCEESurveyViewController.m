//
//  BCEESurveyViewController.m
//  ConferenceApp
//
//  Created by sNapZ on 10/26/2013.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import "BCEESurveyViewController.h"
#import "BCEEDetailViewController.h"

@interface BCEESurveyViewController ();
@end

@implementation BCEESurveyViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    NSString * stringUrl = urltosend;
    NSURL *url = [NSURL URLWithString: stringUrl];
    NSURLRequest * rObj = [NSURLRequest requestWithURL: url];
    [_surveyWebView loadRequest: rObj];
}
@end