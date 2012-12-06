//
//  LoginViewController.h
//  TCDB2
//
//  Created by Colin Tremblay on 12/6/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)goButtonTapped:(id)sender;
@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (nonatomic, weak) IBOutlet UIButton *goButton;

@end
