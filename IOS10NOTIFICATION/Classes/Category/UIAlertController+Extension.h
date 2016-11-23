//
//  UIAlertController+Extension.h
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extension)

+ (void)showConfirmAlertWithMessage:(NSString *)message Controller:(UIViewController *)viewController;

+ (void)showConfirmAlertFromTopViewControllerWithMessage:(NSString *)message;

@end
