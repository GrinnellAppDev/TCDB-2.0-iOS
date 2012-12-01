//
//  ClockViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 12/1/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "HomeViewController.h"
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark Toolbar Methods
- (IBAction)menuButtonTapped:(id)sender{
    if(mainDelegate.deckController.leftControllerIsClosed)
        [mainDelegate.deckController openLeftView];
    else
        [mainDelegate.deckController closeLeftView];
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
- (IBAction)clockButtonTapped:(id)sender{
    ClockViewController *clock = [[ClockViewController alloc] initWithNibName:@"ClockViewController" bundle:nil];
    mainDelegate.deckController.centerController = clock;
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

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.labsField.text = [self.labsArray objectAtIndex:row];
}

- (IBAction)doneChoosing:(id)sender{
    [self.labPicker resignFirstResponder];
    [self.labPicker removeFromSuperview];
    self.labPicker.hidden = YES;
    self.doneBar.hidden = YES;
}

@end
