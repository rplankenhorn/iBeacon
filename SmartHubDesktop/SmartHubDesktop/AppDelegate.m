//
//  AppDelegate.m
//  SmartHubDesktop
//
//  Created by Robbie Plankenhorn on 10/31/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "GuestViewController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.window setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
    
    viewControllers = [[NSMutableArray alloc] init];
    
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [viewControllers addObject:mainViewController];
    
    GuestViewController *guestViewController = [[GuestViewController alloc] initWithNibName:@"GuestViewController" bundle:nil];
    [viewControllers addObject:guestViewController];
    
    currentViewControllerIndex = 0;
    
    [self.window.contentView addSubview:mainViewController.view];
    currentSubView = mainViewController.view;
    mainViewController.view.frame = ((NSView *)self.window.contentView).bounds;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextView) userInfo:nil repeats:YES];
}

- (void)nextView
{
    currentViewControllerIndex++;
    
    if(currentViewControllerIndex >= [viewControllers count])
    {
        currentViewControllerIndex = 0;
    }
    
    NSViewController *nextViewController = [viewControllers objectAtIndex:currentViewControllerIndex];
    [self switchView:nextViewController];
}

- (void)switchView:(NSViewController *)viewController
{
    [self.window.contentView replaceSubview:currentSubView with:viewController.view];
    currentSubView = viewController.view;
    viewController.view.frame = ((NSView *)self.window.contentView).bounds;
}

@end