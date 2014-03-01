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
    
    NSURL * url = [NSURL URLWithString: @"https://www.surveymonkey.com/s/LS7TPM7"];
    NSURLRequest * rObj = [NSURLRequest requestWithURL:url];
    [_generalSurvey loadRequest:rObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end