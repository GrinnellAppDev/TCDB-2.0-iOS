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
#import "EditViewController.h"

@implementation ProfileViewController {
    AppDelegate *mainDelegate;
    EditViewController *editView;
}
@synthesize clockButton, scheduleButton, shiftsButton, directoryButton, menuButton, selectedPerson, table, editing, editAttr, editVal;
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
    if (editing){
        editView = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
        mainDelegate.deckController.rightController = editView;
        mainDelegate.deckController.rightLedge = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Create header view and add name/picture as subviews
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(120, 40, 200, 30);
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
    if (mainDelegate.deckController.rightControllerIsOpen)
        [mainDelegate.deckController toggleRightView];
    mainDelegate.deckController.rightController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (UIInterfaceOrientationPortrait == interfaceOrientation);
}

#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (0 == section)
        if (self.selectedPerson == mainDelegate.me)
            return 7;
        else return 6;
    else if (1 == section)
        return self.selectedPerson.upcomingShifts.count;
    else return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    if (0 == indexPath.section){
        cell.textLabel.text = [self.selectedPerson.attributeVals objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.selectedPerson.attributes objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [self.selectedPerson.upcomingShifts objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.selectedPerson.upcomingShiftLocations objectAtIndex:indexPath.row];
    }
    
    if(editing && 0 == indexPath.section){
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
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
    }
    return cell;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editing){
        editView.value.text = [self.selectedPerson.attributeVals objectAtIndex:indexPath.row];
        editView.attribute.text = [self.selectedPerson.attributes objectAtIndex:indexPath.row];
        [mainDelegate.deckController toggleRightView];
    }
    else{
    if (0 == indexPath.section && [[self.selectedPerson.attributes objectAtIndex:indexPath.row] isEqualToString:@"email"]){
        if([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
            mailViewController.mailComposeDelegate = self;
            
            mailViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            [mailViewController setToRecipients:[NSArray arrayWithObject:[self.selectedPerson.attributeVals objectAtIndex:indexPath.row]]];
            
            [self presentModalViewController:mailViewController animated:YES];
        }
    }
    else if (0 == indexPath.section && [[self.selectedPerson.attributes objectAtIndex:indexPath.row] isEqualToString:@"phone"]){
        NSString *url = [[NSString alloc] initWithFormat:@"tel:%@", [self.selectedPerson.attributeVals objectAtIndex:indexPath.row]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
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
