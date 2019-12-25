//
//  NetworkHelper.h
//  CriteriaParser
//
//  Created by Uzma Sayyed on 23/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkHelper : NSObject

+ (void)getConfigData:(void (^)(NSString *dataString, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
