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
#import <QuartzCore/QuartzCore.h>

@implementation ProfileViewController {
    AppDelegate *mainDelegate;
}
@synthesize clockButton, scheduleButton, shiftsButton, directoryButton, menuButton, selectedPerson, table;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    NSArray *objects = [[NSArray alloc] initWithObjects:@"tremblay", @"tremblay@grinnell.edu", @"425-495-6425", @"4650", @"TC", @"S14", nil];
    NSArray *keys = [[NSArray alloc] initWithObjects:@"username", @"email", @"phone", @"box", @"rank", @"graduation", nil];
    NSArray *shifts = [[NSArray alloc] initWithObjects:@"Fri, Dec 14, 09:00 - 11:00", @"Sat, Dec 15, 09:00 - 11:00", @"Sun, Dec 15, 12:00 - 14:00", nil];
    NSArray *locations = [[NSArray alloc] initWithObjects:@"AV Center 2", @"AV Center 2", @"Helpdesk", nil];
    self.selectedPerson = [[Person alloc] init];
    self.selectedPerson.attributes = [[NSMutableArray alloc] initWithArray:keys];
    self.selectedPerson.attributeVals = [[NSMutableArray alloc] initWithArray:objects];
    self.selectedPerson.upcomingShifts = [[NSMutableArray alloc] initWithArray:shifts];
    self.selectedPerson.upcomingShiftLocations = [[NSMutableArray alloc] initWithArray:locations];
    self.selectedPerson.name = @"IT'S ME!";
    self.selectedPerson.profilePic = [UIImage imageNamed:@"default_profile.png"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Create header view and add name/picture as subviews
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(120, 50, 300, 30);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = self.selectedPerson.name;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 90)];
    imageView.image = self.selectedPerson.profilePic;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [view addSubview:imageView];
    [view addSubview:label];
    table.tableHeaderView = view;
}

- (void)viewDidUnload {
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
    else if (section == 1)
        return self.selectedPerson.upcomingShifts.count;
    else return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    if (indexPath.section == 0){
        cell.textLabel.text = [self.selectedPerson.attributeVals objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.selectedPerson.attributes objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [self.selectedPerson.upcomingShifts objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.selectedPerson.upcomingShiftLocations objectAtIndex:indexPath.row];
    }
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] && [cell.detailTextLabel.text isEqualToString:@"phone"]){
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([cell.detailTextLabel.text isEqualToString:@"email"]){
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [[self.selectedPerson.attributes objectAtIndex:indexPath.row] isEqualToString:@"email"]){
        if([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
            mailViewController.mailComposeDelegate = self;
            
            mailViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            [mailViewController setToRecipients:[NSArray arrayWithObject:[self.selectedPerson.attributeVals objectAtIndex:indexPath.row]]];
            
            [self presentModalViewController:mailViewController animated:YES];
        }
    }
    else if (indexPath.section == 0 && [[self.selectedPerson.attributes objectAtIndex:indexPath.row] isEqualToString:@"phone"]){
        NSString *url = [[NSString alloc] initWithFormat:@"tel:%@", [self.selectedPerson.attributeVals objectAtIndex:indexPath.row]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
