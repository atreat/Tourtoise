//
//  CreateStopViewController.m
//  tours
//
//  Created by Austin Emmons on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CreateStopViewController.h"

@implementation CreateStopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
    
    //current page is for progression and page control
    currentPage = 0;
    NSLog(@"Current Page :: %i ", currentPage);
    
    CGRect frame = CGRectMake(0, 40, contentView.bounds.size.width, contentView.bounds.size.height);
    contentView.frame = frame;
    [self.view addSubview:contentView];
    
//    //duration picker view is added just offscreen
//    WORKS FINE
    float centerX = ((self.view.bounds.size.width - durationPickerView.bounds.size.width)/2);
    frame = CGRectMake(centerX, self.view.bounds.size.height, durationPickerView.bounds.size.width, durationPickerView.bounds.size.height);
    durationPickerView.frame = frame;
    [self.view addSubview:durationPickerView];
    durationTextField.inputView = durationPickerView;

    
    //init category tableview. This becomes textfields input view in the init.
    categoryPickerTableView = [[CategoryTableViewController alloc] initWithTextfield:categoryTextField];
    
    ageRatingTableView = [[AgeRatingTableViewController alloc] initWithTextfield:ageTextField];
    
//    NSLog(@"category Picker Table View Bounds  (width, height)  (%4.2f,%4.2f) ", categoryPickerTableView.bounds.size.width, categoryPickerTableView.bounds.size.height);
    
    //categories = [[NSArray alloc] initWithObjects:@"Museum", @"Campus", @"Historical", @"Restaurant",@"Entertainment", nil];  
    //category picker view is added just offscreen
    
    
//    
//    //age rating view is added just offscreen
//    frame = CGRectMake(0, self.view.bounds.size.height, ageRatingTableView.bounds.size.width, ageRatingTableView.bounds.size.height);
//    ageRatingTableView.frame = frame;
//    [self.view addSubview:ageRatingTableView];
    
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipeDown];
    [swipeDown release];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    [swipeRight release];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    
}

- (void)viewDidUnload
{
    [contentView release];
    contentView = nil;
    [categoryPickerTableView release];
    categoryPickerTableView = nil;
    [durationPickerView release];
    durationPickerView = nil;
    [ageRatingTableView release];
    ageRatingTableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [contentView release];
    [categoryPickerTableView release];
    [durationPickerView release];
    [ageRatingTableView release];
    [super dealloc];
}

-(IBAction)backButtonPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) resignAllFirstResponders
{
    [titleTextField         resignFirstResponder];
    [descriptionTextView    resignFirstResponder];
    [accessTextField        resignFirstResponder];
    [categoryTextField      resignFirstResponder];
    [ageTextField           resignFirstResponder];
    [durationTextField      resignFirstResponder];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    //makes keyboard go away when return is pressed
    [textField resignFirstResponder];
    NSLog(@"Text field: %@", textField.text );
    return YES;    
}

#pragma mark - Gesture Recognizer Selectors

- (void) swipeDown:(UISwipeGestureRecognizer *) recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized){
        [self resignAllFirstResponders];
    }
}

-(void) swipeLeft:(UISwipeGestureRecognizer *) recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized){
        currentPage++;
        NSLog(@"Current Page :: %i ", currentPage);
        if (currentPage == 3) {      //    remember progress views index 0,1,2,3,...
            [self showStopPreview];
        }
        [Animator horizontalShift:contentView distance:-self.view.bounds.size.width];
        
        
    }
}

-(void) swipeRight:(UISwipeGestureRecognizer *) recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized){
        currentPage--;
        NSLog(@"Current Page :: %i ", currentPage);
        
        [Animator horizontalShift:contentView distance:self.view.bounds.size.width];
        
    }
}

#pragma mark - becomeFistResponder for custom input Views
-(IBAction) setCategoryTableAsFirstResponder:(id)sender{
    [categoryPickerTableView becomeFirstResponder];
}
-(IBAction) setAgeRatingTableAsFirstResponder:(id)sender{
    [ageRatingTableView becomeFirstResponder];
}
-(IBAction) setDurationPickerViewAsFirstResponder:(id)sender{
    [durationPickerView becomeFirstResponder];
}

#pragma mark - DatePicker Methods

-(IBAction)updateDuration:(id)sender
{
//    Gets time from duration picker, then parses that into readable format for textfield
//    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"H"];
    NSString *hour = [df stringFromDate:durationPickerView.date];
    NSLog(@"HOUR :: %@", hour);
    durationTextField.text = hour;
    if ([hour isEqualToString:@"1"]) {
        durationTextField.text = [durationTextField.text stringByAppendingString:@" hour "];        //append hour label if 1 hour only
    }else{
        durationTextField.text = [durationTextField.text stringByAppendingString:@" hours "];       //append hours label if anything else
    }
    if ([hour isEqualToString:@"0"]) {      //don't display "0 hours". That would be stupid.
        durationTextField.text = @"";
    }
    
    [df setDateFormat:@"mm"];
    NSString *minutes = [df stringFromDate:durationPickerView.date];
    if ([minutes isEqualToString:@"00"]) {   //don't display "00 minutes". That would be stupider.
        //don't append anything
    }else{
        durationTextField.text = [durationTextField.text stringByAppendingString:minutes];
        durationTextField.text = [durationTextField.text stringByAppendingString:@" minutes"];
    }
                              
    [df release];
}
#pragma mark - Stop Preview Methods
-(void) showStopPreview
{
    //Shows stop preview
    //  creates dictionary from input along the way. Does not save this dictionary as state.
    
    //create temporary stopViewController
    StopViewController *stopPreviewController = [[StopViewController alloc] initFromDictionary:[self createDictionaryFromTextInput]];
    
    [stopPreviewViewContainer addSubview:stopPreviewController.view];
    
    
    [stopPreviewController release];
}


#pragma mark - Load State/Save State
-(NSDictionary *)createDictionaryFromTextInput
{
    //creates array of objects from textFields as NSString
    
            //TODO: Will need to add path to image when image gallery is 
    NSArray *objects = [[NSArray alloc] initWithObjects:titleTextField.text,
                        descriptionTextView.text,accessTextField.text,
                        categoryTextField.text, ageTextField.text,
                        durationTextField.text, nil];
    //creates array of keys from textFields as NSString
    NSArray *keys    = [[NSArray alloc] initWithObjects:@"title",@"description",
                                                        @"access",@"category",
                                                        @"age",@"duration", nil];
    
    //creates dictionary from two arrays, objects and keys
    NSDictionary *tempDictionary = [[[NSDictionary alloc] initWithObjects:objects forKeys:keys] autorelease];
    [objects release];
    [keys release];
    
    return tempDictionary;
}

-(void) saveStop
{
    //  stores text/media_path into NSDictionary
    //  
    NSLog(@"Beginning to SaveStop           ( begin )");
    NSDictionary *toSaveDictionary = [self createDictionaryFromTextInput];
    //save dictionary to core data
    
//    StopManagedObject   *stop = [[StopManagedObject alloc] init];
//    stop.title      =   [toSaveDictionary objectForKey:@"title"];
//    stop.dictionary =   toSaveDictionary;
//    stop.media      =   IMAGE MEDIA AS NSDATA;
    
    
    NSLog(@"Dictionary to be sved :: %@", toSaveDictionary);
                                                     
    NSLog(@"Save Successfull                (success)");
}

-(void) loadStopIntoViewFromCoreData
{
    //  loads from Core Data as NSDictionary
    //  Puts into respective textfields so user sees fluidly.
    
    
    
    
}









@end
