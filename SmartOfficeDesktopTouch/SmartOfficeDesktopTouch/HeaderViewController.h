//
//  HeaderViewController.h
//  SmartOfficeDesktopTouch
//
//  Created by Robbie Plankenhorn on 11/6/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WundergroundController.h"
#import <CoreLocation/CoreLocation.h>

@interface HeaderViewController : UIViewController <CLLocationManagerDelegate>
{
    IBOutlet UILabel *currentDay;
    IBOutlet UILabel *currentTime;
    IBOutlet UILabel *currentTemperature;
    
    NSDateFormatter *dateFormatter;
    WundergroundController *wundergroundController;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    NSString *currentState;
    NSString *currentCity;
}

@end