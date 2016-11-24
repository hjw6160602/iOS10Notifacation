//
//  ManagementViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "ManagementViewController.h"
#import "NotificationHandler.h"
#import "NSObject+Extension.h"
#import <UserNotifications/UserNotifications.h>
#import "UIAlertController+Extension.h"

@interface ManagementViewController ()

@property (nonatomic, strong, readonly) UNMutableNotificationContent *title1Content;

@property (nonatomic, strong, readonly) UNMutableNotificationContent *title2Content;

@end

@implementation ManagementViewController

#pragma mark - Getter
- (UNMutableNotificationContent *)title1Content{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"标题1";
    content.body = @"通知内容 1";
    return content;
}

- (UNMutableNotificationContent *)title2Content{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"标题2";
    content.body = @"通知内容 2";
    return content;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions
- (IBAction)pendingRemovalOnClick:(id)sender {
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    NSString *identifier = [NotificationHandler userNotiRawValue:UserNotificationTypePendingRemoval];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:self.title1Content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
        } else{
            NSLog(@"通知请求 \"%@\" 被安排发送", identifier);
        }
    }];
    [self delay:2 Operation:^{
        NSLog(@"通知请求 \"%@\" 已经被移除", identifier);
        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[identifier]];
    }];
}


- (IBAction)pendingUpdatePressed:(id)sender {
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    NSString *identifier = [NotificationHandler userNotiRawValue:UserNotificationTypePendingUpdate];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:self.title1Content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
        } else{
            NSLog(@"名为 \"标题1\" 的通知请求 \"%@\" 已被安排发出", identifier);
        }
    }];
    
    [self delay:1 Operation:^{
        UNTimeIntervalNotificationTrigger *newTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        UNNotificationRequest *newRequest = [UNNotificationRequest requestWithIdentifier:identifier content:self.title2Content trigger:newTrigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:newRequest withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
            } else{
                NSLog(@"通知 \"%@\" 标题被更新为 \"标题2\"", identifier);
            }
        }];
    }];
}

- (IBAction)deliveredRemovalPressed:(id)sender {
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    NSString *identifier = [NotificationHandler userNotiRawValue:UserNotificationTypeDeliveredRemoval];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:self.title1Content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
        } else{
            NSLog(@"通知请求 \"%@\" 已被安排发出", identifier);
        }
    }];
    
    [self delay:4 Operation:^{
        NSLog(@"通知请求 \"%@\" 已经被移除", identifier);
        [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[identifier]];
    }];
}

- (IBAction)deliveredUpdatePressed:(id)sender {
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    NSString *identifier = [NotificationHandler userNotiRawValue:UserNotificationTypePendingUpdate];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:self.title1Content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
        } else{
            NSLog(@"名为 \"标题1\" 的通知请求 \"%@\" 已被安排发出", identifier);
        }
    }];

    [self delay:4 Operation:^{
        UNTimeIntervalNotificationTrigger *newTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        UNNotificationRequest *newRequest = [UNNotificationRequest requestWithIdentifier:identifier content:self.title2Content trigger:newTrigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:newRequest withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
            } else{
                NSLog(@"通知 \"%@\" 标题被更新为 \"标题2\"", identifier);
            }
        }];
    }];
}
@end
