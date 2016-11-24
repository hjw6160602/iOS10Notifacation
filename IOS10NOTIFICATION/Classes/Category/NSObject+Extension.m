//
//  NSObject+Extension.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/24.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (void)delay:(NSTimeInterval)timeInterval Operation:(void(^)())operation{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        operation();
    });
}

@end
