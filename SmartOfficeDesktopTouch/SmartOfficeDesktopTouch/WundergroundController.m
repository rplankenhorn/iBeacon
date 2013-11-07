//
//  WundergroundController.m
//  SmartHubDesktop
//
//  Created by Robbie Plankenhorn on 10/31/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import "WundergroundController.h"

NSString *const WundergroundAPIBaseURL = @"http://api.wunderground.com/api";
NSString *const WundergroundAPIKey = @"85931c4217bc8e21";
NSString *const WundergroundAPIConditions = @"conditions";
NSString *const WundergroundAPIGeoLookup = @"geolookup";

@implementation WundergroundController

- (void)conditionsWithCity:(NSString *)city state:(NSString *)state completion:(void (^)(NSDictionary *))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        NSDictionary *conditions = nil;
        
        NSURL *url = [self createRequestURLPrefix:WundergroundAPIConditions parameters:[NSString stringWithFormat:@"%@/%@.json", state, city]];
        conditions = [self sendRequestToURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            completionBlock(conditions);
        });
    });
}

- (void)geolookup:(CLLocation *)location completion:(void (^)(NSDictionary *))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        NSDictionary *geolookup = nil;
        
        NSURL *url = [self createRequestURLPrefix:WundergroundAPIGeoLookup parameters:[NSString stringWithFormat:@"%lf,%lf.json", location.coordinate.latitude, location.coordinate.longitude]];
        geolookup = [self sendRequestToURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            completionBlock(geolookup);
        });
    });
}

- (NSURL *)createRequestURLPrefix:(NSString *)request parameters:(NSString *)parameters
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@/q/%@", WundergroundAPIBaseURL, WundergroundAPIKey, request, parameters];
    return [NSURL URLWithString:urlString];
}

- (NSDictionary *)sendRequestToURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSDictionary *conditions = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(error == nil)
    {
        conditions = [self parseJSONResponse:data];
    }
    
    return conditions;
}

- (NSDictionary *)parseJSONResponse:(NSData *)responseData
{
    if(responseData == nil)
    {
        return nil;
    }
    
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        
        if(error)
        {
            /* JSON was malformed, act appropriately here */
            return nil;
        }
        
        // the originating poster wants to deal with dictionaries;
        // assuming you do too then something like this is the first
        // validation step:
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *results = object;
            
            return results;
        }
        else
        {
            /* there's no guarantee that the outermost object in a JSON
             packet will be a dictionary; if we get here then it wasn't,
             so 'object' shouldn't be treated as an NSDictionary; probably
             you need to report a suitable error condition */
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

@end