//
//  AuthorizationViewController.m
//  IOS10NOTIFICATION
//
//  Created by 贺嘉炜 on 2016/11/22.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "AuthorizationViewController.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)requestBtnOnClick:(id)sender {
    
}


@end
