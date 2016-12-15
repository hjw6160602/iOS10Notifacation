//
//  MediaViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "PhotoViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "UIAlertController+Extension.h"
#import "NotificationHandler.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController


- (IBAction)notificationButtonPressed:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];

    content.title = @"精彩瞬间";
    content.body = @"科比·布莱恩特！夺冠时刻！";
    
    NSArray *imageNames = @[@"image", @"onecat"];
    NSMutableArray *attachments = [NSMutableArray array];
    for (NSString *imgName in imageNames) {
        NSURL *imgURL = [[NSBundle mainBundle]URLForResource:imgName withExtension:@"jpg"];
        NSString *identifier = [NSString stringWithFormat:@"image-%@",imgName];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:imgURL options:nil error:nil];
        [attachments addObject:attachment];
    }

    content.attachments = attachments;

    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    NSString *requestIdentifier = [NotificationHandler userNotiRawValue:UserNotificationTypeMedia];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
        } else {
            NSLog(@"png格式的图片通知:\"%@\"已经被安排发送:",requestIdentifier);
        }
    }];
}


@end
