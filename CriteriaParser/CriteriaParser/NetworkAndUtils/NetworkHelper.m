//
//  NetworkHelper.m
//  CriteriaParser
//
//  Created by Uzma Sayyed on 23/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import "NetworkHelper.h"

@implementation NetworkHelper

+ (void)getConfigData:(void (^)(NSString *dataString, NSError *error))completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.timeoutIntervalForRequest = 120;
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:CONFIG_URL]
                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:120];
    
    NSLog(@"Will fetch config data for URL:\n%@", CONFIG_URL);
    
    [[urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error in fetching Config File: %@", [error description]);
        }
        
        NSString *dataString = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"fetched config data:\n%@", dataString);
        
        completion(dataString, error);
        
    }] resume];
}

@end
