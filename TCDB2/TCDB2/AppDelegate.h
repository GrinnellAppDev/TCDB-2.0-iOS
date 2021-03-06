//
//  AppDelegate.h
//  TCDB2
//
//  Created by Colin Tremblay on 11/28/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MenuViewController.h"
#import "Person.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HomeViewController *home;
@property (strong, nonatomic) LoginViewController *login;
@property (strong, nonatomic) MenuViewController *menu;
@property (strong, nonatomic) IIViewDeckController* deckController;
@property (strong, nonatomic) Person *me;

@end
