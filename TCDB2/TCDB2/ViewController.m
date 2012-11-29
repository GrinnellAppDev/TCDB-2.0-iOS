//
//  ViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 11/28/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController {
    AppDelegate *mainDelegate;
}

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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonTapped:(id)sender{
    if(mainDelegate.deckController.leftControllerIsClosed)
        [mainDelegate.deckController openLeftView];
    else
        [mainDelegate.deckController closeLeftView];
}

- (IBAction)directoryButtonTapped:(id)sender{
}
- (IBAction)shiftsButtonTapped:(id)sender{
}
- (IBAction)scheduleButtonTapped:(id)sender{
}
- (IBAction)clockButtonTapped:(id)sender{
}
@end
