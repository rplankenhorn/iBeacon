//
//  WundergroundController.h
//  SmartHubDesktop
//
//  Created by Robbie Plankenhorn on 10/31/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

FOUNDATION_EXPORT NSString *const WundergroundAPIBaseURL;
FOUNDATION_EXPORT NSString *const WundergroundAPIKey;
FOUNDATION_EXPORT NSString *const WundergroundAPIConditions;
FOUNDATION_EXPORT NSString *const WundergroundAPIGeoLookup;

@interface WundergroundController : NSObject

- (void)conditionsWithCity:(NSString *)city state:(NSString *)state completion:(void (^)(NSDictionary *))completionBlock;
- (void)geolookup:(CLLocation *)location completion:(void (^)(NSDictionary *))completionBlock;

@end