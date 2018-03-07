//
//  NSString+MD5.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/25.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)
/** md5加密 */
- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    unsigned int x=(int)strlen(cStr) ;
    CC_MD5(cStr, x, digest);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

@end
