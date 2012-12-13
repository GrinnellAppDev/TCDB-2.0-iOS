//
//  ProfileViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 12/13/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "ClockViewController.h"
#import "ScheduleViewController.h"
#import "DirectoryViewController.h"
#import "ShiftsViewController.h"


@implementation ProfileViewController {
    AppDelegate *mainDelegate;
}
@synthesize clockButton, scheduleButton, shiftsButton, directoryButton, menuButton, selectedPerson;
//Do some initialization of our own
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.selectedPerson.name = @"IT'S ME!";
    //self.selectedPerson.profilePic = [UIImage alloc] ini appbar.time.rest.png;
    NSArray *objects = [[NSArray alloc] initWithObjects:@"tremblay", @"tremblay@grinnell.edu", @"425-495-6425", @"4650", @"TC", @"S14", nil];
    NSArray *keys = [[NSArray alloc] initWithObjects:@"username", @"email", @"phone", @"box", @"rank", @"graduation", nil];
    self.selectedPerson = [[Person alloc] init];
    self.selectedPerson.attributes = [[NSMutableArray alloc] initWithArray:keys];
    self.selectedPerson.attributeVals = [[NSMutableArray alloc] initWithArray:objects];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0)
        return 6;
    else
        //return numberOfUpcomingShifts
        return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSLog(@"%@", [self.selectedPerson.attributeVals objectAtIndex:indexPath.row]);
    cell.textLabel.text = [self.selectedPerson.attributeVals objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.selectedPerson.attributes objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
