//
//  StaticPagesViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 12/6/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "StaticPagesViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ClockViewController.h"
#import "ScheduleViewController.h"
#import "DirectoryViewController.h"
#import "ShiftsViewController.h"

@interface StaticPagesViewController ()

@end

@implementation StaticPagesViewController{
    AppDelegate *mainDelegate;
}

@synthesize clockButton, scheduleButton, shiftsButton, directoryButton, menuButton, webView, urlLink;
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
    NSString *url = [[NSString alloc] initWithFormat:@"http://tcdb.grinnell.edu/%@.php", urlLink];
    NSURL *urlString = [[NSURL alloc] initWithString:url];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:urlString];
    NSData *returnData = [NSURLConnection
                          sendSynchronousRequest:urlRequest
                          returningResponse:nil
                          error:nil];
    NSString *HTMLData = [[NSString alloc] initWithData:returnData
                                               encoding:NSUTF8StringEncoding];
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    resourcePath = [resourcePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
    resourcePath = [resourcePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [self.webView loadHTMLString:HTMLData baseURL:[NSURL URLWithString:[NSString stringWithFormat:@"file:/%@//",resourcePath]]];
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
