//
//  HeaderViewController.m
//  SmartOfficeDesktopTouch
//
//  Created by Robbie Plankenhorn on 11/6/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import "HeaderViewController.h"

@interface HeaderViewController ()

@end

@implementation HeaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a"];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    wundergroundController = [[WundergroundController alloc] init];
    
    [currentTemperature setText:@""];
    
    [self updateTime];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)updateTime
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    
    [currentDay setText:[NSString stringWithFormat:@"%.2ld",(long)[components day]]];
    [currentMonth setText:[[[dateFormatter shortMonthSymbols] objectAtIndex:[components month]-1] uppercaseString]];
    
    NSString *currentTimeString = [[dateFormatter stringFromDate:now] lowercaseString];
    [currentTime setText:currentTimeString];
}

- (void)updateTemperature
{
    [wundergroundController conditionsWithCity:currentCity state:currentState completion:^(NSDictionary *conditions) {
        if(conditions != nil)
        {
            NSDictionary *currentObservation = [conditions objectForKey:@"current_observation"];
            double temperature = [[currentObservation objectForKey:@"temp_f"] doubleValue];
            [currentTemperature setText:[NSString stringWithFormat:@"%d°F", (int)(temperature + 0.5)]];
        }
    }];
}

#pragma mark - CLLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLocation = newLocation;
    [locationManager stopMonitoringSignificantLocationChanges];
    locationManager = nil;
    
    [wundergroundController geolookup:currentLocation completion:^(NSDictionary *geolookup) {
        NSDictionary *location = [geolookup objectForKey:@"location"];
        currentState = [location objectForKey:@"state"];
        currentCity = [location objectForKey:@"city"];
        
        [self updateTemperature];
    }];
}

@end