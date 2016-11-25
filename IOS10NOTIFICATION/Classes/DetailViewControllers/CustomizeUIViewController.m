//
//  CustomizeUIViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "CustomizeUIViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "NotificationHandler.h"
#import "UIAlertController+Extension.h"

@interface CustomizeUIViewController ()

@end

@implementation CustomizeUIViewController

- (IBAction)notificationButtonPressed:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.title = @"图片通知";
    content.body = @"把图片显示出来吧！";
    
    NSArray *imageNames = @[@"image", @"onecat"];
    NSMutableArray *attachments = [NSMutableArray array];
    for (NSString *imgName in imageNames) {
        NSURL *imgURL = [[NSBundle mainBundle]URLForResource:imgName withExtension:@"jpg"];
        NSString *identifier = [NSString stringWithFormat:@"image-%@",imgName];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:imgURL options:nil error:nil];
        [attachments addObject:attachment];
    }
    
    content.attachments = attachments;
    
    content.userInfo = @{ @"items" :
                            @[
                                @{@"title": @"Photo 2",
                                  @"text": @"Kobe!"
                                },
                                @{@"title": @"Photo 1",
                                  @"text": @"Cat!"
                                }
                             ]
                        };
    content.categoryIdentifier = [NotificationHandler categoryRawValue:UserNotificationCategoryTypeCustomUI];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    NSString *requestIdentifier = [NotificationHandler userNotiRawValue:UserNotificationTypeCustomUI];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
        } else {
            NSLog(@"自定义UI类型的通知:\"%@\"已经被安排发送:",requestIdentifier);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
