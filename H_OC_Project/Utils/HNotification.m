//
//  HNotification.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "HNotification.h"

#import <UserNotifications/UserNotifications.h>

@interface HNotification ()<UNUserNotificationCenterDelegate>

@end

@implementation HNotification

+ (HNotification *)shareNotificationManager{
    static HNotification *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HNotification alloc] init];
    });
    return manager;
}

- (void)checkNotificationAuthorization{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) {
            //远程推送
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            });
        }
    }];
}


#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    completionHandler(UNNotificationPresentationOptionAlert);
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
    //处理badge展示逻辑
    //点击之后根据业务逻辑处理
    //[UIApplication sharedApplication].applicationIconBadgeNumber = 100;

    //处理业务逻辑
    completionHandler();
}

@end
