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
    
    // make sure the url starts with http://
    // if not add it in
    if([urltosend characterAtIndex:0] == 'w'){
        urltosend = [@"http://" stringByAppendingString:urltosend];
    }
    
    NSString * stringUrl = urltosend;
    NSURL *url = [NSURL URLWithString: stringUrl];
    NSURLRequest * rObj = [NSURLRequest requestWithURL: url];
    
    // load webpage on the webView
    NSLog(@"The Survey URL: %@", stringUrl);
    [_surveyWebView loadRequest: rObj];
}
@end
