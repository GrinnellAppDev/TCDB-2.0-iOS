//
//  ClockViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 12/1/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "AppDelegate.h"
#import "ClockViewController.h"
#import "ScheduleViewController.h"
#import "DirectoryViewController.h"
#import "ShiftsViewController.h"

@interface ClockViewController ()

@end

@implementation ClockViewController {
    AppDelegate *mainDelegate;
}
@synthesize clockButton, scheduleButton, shiftsButton, directoryButton, menuButton, doneButton, activeView, labPicker, scrollView, commentField, labsField, labsArray, doneBar, dateField, startTimeField, endTimeField, endTimeLabel, clockLabel, mentoringSwitch;
//Do some initialization of our own
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labsArray = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects: @"Helpdesk", @"Helpdesk 2", nil]];
    self.labsField.inputView = self.labPicker;
    self.labPicker.hidden = YES;
    self.doneBar.hidden = YES;
    self.labPicker.showsSelectionIndicator = YES;
    [self registerForKeyboardNotifications];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter  setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
    self.dateField.text = formattedDate;
    [dateFormatter  setDateFormat:@"HH:mm"];
    formattedDate = [dateFormatter stringFromDate:[NSDate date]];
    // if (clockedIn?)
    if (NO){
        self.clockLabel.text = @"Clock Out";
        self.endTimeField.hidden = NO;
        self.endTimeLabel.hidden = NO;
        self.endTimeField.text = formattedDate;
    }
    else{
        self.clockLabel.text = @"Clock In";
        self.endTimeField.hidden = YES;
        self.endTimeLabel.hidden = YES;
        self.startTimeField.text = formattedDate;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark Toolbar Methods
- (IBAction)menuButtonTapped:(id)sender{
    [self.labsField resignFirstResponder];
    [self.commentField resignFirstResponder];
    self.doneBar.hidden = YES;
    [mainDelegate.deckController toggleLeftView];
}
- (IBAction)clockButtonTapped:(id)sender{
    ClockViewController *clock = [[ClockViewController alloc] initWithNibName:@"ClockViewController" bundle:nil];
    mainDelegate.deckController.centerController = clock;
}
- (IBAction)directoryButtonTapped:(id)sender{
    DirectoryViewController *directory = [[DirectoryViewController alloc] initWithNibName:@"DirectoryViewController" bundle:nil];
    mainDelegate.deckController.centerController = directory;
}
- (IBAction)shiftsButtonTapped:(id)sender{
    ShiftsViewController *shifts = [[ShiftsViewController alloc] initWithNibName:@"ShiftsViewController" bundle:nil];
    mainDelegate.deckController.centerController = shifts;
}
- (IBAction)scheduleButtonTapped:(id)sender{
    ScheduleViewController *schedule = [[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:nil];
    mainDelegate.deckController.centerController = schedule;
}

#pragma mark UIPicker methods
-(IBAction)labDidBeginEditing{
    self.labPicker.hidden = NO;
    self.doneBar.hidden = NO;
    self.labPicker = [[UIPickerView alloc] init];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.labsArray objectAtIndex:row];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.labsArray.count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.labsField.text = [self.labsArray objectAtIndex:row];
}

- (IBAction)doneChoosing:(id)sender {
    [self.labsField resignFirstResponder];
    [self.commentField resignFirstResponder];
    self.doneBar.hidden = YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.doneBar.hidden = NO;
    self.activeView = textView;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.doneBar.hidden = YES;
    self.activeView = nil;
}
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
    if(self.activeView){
        NSDictionary* info = [aNotification userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        double offset = kbSize.height/2;
        offset = self.commentField.frame.origin.y - 44;
        CGPoint scrollPoint = CGPointMake(0.0, offset);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    CGPoint scrollPoint = CGPointMake(0.0, 0.0);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

@end
