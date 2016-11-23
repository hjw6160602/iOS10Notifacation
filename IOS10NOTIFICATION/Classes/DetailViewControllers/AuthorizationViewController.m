//
//  AuthorizationViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "AuthorizationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "UIAlertController+Extension.h"

@interface AuthorizationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *deviceTokenLabel;

@property (weak, nonatomic) IBOutlet UIStackView *settingsView;

@property (weak, nonatomic) IBOutlet UILabel *notificationCenterSettingLabel;

@property (weak, nonatomic) IBOutlet UILabel *soundSettingLabel;

@property (weak, nonatomic) IBOutlet UILabel *badgeSettingLabel;

@property (weak, nonatomic) IBOutlet UILabel *lockScreenSettingLabel;

@property (weak, nonatomic) IBOutlet UILabel *alertSettingLabel;

@property (weak, nonatomic) IBOutlet UILabel *carPlaySettingLabel;

@property (weak, nonatomic) IBOutlet UILabel *alertStyleSettingLabel;


@end

@implementation AuthorizationViewController

/** deviceToken的setter */
- (void)setDeviceToken:(NSString *)deviceToken{
    _deviceToken = deviceToken;
    if (self.isViewLoaded) {
        [self updateUI];
    }
}

/** UNNotificationSettings 的 setter */
- (void)setSettings:(UNNotificationSettings *)settings{
    _settings = settings;
    if (self.isViewLoaded) {
        [self updateUI];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSettings) name:UIApplicationWillEnterForegroundNotification object:nil];
}


- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidDisappear:animated];
}

- (void)updateSettings{
    __weak typeof(self) weakSelf = self;
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        weakSelf.settings = settings;
    }];
}

- (void)updateUI {
    self.deviceTokenLabel.text = self.deviceToken;
    
    UNNotificationSettings *settings = self.settings;
    if (!settings) {
        self.settingsView.hidden = YES;
        return;
    }
    self.settingsView.hidden = NO;
    
    self.notificationCenterSettingLabel.text = [self descriptionWithNotificationSetting:settings.notificationCenterSetting];
    self.soundSettingLabel.text = [self descriptionWithNotificationSetting:settings.soundSetting];
    self.badgeSettingLabel.text = [self descriptionWithNotificationSetting:settings.badgeSetting];
    self.lockScreenSettingLabel.text = [self descriptionWithNotificationSetting:settings.lockScreenSetting];
    self.alertSettingLabel.text = [self descriptionWithNotificationSetting:settings.alertSetting];
    self.carPlaySettingLabel.text = [self descriptionWithNotificationSetting:settings.carPlaySetting];
    
    self.alertStyleSettingLabel.text = [self descriptionWithAlertStyle:settings.alertStyle];
}

- (IBAction)requestBtnOnClick:(id)sender {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted){
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        } else {
            if (error) {
                [UIAlertController showConfirmAlertWithMessage:error.localizedDescription Controller:self];
            }
        }
    }];
}

- (NSString *)descriptionWithNotificationSetting:(UNNotificationSetting)setting{
    switch (setting) {
        case UNNotificationSettingEnabled:
            return @"开";
            break;
        case UNNotificationSettingDisabled:
            return @"关";
            break;
        default:
            return @"不支持";
            break;
    }
}

- (NSString *)descriptionWithAlertStyle: (UNAlertStyle)style {
    switch (style) {
        case UNAlertStyleAlert:
            return @"Alert样式";
            break;
        case UNAlertStyleBanner:
            return @"Banner样式";
            break;
        default:
            return @"无";
            break;
    }
}




@end
