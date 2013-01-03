//
//  EditViewController.h
//  TCDB2
//
//  Created by Colin Tremblay on 1/2/13.
//  Copyright (c) 2013 GrinnellAppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController

- (IBAction)cancel:(id)sender;
- (IBAction)saveVal:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;

@property (nonatomic, weak) IBOutlet UITextField *value;
@property (nonatomic, weak) IBOutlet UILabel *attribute;

@end
