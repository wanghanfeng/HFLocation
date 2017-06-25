//
//  HFLocation.h
//  HFLocation
//
//  Created by whf on 17/6/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFLocation : NSObject

- (instancetype)sharedInstance;
- (void)getLocationName:(void(^) (NSError *error,NSDictionary *result))block;

@end
