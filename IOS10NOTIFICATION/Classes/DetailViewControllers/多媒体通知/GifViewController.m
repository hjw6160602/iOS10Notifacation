//
//  GifViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/12/15.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "GifViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "UIAlertController+Extension.h"
#import "NotificationHandler.h"

@interface GifViewController ()

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)notificationButtonPressed:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.title = @"百思不得姐";
    content.body = @"糗事百科大全-推车惨案";
    
    NSArray *gifNames = @[@"car"];
    NSMutableArray *attachments = [NSMutableArray array];
    for (NSString *gifName in gifNames) {
        NSURL *gifURL = [[NSBundle mainBundle]URLForResource:gifName withExtension:@"gif"];
        NSString *identifier = [NSString stringWithFormat:@"gif-%@",gifName];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:gifURL options:nil error:nil];
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
            NSLog(@"gif格式的动态图片通知:\"%@\"已经被安排发送:",requestIdentifier);
        }
    }];
}

@end
