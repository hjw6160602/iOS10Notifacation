//
//  AudioViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/12/15.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "AudioViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "UIAlertController+Extension.h"
#import "NotificationHandler.h"

@interface AudioViewController ()

@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)notificationButtonPressed:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.title = @"土耳其冰激凌";
    content.body = @"周杰伦新专辑-床边故事";
    
    NSArray *mp3Names = @[@"小苹果"];
    NSMutableArray *attachments = [NSMutableArray array];
    for (NSString *mp3Name in mp3Names) {
        NSURL *mp3URL = [[NSBundle mainBundle]URLForResource:mp3Name withExtension:@"mp3"];
        NSString *identifier = [NSString stringWithFormat:@"mp3-%@",mp3Name];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:mp3URL options:nil error:nil];
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
            NSLog(@"mp3格式的音频通知:\"%@\"已经被安排发送:",requestIdentifier);
        }
    }];
}


@end
