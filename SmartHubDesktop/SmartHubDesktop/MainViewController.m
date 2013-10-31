//
//  MainViewController.m
//  SmartHubDesktop
//
//  Created by Robbie Plankenhorn on 10/31/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Initialization code here.
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a"];
    
    wundergroundController = [[WundergroundController alloc] init];
    
    [self updateTime];
    [self updateTemperature];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)updateTime
{
    NSString *currentTimeString = [[dateFormatter stringFromDate:[NSDate date]] lowercaseString];
    [currentTime setStringValue:currentTimeString];
}

- (void)updateTemperature
{
    [wundergroundController getConditions:^(NSString *conditions) {
        NSLog(@"conditions: %@", conditions);
    }];
}

@end