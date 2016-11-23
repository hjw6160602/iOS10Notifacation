//
//  AuthorizationViewController.h
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UNNotificationSettings;

@interface AuthorizationViewController : UIViewController

@property (nonatomic, copy) NSString *deviceToken;

@property (nonatomic, strong) UNNotificationSettings *settings;

@end
