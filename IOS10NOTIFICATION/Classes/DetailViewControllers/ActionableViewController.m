//
//  ActionableViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "ActionableViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "NotificationHandler.h"

@interface ActionableViewController ()

@end

@implementation ActionableViewController


- (IBAction)notificationButtonPressed:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.body = @"说点什么吧。";
    content.categoryIdentifier = [NotificationHandler categoryRawValue:UserNotificationCategoryTypeSaySomething];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[NotificationHandler userNotiRawValue:UserNotificationTypeActionable] content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
}


@end
