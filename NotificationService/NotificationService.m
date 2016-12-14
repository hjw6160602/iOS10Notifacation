//
//  NotificationService.m
//  NotificationService
//
//  Created by 贺嘉炜 on 2016/11/25.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

#import "NotificationService.h"
#import "NSString+MD5.h"


@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService


- (void)downloadAndSave:(NSURL *)url handler:(void(^)(NSURL *localURL))handler{
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSURL *loccalURL;
        if (data) {
            NSString *ext = url.absoluteString.pathExtension;
            NSURL *cacheURL = [NSURL fileURLWithPath:NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject];
            
            NSURL *urlPath = [[cacheURL URLByAppendingPathComponent:url.absoluteString.md5] URLByAppendingPathExtension:ext];
            
            if ([data writeToURL:urlPath atomically:YES]) {
                loccalURL = urlPath;
            };
        }
        handler(loccalURL);
    }];
    [task resume];
}

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    if (self.bestAttemptContent) {
        if ([request.identifier isEqualToString:@"mutableContent"]) {
            ;
            self.bestAttemptContent.body = [NSString stringWithFormat:@"%@, 科比·布莱恩特",self.bestAttemptContent.body];
        } else if ([request.identifier isEqualToString:@"media"]){
            NSString *imageURLString = [self.bestAttemptContent.userInfo objectForKey:@"image"];
            NSURL *URL = [NSURL URLWithString:imageURLString];
            if (URL) {
                __weak typeof(self) weakSelf = self;
                [self downloadAndSave:URL handler:^(NSURL *localURL) {
                    if (localURL) {
                       UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"image_downloaded" URL:localURL options:nil error:nil];
                        weakSelf.bestAttemptContent.attachments = @[attachment];
                    }
                    weakSelf.contentHandler(self.bestAttemptContent);
                }];
            }
        }
    }
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
}



- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
