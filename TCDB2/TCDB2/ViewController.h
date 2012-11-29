//
//  ViewController.h
//  TCDB2
//
//  Created by Colin Tremblay on 11/28/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)directoryButtonTapped:(id)sender;
- (IBAction)shiftsButtonTapped:(id)sender;
- (IBAction)scheduleButtonTapped:(id)sender;
- (IBAction)clockButtonTapped:(id)sender;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *menuButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *directoryButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *shiftsButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *scheduleButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *clockButton;

@end
