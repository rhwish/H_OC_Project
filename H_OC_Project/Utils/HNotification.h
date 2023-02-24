//
//  HNotification.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNotification : NSObject

@property (nonatomic , assign, readwrite) BOOL isInBackground;

// 初始化单例
+ (HNotification *)shareNotificationManager;

// 检查推送权限
- (void)checkNotificationAuthorization;


#pragma mark - Local Notification
- (void)pushLocalNotificationWithTitle:(NSString *)title withBody:(NSString *)body;


#pragma mark - AppDelegate Noti
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end

NS_ASSUME_NONNULL_END
