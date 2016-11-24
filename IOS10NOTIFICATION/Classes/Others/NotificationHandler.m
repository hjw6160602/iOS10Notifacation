//
//  NotificationHandler.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "NotificationHandler.h"
#import "NSDictionary+Extension.h"


typedef NS_ENUM(NSInteger, NotiPresentType){
    NotiPresentTypeForeground = 0,
    NotiPresentTypeBackground
};

@interface NotificationHandler()<UNUserNotificationCenterDelegate>

@end

@implementation NotificationHandler

+ (NSString *)userNotiTitle:(UserNotificationType)notiType{
    switch (notiType) {
        case UserNotificationTypeTimeInterval:
            return @"时间戳通知";
            break;
        case UserNotificationTypeTimeIntervalForeground:
            return @"前台时间戳通知";
            break;
        default:
            return @"";
            break;
    }
}

+ (NSString *)userNotiDescriptionText:(UserNotificationType)notiType{
    switch (notiType) {
        case UserNotificationTypeTimeInterval:
            return @"你需要切换到后台来显示通知。";
            break;
        case UserNotificationTypeTimeIntervalForeground:
            return @"在App里就可以看到通知，点击通知可看到更多内容。";
            break;
        default:
            return @"";
            break;
    }
}

+ (NSString *)userNotiRawValue:(UserNotificationType)notiType{
    switch (notiType) {
        case UserNotificationTypeTimeInterval:
            return @"timeInterval0";
            break;
        case UserNotificationTypeTimeIntervalForeground:
            return @"timeIntervalForeground1";
            break;
        case UserNotificationTypePendingRemoval:
            return @"pendingRemoval2";
            break;
        case UserNotificationTypePendingUpdate:
            return @"pendingUpdate3";
            break;
        case UserNotificationTypeDeliveredRemoval:
            return @"deliveredRemoval4";
            break;
        case UserNotificationTypeDeliveredUpdate:
            return @"deliveredUpdate5";
            break;
        case UserNotificationTypeActionable:
            return @"actionable6";
            break;
        case UserNotificationTypeMutableContent:
            return @"mutableContent7";
            break;
        case UserNotificationTypeMedia:
            return @"media8";
            break;
        case UserNotificationTypeCustomUI:
            return @"customUI9";
            break;
        default:
            return @"";
            break;
    }
}

+ (UserNotificationType)notiTypeWithRawValue:(NSString *)rawValue{
    NSString *rawType = [rawValue substringFromIndex:rawValue.length - 1];
    return rawType.integerValue;
}

#pragma mark - <UNUserNotificationCenterDelegate>
//__IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    [self descriptonOfNoti:notification presentType:NotiPresentTypeForeground];

    UserNotificationType notificationType = [NotificationHandler notiTypeWithRawValue:notification.request.identifier];
    
    if (!notificationType) {
        completionHandler(0);
        return;
    }
    
    UNNotificationPresentationOptions options;
    switch (notificationType) {
        case UserNotificationTypeTimeIntervalForeground:
            options = UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound;
            break;
        case UserNotificationTypePendingRemoval:
            options = UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound;
            break;
        case UserNotificationTypePendingUpdate:
            options = UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound;
            break;
        case UserNotificationTypeDeliveredRemoval:
            options = UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound;
            break;
        case UserNotificationTypeDeliveredUpdate:
            options = UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound;
            break;
        case UserNotificationTypeActionable:
            options = UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound;
            break;
        case UserNotificationTypeMedia:
            options = UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound;
            break;
        default:
            options = 0;
            break;
    }
    completionHandler(options);
}


// __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    [self descriptonOfNoti:response.notification presentType:NotiPresentTypeBackground];
    completionHandler();  // 交给系统来处理执行收到通知之后的操作
}

- (void)descriptonOfNoti:(UNNotification *)noti presentType:(NotiPresentType)type{
    NSString *presentType = @"后台";
    if (type) {
        presentType = @"前台";
    }
    NSDictionary * userInfo = noti.request.content.userInfo;
    UNNotificationRequest *request = noti.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([noti.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"%@收到远程通知:%@", presentType, [userInfo descriptionWithLog]);
    } else {
        // 判断为本地通知
        NSLog(@"%@收到本地通知:\n{\n    body:%@,\n    title:%@,\n    subtitle:%@,\n    badge：%@,\n    sound：%@,\n    userInfo：%@\n}",presentType,body,title,subtitle,badge,sound,userInfo);
    }
}

@end
