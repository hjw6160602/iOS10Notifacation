//
//  ViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "ViewController.h"
#import "AuthorizationViewController.h"
#import <UserNotifications/UserNotifications.h>

typedef NS_ENUM(NSInteger, SegueIdentity) {
    SegueIdentityShowAuthorization = 0,
    SegueIdentityShowTimeInterval = 1,
    SegueIdentityShowTimeIntervalForeground = 2,
    SegueIdentityShowManagement = 3,
    SegueIdentityShowActionable = 4,
    SegueIdentityShowMedia = 5
};


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *authorizationLabel;

@property (nonatomic, strong) UNNotificationSettings *settings;

@property (nonatomic, assign) SegueIdentity SegueEnum;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    __weak typeof(self)weakSelf = self;
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            weakSelf.authorizationLabel.text = @"已授权";
        }
        weakSelf.settings = settings;
    }];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSString *segueID = segue.identifier;
    
    self.SegueEnum = [self segueIdentityWithName:segueID];
    
    switch (self.SegueEnum) {
        case SegueIdentityShowAuthorization:
            if ([segue.destinationViewController isKindOfClass:[AuthorizationViewController class]]) {
                AuthorizationViewController *vc = segue.destinationViewController;
                vc.settings = self.settings;
//        vc.deviceToken = UserDefaults.standard.object(forKey: "push-token") as? String
            } else{
                NSLog(@"The destination should be AuthorizationViewController");
            }
            break;
        case SegueIdentityShowTimeInterval:
//        guard let vc = segue.destination as? TimeIntervalViewController else {
//            fatalError("The destination should be TimeIntervalViewController")
//        }
//        vc.notificationType = .timeInterval
            break;
        case SegueIdentityShowTimeIntervalForeground:
//        guard let vc = segue.destination as? TimeIntervalViewController else {
//            fatalError("The destination should be TimeIntervalViewController")
//        }
//        vc.notificationType = .timeIntervalForeground
            break;
        case SegueIdentityShowManagement: break;
        case SegueIdentityShowActionable:break;
        case SegueIdentityShowMedia: break;
        default: break;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{

    if ([identifier isEqualToString: @"showAuthorization0"]) {
        return YES;
    }
    if (self.settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
        return NO;
    }
    return YES;
}

- (SegueIdentity)segueIdentityWithName:(NSString *)name{
    NSUInteger len = name.length;
    NSString *nameID = [name substringFromIndex:len-1];
    SegueIdentity s = nameID.integerValue;
    return s;
}


@end
