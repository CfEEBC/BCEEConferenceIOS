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
#import "BCEESplashViewController.h"

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
        
        //_lblName.text = newDetailItem.location;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    
    // PUT PARSED INFO HERE:
    //parsedName = @"$SESSION";
    //parsedLocation = @"$LOCATION";
    //parsedStartTime = @"$STIME";
    //parsedEndTime = @"$ETIME";
    //parsedBio = @"$BIO";
    
//    [_lbl_location setText:parsedLocation];
//    [_lbl_sessionName setText:parsedName];
//    [_lbl_startTime setText:parsedStartTime];
//    [_lbl_endtime setText:parsedEndTime];
//    [_desc_bio setText:parsedBio];
    
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
    // MODIFY WEBSITE HERE
    //urltosend = @"http://www.google.com";
}
@end
