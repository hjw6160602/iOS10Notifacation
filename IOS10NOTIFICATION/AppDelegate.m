//
//  AppDelegate.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "AppDelegate.h"
#import "NotificationHandler.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()
@property (nonatomic, nonnull, strong)id <UNUserNotificationCenterDelegate> notificationHandler;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerNotificationCategory];
    
    self.notificationHandler = (id)[[NotificationHandler alloc]init];
    [UNUserNotificationCenter currentNotificationCenter].delegate = self.notificationHandler;
    return YES;
}

- (void)registerNotificationCategory{
    
    //注册Action Category
    NSString *inputActionId = [NotificationHandler saySomethingRawValue:SaySomethingCategoryActionInput];
    UNTextInputNotificationAction *inputAction = [UNTextInputNotificationAction actionWithIdentifier:inputActionId title:@"输入" options: UNNotificationActionOptionForeground textInputButtonTitle:@"发送" textInputPlaceholder:@"你想说什么..."];
    
    NSString *goodbyeActionId = [NotificationHandler saySomethingRawValue:SaySomethingCategoryActionGoodbye];
    UNNotificationAction *goodbyeAction = [UNNotificationAction actionWithIdentifier:goodbyeActionId title:@"再见" options:UNNotificationActionOptionForeground];
    
    NSString *cancelActionId = [NotificationHandler saySomethingRawValue:SaySomethingCategoryActionNone];
    UNNotificationAction *cancelAction = [UNNotificationAction actionWithIdentifier:cancelActionId title:@"取消" options:UNNotificationActionOptionForeground];
    
    NSString *saySomethingCategoryIdentifier = [NotificationHandler categoryRawValue:UserNotificationCategoryTypeSaySomething];
    UNNotificationCategory *saySomethingCategory = [UNNotificationCategory categoryWithIdentifier:saySomethingCategoryIdentifier actions:@[inputAction, goodbyeAction, cancelAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    
    //自定义UI的Category
    NSString *nextActionIdentifier = [NotificationHandler customUIRawValue:CustomizeUICategoryActionSwitch];
    UNNotificationAction *nextAction = [UNNotificationAction actionWithIdentifier:nextActionIdentifier title:@"切换" options:0];
    
    NSString *openActionIdentifier = [NotificationHandler customUIRawValue:CustomizeUICategoryActionOpen];
    UNNotificationAction *openAction = [UNNotificationAction actionWithIdentifier:openActionIdentifier title:@"打开" options:UNNotificationActionOptionForeground];
    
    NSString *dismissActionIdentifier = [NotificationHandler customUIRawValue:CustomizeUICategoryActionDismiss];
    UNNotificationAction*dismissAction = [UNNotificationAction actionWithIdentifier:dismissActionIdentifier title:@"忽略" options:UNNotificationActionOptionDestructive];
    
    NSString *customUICategoryIdentifier = [NotificationHandler categoryRawValue:UserNotificationCategoryTypeCustomUI];
    UNNotificationCategory *customUICategory = [UNNotificationCategory categoryWithIdentifier:customUICategoryIdentifier actions:@[nextAction, openAction, dismissAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];

    //将类别集合注册 进入通知中心
    NSSet *categorySet = [NSSet setWithObjects:saySomethingCategory,customUICategory, nil];
//    NSSet *categorySet = [NSSet setWithObjects:saySomethingCategory, nil];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categorySet];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"%@",deviceToken);
}

@end
