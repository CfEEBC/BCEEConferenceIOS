//
//  BCEEDetailViewController.m
//  ConferenceApp
//
//  Created by Arianne Dee on 2013-10-25.
//  Copyright (c) 2013 Arianne Dee. All rights reserved.
//
//

#import "BCEEDetailViewController.h"
#import "BCEESession.h"
#import "BCEETimeSlot.h"
#import "BCEESplashViewController.h"
#import "BCEESurveyViewController.h"

@interface BCEEDetailViewController ()


@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation BCEEDetailViewController



#pragma mark - Managing the detail item

- (void)setDetailItem:(BCEESession *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    // Set up date formatter
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
        self.lbl_sessionName.text = [self.detailItem name];
        self.lbl_startTime.text = [df stringFromDate:[self.detailItem startTime]];
        self.lbl_endtime.text = [df stringFromDate:[self.detailItem endTime]];
        self.description.text = [self.detailItem description];
        self.lbl_location.text = [self.detailItem location];
        self.lbl_speakerNames.text = [self.detailItem speakers];
        self.biography.text = [self.detailItem biography];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController
     willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - IBActions

- (IBAction)onSurveyButtonClicked:(id)sender {
     urltosend = [_detailItem surveyLink];
}
@end
