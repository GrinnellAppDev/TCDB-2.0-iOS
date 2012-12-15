//
//  HomeViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 11/28/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ClockViewController.h"
#import "ScheduleViewController.h"
#import "DirectoryViewController.h"
#import "ShiftsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {
    AppDelegate *mainDelegate;
}
@synthesize clockButton, scheduleButton, shiftsButton, directoryButton, menuButton;
//Do some initialization of our own
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *objects = [[NSArray alloc] initWithObjects:@"tremblay", @"tremblay@grinnell.edu", @"425-495-6425", @"4650", @"TC", @"S14", nil];
    NSArray *keys = [[NSArray alloc] initWithObjects:@"username", @"email", @"phone", @"box", @"rank", @"graduation", nil];
    NSArray *shifts = [[NSArray alloc] initWithObjects:@"Fri, Dec 14, 09:00 - 11:00", @"Sat, Dec 15, 09:00 - 11:00", @"Sun, Dec 15, 12:00 - 14:00", nil];
    NSArray *locations = [[NSArray alloc] initWithObjects:@"AV Center 2", @"AV Center 2", @"Helpdesk", nil];
    mainDelegate.me.attributes = [[NSMutableArray alloc] initWithArray:keys];
    mainDelegate.me.attributeVals = [[NSMutableArray alloc] initWithArray:objects];
    mainDelegate.me.upcomingShifts = [[NSMutableArray alloc] initWithArray:shifts];
    mainDelegate.me.upcomingShiftLocations = [[NSMutableArray alloc] initWithArray:locations];
    mainDelegate.me.name = @"Colin Tremblay";
    mainDelegate.me.profilePic = [UIImage imageNamed:@"default_profile.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark Toolbar Methods
- (IBAction)menuButtonTapped:(id)sender{
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

@end
