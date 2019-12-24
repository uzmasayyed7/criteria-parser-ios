//
//  NetworkHelper.h
//  CriteriaParser
//
//  Created by Uzma Sayyed on 23/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define CONFIG_URL @"https://mp-android-challenge.herokuapp.com/data"

@interface NetworkHelper : NSObject

- (void)getConfigData:(void (^)(NSString *dataString, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
