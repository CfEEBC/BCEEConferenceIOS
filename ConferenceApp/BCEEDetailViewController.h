//
//  BCEEDetailViewController.h
//  ConferenceApp
//
//  Created by Arianne Dee on 2013-10-25.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString * urltosend;
NSString * parsedName;
NSString * parsedLocation;
NSString * parsedStartTime;
NSString * parsedEndTime;
NSString * parsedBio;

@interface BCEEDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UILabel *lblSessionName;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UIButton *btnSurvey;
@property (strong, nonatomic) IBOutlet UILabel *lbl_sessionName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_startTime;
@property (strong, nonatomic) IBOutlet UILabel *lbl_endtime;
@property (strong, nonatomic) IBOutlet UILabel *lbl_location;
@property (strong, nonatomic) IBOutlet UITextView *desc_bio;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (IBAction)onSurveyButtonClicked:(id)sender;



@end
