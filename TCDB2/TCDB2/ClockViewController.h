//
//  ClockViewController.h
//  TCDB2
//
//  Created by Colin Tremblay on 12/1/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockViewController : UIViewController
- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)directoryButtonTapped:(id)sender;
- (IBAction)shiftsButtonTapped:(id)sender;
- (IBAction)scheduleButtonTapped:(id)sender;
- (IBAction)clockButtonTapped:(id)sender;
- (void)registerForKeyboardNotifications;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *menuButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *directoryButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *shiftsButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *scheduleButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *clockButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIToolbar *doneBar;
@property (nonatomic, strong) NSMutableArray *labsArray;
@property (nonatomic, weak) IBOutlet UITextField *labsField;
@property (nonatomic, weak) IBOutlet UITextView *commentField;
@property (nonatomic, weak) IBOutlet UIPickerView *labPicker;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UITextView *activeView;

@end
