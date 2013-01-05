//
//  EditViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 1/2/13.
//  Copyright (c) 2013 GrinnellAppDev. All rights reserved.
//

#import "EditViewController.h"
#import "AppDelegate.h"

@interface EditViewController ()

@end

@implementation EditViewController{
    AppDelegate *mainDelegate;
}
@synthesize attribute, value, parent;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
        mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)saveVal:(id)sender{
    [value resignFirstResponder];
    [mainDelegate.me.attributeVals replaceObjectAtIndex:[mainDelegate.me.attributes indexOfObject:attribute.text] withObject:value.text];
    [parent.table reloadData];
    [mainDelegate.deckController toggleRightView];
}

- (IBAction)cancel:(id)sender{
    [value resignFirstResponder];
    [mainDelegate.deckController toggleRightView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
