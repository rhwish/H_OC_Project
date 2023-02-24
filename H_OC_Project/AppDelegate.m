//
//  AppDelegate.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/21.
//

#import "AppDelegate.h"

#import "HCrash.h"
#import "HNotification.h"

#import "UIConfig.h"
#import "RequestConfig.h"
#import "NetworkConfig.h"
#import "NavigationConfig.h"

#import "LoginController.h"
#import "HTabBarController.h"
#import "HNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // start crash guard
    [[HCrash shareCrashManager] startCrashGuard];
    
    // config request
    [RequestConfig config];
    
    // config ui
    [UIConfig config];
    
    // config navigation
    [NavigationConfig config];
    
    // config network
    [NetworkConfig config];
    
    // login logic
    HNavigationController *navController;
    UserManager *userManager = [UserManager shareInstance];
    if (LoginFirst) { // 需要先登录
        UserModel *user = userManager.user;
        if (user) { // 已登录
            navController = [HNavigationController rootVC:[[HTabBarController alloc] init]];
        } else { // 未登录
            navController = [HNavigationController rootVC:[[LoginController alloc] init]];
        }
    } else { // 无需登录
        navController = [HNavigationController rootVC:[[HTabBarController alloc] init]];
    }
    
    // window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor h_gradientVertFromColor:H_UIColorFromHex(0x7454ff, 1) toColor:H_UIColorFromHex(0x330099, 1) withHeight:SCREEN_HEIGHT];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - 程序生命周期
// 应用将要进入前台(启动时候)
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

// 应用进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [HNotification shareNotificationManager].isInBackground = NO;
}

// 应用将要进入后台
- (void)applicationWillEnterForeground:(UIApplication *)application {

}

// 应用进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [HNotification shareNotificationManager].isInBackground = YES;
//    [[HNotification shareNotificationManager] _pushLocalNotificationWithTitle:@"er" withBody:@""];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        HLog(@"进入后台三秒");
//        [[HNotification shareNotificationManager] _pushLocalNotificationWithTitle:@"e" withBody:@""];
//    });
}

// 应用被杀死
- (void)applicationWillTerminate:(UIApplication *)application {
    
}


#pragma mark - Notification
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[HNotification shareNotificationManager] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[HNotification shareNotificationManager] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}


@end
