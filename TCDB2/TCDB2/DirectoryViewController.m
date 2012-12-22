//
//  DirectoryViewController.m
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
#import "ProfileViewController.h"

@interface DirectoryViewController ()

@end

@implementation DirectoryViewController {
    AppDelegate *mainDelegate;
}
@synthesize clockButton, scheduleButton, shiftsButton, directoryButton, menuButton, table, people;
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
    // Do any additional setup after loading the view from its nib.
    Person *person1 = [[Person alloc] init];
    Person *person2 = [[Person alloc] init];
    Person *person3 = [[Person alloc] init];
    person1.name = @"Person One";
    person2.name = @"Person Two";
    person3.name = @"Person Three";
    NSArray *peopleArray = [[NSArray alloc] initWithObjects:person1, person2, person3, nil];
    people = [[NSMutableArray alloc] initWithArray:peopleArray];
    
    // Create header view and add title as subview
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 5, 320, 25);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = @"Directory";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [view addSubview:label];
    table.tableHeaderView = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0)
        return people.count;
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
    Person *tempPerson = [people objectAtIndex:indexPath.row];
    cell.textLabel.text = tempPerson.name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileViewController *profilePage = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    profilePage.selectedPerson = [people objectAtIndex:indexPath.row];
    mainDelegate.deckController.centerController = profilePage;
    
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
