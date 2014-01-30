//
//  BCEEGeneralSurveyViewController.m
//  ConferenceApp
//
//  Created by Tim Cheung on 10/26/2013.
//  Copyright (c) 2013 Tim Cheung Napon Taratan Arianne Dee.
//  All rights reserved.

#import "BCEEGeneralSurveyViewController.h"

@interface BCEEGeneralSurveyViewController ()

@end

@implementation BCEEGeneralSurveyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString * parsedlink = @"www.google.com";
    if(![parsedlink hasPrefix:@"http://"] || ![parsedlink hasPrefix:@"https://"]){
        parsedlink = [@"http://" stringByAppendingString:parsedlink];
    }
    NSString * stringUrl = parsedlink;
    NSURL * url = [NSURL URLWithString:stringUrl];
    NSURLRequest * rObj = [NSURLRequest requestWithURL:url];
    [_generalSurvey loadRequest:rObj];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
