//
//  BCEEDetailViewController.h
//  ConferenceApp
//
//  Created by Arianne Dee on 2013-10-25.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCEETimeSlot.h"

NSString * urltosend;
NSString * parsedName;
NSString * parsedLocation;
NSString * parsedStartTime;
NSString * parsedEndTime;
NSString * parsedBio;

@interface BCEEDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) BCEESession *detailItem;
@property (strong, nonatomic) NSString *surveyLink;

@property (strong, nonatomic) IBOutlet UILabel *lbl_sessionName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_startTime;
@property (strong, nonatomic) IBOutlet UILabel *lbl_endtime;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UILabel *lbl_location;
@property (weak, nonatomic) IBOutlet UILabel *lbl_speakerNames;
@property (strong, nonatomic) IBOutlet UITextView *biography;
@property (strong, nonatomic) IBOutlet UIButton *btnSurvey;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (IBAction)onSurveyButtonClicked:(id)sender;



@end
