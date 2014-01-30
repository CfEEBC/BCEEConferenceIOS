//
//  BCEEDetailViewController.h
//  ConferenceApp
//
//  Created by Tim Cheung on 10/26/2013.
//  Copyright (c) 2013 Tim Cheung Napon Taratan Arianne Dee.
//  All rights reserved.

#import <UIKit/UIKit.h>
#import "BCEETimeSlot.h"

@interface BCEEDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) BCEESession *detailItem;
@property (strong, nonatomic) NSString *surveyLink;

@property (strong, nonatomic) IBOutlet UILabel *lbl_sessionName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UILabel *lbl_location;
@property (weak, nonatomic) IBOutlet UILabel *lbl_speakerNames;
@property (strong, nonatomic) IBOutlet UITextView *biography;
@property (strong, nonatomic) IBOutlet UIButton *btnSurvey;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (IBAction)onSurveyButtonClicked:(id)sender;



@end
