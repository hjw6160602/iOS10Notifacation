//
//  NSDictionary+Extension.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/24.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSString *)descriptionWithLog
{
    
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"{\n"];
    
    for (id obj in [self allKeys]) {
        [strM appendFormat:@"\t\t%@,", obj];
        
        [strM appendFormat:@"%@\n", self[obj]];
    }
    
    [strM appendString:@"}"];
    
    return strM;
}
@end
