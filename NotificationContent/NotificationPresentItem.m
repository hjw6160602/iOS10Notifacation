//
//  NotificationPresentItem.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/25.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "NotificationPresentItem.h"

@implementation NotificationPresentItem

- (instancetype)initWithURL: (NSURL *)url Title:(NSString *)title Text:(NSString *)text{
    if (self = [super init]) {
        self.url = url;
        self.title = title;
        self.text = text;
    }
    return self;
}

+ (instancetype)itemWithURL: (NSURL *)url Title:(NSString *)title Text:(NSString *)text{
    return [[self alloc]initWithURL:url Title:title Text:text];
}

@end
