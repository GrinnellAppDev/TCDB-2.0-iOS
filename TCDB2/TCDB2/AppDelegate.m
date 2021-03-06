//
//  AppDelegate.m
//  TCDB2
//
//  Created by Colin Tremblay on 11/28/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "AppDelegate.h"
#import "IIViewDeckController.h"
#import "HomeViewController.h"
#import "MenuViewController.h"
#import "ClockViewController.h"
#import "LoginViewController.h"
#import "Person.h"

@implementation AppDelegate
@synthesize window, deckController, home, login, menu, me;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    // prepare view controllers
    self.menu = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    self.deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.login leftViewController:nil rightViewController:nil];
    
    self.window.rootViewController = self.deckController;
    [self.window makeKeyAndVisible];
    self.me = [[Person alloc] init];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
