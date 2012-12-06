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
    menuArray = [[NSMutableArray alloc] initWithObjects:@"Home", @"Profile", @"\t\t\t\t\tUpdate", @"Combo", @"Subs", @"Tools", @"Wiki", @"OldWiki", @"Total Hours", @"Etime", @"Handbook", nil];
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
    return menuArray.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
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
        mainDelegate.deckController.centerController = staticPage;
    }
    [mainDelegate.deckController closeLeftView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
