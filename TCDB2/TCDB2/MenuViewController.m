//
//  MenuViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 12/1/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "StaticPagesViewController.h"
#import "ProfileViewController.h"

@interface MenuViewController ()

@end
@implementation MenuViewController {
    AppDelegate *mainDelegate;
}

@synthesize menuArray;
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
    menuArray = [[NSMutableArray alloc] initWithObjects:@"Home", @"Profile", @"\t\t\t\t\tUpdate", @"Timesheet", @"Combo", @"Subs", @"Tools", @"Wiki", @"OldWiki", @"Total Hours", @"Etime", @"Handbook", @"Log Out", nil];
}

    //mainDelegate.deckController.centerController.nibName

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
    return menuArray.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [menuArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Home"])
        mainDelegate.deckController.centerController = mainDelegate.home;
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Combo"]){
        StaticPagesViewController *staticPage = [[StaticPagesViewController alloc] initWithNibName:@"StaticPagesViewController" bundle:nil];
        staticPage.urlLink = @"combo";
        mainDelegate.deckController.centerController = staticPage;
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Profile"]){
        ProfileViewController *profilePage = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        profilePage.selectedPerson = mainDelegate.me;
        profilePage.editing = FALSE;
        mainDelegate.deckController.centerController = profilePage;
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"\t\t\t\t\tUpdate"]){
        ProfileViewController *profilePage = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        profilePage.selectedPerson = mainDelegate.me;
        profilePage.editing = TRUE;
        mainDelegate.deckController.centerController = profilePage;
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Timesheet"]){
        //
        // NOTE!!!
        // THIS SHOULD NOT ACTUALLY BE A STATIC PAGE, SINCE IT INCLUDES ADD/DELETE SHIFTS
        // THE NON-STATIC VERSION CURRENTLY EXISTS AT timesheet
        //
        StaticPagesViewController *staticPage = [[StaticPagesViewController alloc] initWithNibName:@"StaticPagesViewController" bundle:nil];
        staticPage.urlLink = @"combinedtimesheet";
        mainDelegate.deckController.centerController = staticPage;
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Total Hours"]){
        StaticPagesViewController *staticPage = [[StaticPagesViewController alloc] initWithNibName:@"StaticPagesViewController" bundle:nil];
        staticPage.urlLink = @"total_hours";
        mainDelegate.deckController.centerController = staticPage;
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Tools"]){
        NSURL *url = [NSURL URLWithString:@"http://tcdb.grinnell.edu/tools/"];
        if (![[UIApplication sharedApplication] openURL:url])
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Wiki"]){
        NSURL *url = [NSURL URLWithString:@"http://tcdb.grinnell.edu/wiki/"];
        if (![[UIApplication sharedApplication] openURL:url])
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"OldWiki"]){
        NSURL *url = [NSURL URLWithString:@"http://tcdb.grinnell.edu/oldwiki/"];
        if (![[UIApplication sharedApplication] openURL:url])
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Handbook"]){
        NSURL *url = [NSURL URLWithString:@"http://tcdb.grinnell.edu/wiki/bin/view/TC+Handbook/WebHome"];
        if (![[UIApplication sharedApplication] openURL:url])
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Etime"]){
        NSURL *url = [NSURL URLWithString:@"https://eetime27.adphc.com/bm9e/applications/wtk/html/ess/logon.jsp"];
        if (![[UIApplication sharedApplication] openURL:url])
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
    else if ([[menuArray objectAtIndex:indexPath.row] isEqualToString:@"Log Out"]){
        mainDelegate.deckController.centerController = mainDelegate.login;
    mainDelegate.login.password.text = nil;
}
    [mainDelegate.deckController closeLeftView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
