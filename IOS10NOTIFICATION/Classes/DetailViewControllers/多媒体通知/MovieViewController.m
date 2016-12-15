//
//  MovieViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/12/15.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "MovieViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "UIAlertController+Extension.h"
#import "NotificationHandler.h"

@interface MovieViewController ()

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)notificationButtonPressed:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.title = @"五月天";
    content.body = @"网友实拍五月天演唱会现场-孙悟空";
    
    NSArray *movNames = @[@"五月天"];
    NSMutableArray *attachments = [NSMutableArray array];
    for (NSString *movName in movNames) {
        NSURL *movURL = [[NSBundle mainBundle]URLForResource:movName withExtension:@"MOV"];
        NSString *identifier = [NSString stringWithFormat:@"mov-%@",movName];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:movURL options:nil error:nil];
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
            NSLog(@"mov格式的视频通知:\"%@\"已经被安排发送:",requestIdentifier);
        }
    }];
}


@end
