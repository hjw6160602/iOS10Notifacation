//
//  UIAlertController+Extension.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "UIAlertController+Extension.h"

@implementation UIAlertController (Extension)

+ (void)showConfirmAlertWithMessage:(NSString *)message Controller:(UIViewController *)viewController{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [viewController presentViewController:alert animated:YES completion:nil];
}


+ (void)showConfirmAlertFromTopViewControllerWithMessage:(NSString *)message{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (vc) {
        [self showConfirmAlertWithMessage:message Controller:vc];
    }
}


@end
