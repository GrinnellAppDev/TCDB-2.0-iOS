//
//  ProfileViewController.h
//  TCDB2
//
//  Created by Colin Tremblay on 12/13/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface ProfileViewController : UIViewController
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
@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, strong) Person *selectedPerson;
@end
