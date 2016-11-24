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
    
    //注册Action
    NSString *inputActionId = [NotificationHandler saySomethingRawValue:SaySomethingCategoryActionInput];
    UNTextInputNotificationAction *inputAction = [UNTextInputNotificationAction actionWithIdentifier:inputActionId title:@"输入" options: UNNotificationActionOptionForeground textInputButtonTitle:@"发送" textInputPlaceholder:@"你想说什么..."];
    
    NSString *goodbyeActionId = [NotificationHandler saySomethingRawValue:SaySomethingCategoryActionGoodbye];
    UNNotificationAction *goodbyeAction = [UNNotificationAction actionWithIdentifier:goodbyeActionId title:@"再见" options:UNNotificationActionOptionForeground];
    
    NSString *cancelActionId = [NotificationHandler saySomethingRawValue:SaySomethingCategoryActionNone];
    UNNotificationAction *cancelAction = [UNNotificationAction actionWithIdentifier:cancelActionId title:@"取消" options:UNNotificationActionOptionForeground];
    
    //注册Category
    NSString *Identifier = [NotificationHandler categoryRawValue:UserNotificationCategoryTypeSaySomething];
    UNNotificationCategory *saySomethingCategory = [UNNotificationCategory categoryWithIdentifier:Identifier actions:@[inputAction, goodbyeAction, cancelAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    //将类别集合注册 进入通知中心
    NSSet *categorySet = [NSSet setWithObjects:saySomethingCategory, nil];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categorySet];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
