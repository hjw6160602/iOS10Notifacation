//
//  NotificationHandler.h
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

typedef NS_ENUM(NSInteger, UserNotificationType){
    UserNotificationTypeTimeInterval = 0,
    UserNotificationTypeTimeIntervalForeground,
    UserNotificationTypePendingRemoval,
    UserNotificationTypePendingUpdate,
    UserNotificationTypeDeliveredRemoval,
    UserNotificationTypeDeliveredUpdate,
    UserNotificationTypeActionable,
    UserNotificationTypeMutableContent,
    UserNotificationTypeMedia,
    UserNotificationTypeCustomUI
};

//extension UserNotificationType {
//    var descriptionText: String {
//        switch self {
//        case .timeInterval: return "You need to switch to background to see the notification."
//        case .timeIntervalForeground: return "The notification will show in-app. See NotificationHandler for more."
//        default: return rawValue
//        }
//    }
//    
//    var title: String {
//        switch self {
//        case .timeInterval: return "Time"
//        case .timeIntervalForeground: return "Foreground"
//        default: return rawValue
//        }
//    }
//}


@interface NotificationHandler : NSObject

@end
