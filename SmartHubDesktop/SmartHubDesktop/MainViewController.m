//
//  MainViewController.m
//  SmartHubDesktop
//
//  Created by Robbie Plankenhorn on 10/31/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

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
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    wundergroundController = [[WundergroundController alloc] init];
    
    [currentTemperature setStringValue:@""];
    
    [self updateTime];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)updateTime
{
    NSString *currentTimeString = [[dateFormatter stringFromDate:[NSDate date]] lowercaseString];
    [currentTime setStringValue:currentTimeString];
}

- (void)updateTemperature
{
    [wundergroundController conditionsWithCity:currentCity state:currentState completion:^(NSDictionary *conditions) {
        NSDictionary *currentObservation = [conditions objectForKey:@"current_observation"];
        double temperature = [[currentObservation objectForKey:@"temp_f"] doubleValue];
        [currentTemperature setStringValue:[NSString stringWithFormat:@"%d F", (int)(temperature + 0.5)]];
    }];
}

#pragma mark - CLLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLocation = newLocation;
    [locationManager stopMonitoringSignificantLocationChanges];
    
    [wundergroundController geolookup:currentLocation completion:^(NSDictionary *geolookup) {
        NSDictionary *location = [geolookup objectForKey:@"location"];
        currentState = [location objectForKey:@"state"];
        currentCity = [location objectForKey:@"city"];
        
        [self updateTemperature];
    }];
}

@end