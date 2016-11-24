//
//  NotificationHandler.h
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

typedef NS_ENUM(NSUInteger, UserNotificationType){
    UserNotificationTypeTimeInterval = 0,
    UserNotificationTypeTimeIntervalForeground = 1,
    UserNotificationTypePendingRemoval = 2,
    UserNotificationTypePendingUpdate = 3,
    UserNotificationTypeDeliveredRemoval = 4,
    UserNotificationTypeDeliveredUpdate = 5,
    UserNotificationTypeActionable = 6,
    UserNotificationTypeMutableContent = 7,
    UserNotificationTypeMedia = 8,
    UserNotificationTypeCustomUI = 9
};

typedef NS_ENUM(NSUInteger, UserNotificationCategoryType){
    UserNotificationCategoryTypeSaySomething = 1,
    UserNotificationCategoryTypeCustomUI = 2
};


typedef NS_ENUM(NSUInteger, SaySomethingCategoryAction){
    SaySomethingCategoryActionInput = 1,
    SaySomethingCategoryActionGoodbye = 2,
    SaySomethingCategoryActionNone = 3
};

typedef NS_ENUM(NSUInteger, CustomizeUICategoryAction){
    CustomizeUICategoryActionSwitch = 0,
    CustomizeUICategoryActionOpen,
    CustomizeUICategoryActionDismiss
};


@interface NotificationHandler : NSObject

+ (NSString *)userNotiDescriptionText:(UserNotificationType)notiType;

+ (NSString *)userNotiTitle:(UserNotificationType)notiType;

+ (NSString *)userNotiRawValue:(UserNotificationType)notiType;

+ (NSString *)categoryRawValue:(UserNotificationCategoryType)categoryType;

+ (NSString *)saySomethingRawValue:(SaySomethingCategoryAction)categoryType;

+ (UserNotificationCategoryType)notiCategoryTypeWithRawValue:(NSString *)rawValue;

+ (SaySomethingCategoryAction)categoryActionWithRawValue:(NSString *)rawValue;

@end
