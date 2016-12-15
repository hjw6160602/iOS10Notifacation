//
//  NotificationViewController.m
//  NotificationContent
//
//  Created by 贺嘉炜 on 2016/11/25.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "NotificationPresentItem.h"

@interface NotificationViewController () <UNNotificationContentExtension>

@property (nonatomic, strong) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) NSInteger index;
@end
@implementation NotificationViewController

- (NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc]init];
    }
    return _items;
}

//在系统需要显示自定义样式的通知详情视图时，这个方法将被调用，你需要在其中配置你的 UI
- (void)didReceiveNotification:(UNNotification *)notification {
    
    UNNotificationContent *content = notification.request.content;
    
    NSArray *items = [content.userInfo objectForKey:@"items"];
    NSInteger i = 0;
    for (NSDictionary *item in items) {
        NSString *title = [item objectForKey:@"title"];
        NSString *text = [item objectForKey:@"text"];
        if (!title.length || !text.length) {
            continue;
        }
        NSURL *url = content.attachments[i].URL;
        
        NotificationPresentItem *presentItem = [NotificationPresentItem itemWithURL:url Title:title Text:text];
        [self.items addObject:presentItem];
        i++;
    }
    
    [self updateUI:0];
}

- (void)updateUI:(NSInteger)index{
    NotificationPresentItem *item = self.items[index];
    if (item.url.startAccessingSecurityScopedResource){
        self.imageView.image = [UIImage imageWithContentsOfFile:item.url.path];
        [item.url stopAccessingSecurityScopedResource];
    }

    self.label.text = item.title;
    self.textView.text = item.text;
    
    self.index = index;
}

- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption))completion{
    if ([response.actionIdentifier isEqualToString:@"switch1"]) {
        NSInteger nextIndex;
        if (self.index == 0) {
            nextIndex = 1;
        } else{
            nextIndex = 0;
        }
        [self updateUI:nextIndex];
        completion(UNNotificationContentExtensionResponseOptionDoNotDismiss);
    } else if ([response.actionIdentifier isEqualToString:@"open2"]) {
        completion(UNNotificationContentExtensionResponseOptionDismissAndForwardAction);
    } else if ([response.actionIdentifier isEqualToString:@"dismiss3"])  {
        completion(UNNotificationContentExtensionResponseOptionDismiss);
    } else {
        completion(UNNotificationContentExtensionResponseOptionDismissAndForwardAction);
    }
}

@end
