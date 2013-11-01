//
//  MainViewController.h
//  SmartHubDesktop
//
//  Created by Robbie Plankenhorn on 10/31/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WundergroundController.h"
#import <CoreLocation/CoreLocation.h>
#import "GuestViewController.h"

@interface MainViewController : NSViewController <CLLocationManagerDelegate>
{
    IBOutlet NSTextField *currentTime;
    IBOutlet NSTextField *currentTemperature;
    
    NSDateFormatter *dateFormatter;
    WundergroundController *wundergroundController;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    NSString *currentState;
    NSString *currentCity;
}

@end