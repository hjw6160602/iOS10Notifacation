//
//  TimeIntervalViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "TimeIntervalViewController.h"
#import "NotificationHandler.h"
#import "UIAlertController+Extension.h"

@interface TimeIntervalViewController ()

@property (weak, nonatomic) IBOutlet UITextField *timeTextField;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation TimeIntervalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NotificationHandler userNotiTitle:self.notificationType];
    self.descriptionLabel.text = [NotificationHandler userNotiDescriptionText:self.notificationType];
}



- (IBAction)scheduleButtonPressed:(id)sender {
    NSString *text = self.timeTextField.text;
    NSTimeInterval timeInterval = [text doubleValue];
    if (!timeInterval) {
        NSLog(@"无效的时间戳");
        return;
    }
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    // Create notification content
    content.title = @"时间戳通知";
    content.body = @"我的第一条通知";
    
    // Create a trigger to decide when/where to present the notification
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:NO];
    
    // Create an identifier for this notification. So you could manage it later.
    NSString *requestIdentifier = [NotificationHandler userNotiRawValue:self.notificationType];
    
    // The request describes this notification.
    UNNotificationRequest *request =[UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
        }else{
            [NSString stringWithFormat:@"时间戳通知\"%@\"已安排",requestIdentifier];
        }
    }];
}



@end
