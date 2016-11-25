//
//  NotificationPresentItem.h
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/25.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationPresentItem : NSObject

@property (nonatomic, copy) NSURL *url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *text;

+ (instancetype)itemWithURL: (NSURL *)url Title:(NSString *)title Text:(NSString *)text;

@end
