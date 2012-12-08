//
//  LoginViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 12/6/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "LoginViewController.h"
#import "SBJson.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@end

@implementation LoginViewController{
    AppDelegate *mainDelegate;
}
@synthesize username, password, goButton;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (IBAction)goButtonTapped:(id)sender{
    @try {
        
        if([self.username.text isEqualToString:@""] || [self.password.text isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"login_username=%@&login_password=%@",self.username.text, self.password.text];
            //NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://tcdb.grinnell.edu/"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/html" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
//            [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            //NSLog(@"Response code: %d", [response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
               // NSLog(@"Response ==> %@", responseData);
                
                NSInteger success;
                if ([responseData rangeOfString:@"Displaying who is logged in"].location == NSNotFound)
                    success = 0;
                else
                    success = 1;
                
                if(success == 1)
                {
                    //NSLog(@"Login SUCCESS");
                   // [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    mainDelegate.deckController.centerController = mainDelegate.home;
                    mainDelegate.deckController.leftController = mainDelegate.menu;
                    
                } else {
                    
                    //NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    [self alertStatus:nil :@"Login Failed!"];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Login Failed!"];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
    
    
    
    
    
    /*
    
NSMutableData *responseData = [NSMutableData data];

NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://tcdb.grinnell.edu/index.php"]];

NSString *params = [[NSString alloc] initWithFormat:@"user=%@&pass=%@", self.username.text, self.password.text];
[request setHTTPMethod:@"POST"];
[request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
[[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}
@end
