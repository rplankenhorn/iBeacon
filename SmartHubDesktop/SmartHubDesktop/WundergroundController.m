//
//  WundergroundController.m
//  SmartHubDesktop
//
//  Created by Robbie Plankenhorn on 10/31/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import "WundergroundController.h"

NSString *const WundergroundAPIKey = @"85931c4217bc8e21";

@implementation WundergroundController

- (void)getConditions:(void (^)(NSString *))callbackBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.wunderground.com/api/85931c4217bc8e21/conditions/q/IL/Chicago.json"]];
        NSURLResponse *response;
        NSError *error;
        NSString *conditions = nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if(error == nil)
        {
            conditions = [NSString stringWithUTF8String:[data bytes]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            callbackBlock(conditions);
        });
    });
}

@end