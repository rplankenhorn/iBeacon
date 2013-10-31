//
//  WundergroundController.h
//  SmartHubDesktop
//
//  Created by Robbie Plankenhorn on 10/31/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const WundergroundAPIKey;

@interface WundergroundController : NSObject

- (void)getConditions:(void (^)(NSString *))callbackBlock;

@end