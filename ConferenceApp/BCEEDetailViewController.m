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

@interface BCEEDetailViewController ()

@property (nonatomic, strong) NSMutableData * responseData;

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation BCEEDetailViewController


@synthesize responseData = _responseData;

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
    
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bceeconference.appspot.com/machine"]];
    NSURLConnection * conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
    
    NSLog(@"hey");
    
}

- (void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSError * myerror = nil;
    NSArray * res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myerror];
    
    for (int i = 0; i < [res count] ; i++){
        NSDictionary * d = [res objectAtIndex:(0)];
        for(id key in d){
            id value = [d objectForKey:key];
            
            NSString *keyAsString = (NSString *) key;
            NSString *valueAsString = (NSString *) value;
            
            if([keyAsString isEqualToString:@"session_name"]){
                parsedName = valueAsString;
            } else if([keyAsString isEqualToString:@"location"]){
                parsedLocation = valueAsString;
            } else if ([keyAsString isEqualToString:@"speakers"]){
                
            } else if([keyAsString isEqualToString:@"stime"]){
                parsedStartTime = valueAsString;
            } else if([keyAsString isEqualToString:@"etime"]){
                parsedEndTime = valueAsString;
            } else if([keyAsString isEqualToString:@"description"]){
                
            } else if([keyAsString isEqualToString:@"biography"]){
                parsedBio = valueAsString;
            } else if([keyAsString isEqualToString:@"survey_link"]){
                urltosend = valueAsString;
            }
            
            NSLog(@"===NEW SESSION===");
            NSLog(@"Name: %@", parsedName);
            NSLog(@"Location: %@", parsedLocation);
            NSLog(@"StartTime: %@", parsedStartTime);
            NSLog(@"EndTime: %@", parsedEndTime);
            NSLog(@"Biography: %@", parsedBio);
            NSLog(@"Survey: %@", urltosend);
        
        }
    }
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
    urltosend = [_detailItem surveyLink];
}
@end
