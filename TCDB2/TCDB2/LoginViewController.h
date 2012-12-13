//
//  LoginViewController.h
//  TCDB2
//
//  Created by Colin Tremblay on 12/6/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (void)go;
- (IBAction)goButtonTapped:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;
@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (nonatomic, weak) IBOutlet UIButton *goButton;

@end
