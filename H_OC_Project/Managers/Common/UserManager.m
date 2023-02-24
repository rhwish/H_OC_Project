//
//  UserManager.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "UserManager.h"

#import "LoginController.h"
#import "HTabBarController.h"
#import "HNavigationController.h"

@implementation UserManager

+ (UserManager *)shareInstance{
    static UserManager *userManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[UserManager alloc] init];
    });
    return userManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self loadUser];
        [self loadLanguage];
    }
    return self;
}


#pragma mark - Load Info
// 从本地加载用户信息
- (void)loadUser {
    NSDictionary *userInfoDic = [HUserDefaults queryObjectForKey:kStorageUserInfoKey];
    if (userInfoDic) {
        UserModel *user = [[UserModel alloc] init];
        user.userId = 1;
        self.user = user;
    }
}

// 多语言
- (void)loadLanguage {
    // 获取本机语言
    // 语言类型：
    // 中文简体：zh-Hans-CN
    // 中文繁体：zh-Hant-TW/HK/MO
    // 英文：en-US
    // 阿拉伯：ar-AE
    // 印地语：hi-
    // 葡萄牙语：pt-PT
    // 印尼：id-ID
    
    NSString *locale = [HUserDefaults queryObjectForKey:kStorageAppLanguageKey];
    NSString *fullLocale = [HUserDefaults queryObjectForKey:kStorageFullLocaleCodeKey];
    
    // 获取系统语言国家设置
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *language = [languages objectAtIndex:0];
    
    if (!fullLocale) {
        fullLocale = language;
        [HUserDefaults saveObject:fullLocale forKey:kStorageFullLocaleCodeKey];
    }

    if (!locale) {
        if ([language hasPrefix:@"zh-Hans"]) {
            locale = @"zh-Hans";
        } else {
            locale = @"en";
        }
        [HUserDefaults saveObject:locale forKey:kStorageAppLanguageKey];
    }
    
    self.locale = locale;
    self.fullLocale = fullLocale;
    
    HLog(@"language:%@ locale:%@ fullLocale:%@", language, locale, fullLocale);
}


#pragma mark - Update
// 更新用户信息
- (void)updateUser:(UserModel *)user {
    self.user = user;
    
    NSDictionary *userInfoDic = @{
        @"userId": @(user.userId)
    };
    [HUserDefaults saveObject:userInfoDic forKey:kStorageUserInfoKey];
}

// 更新用户语言环境
- (void)updateUserLocale:(NSString *)locale {
    self.locale = locale;
    [HUserDefaults saveObject:locale forKey:kStorageAppLanguageKey];
    
    HNavigationController *navController = (HNavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    HTabBarController *tabBarController = navController.viewControllers.firstObject;
    
    UIViewController *currentVC = tabBarController.viewControllers[tabBarController.selectedIndex];
    UIViewController *firstPresentVC = currentVC.presentedViewController;
    if (firstPresentVC) {
        [currentVC dismissViewControllerAnimated:YES completion:nil];
    }
    
    // 重新指定根控制器
    [navController setViewControllers:@[[[HTabBarController alloc] init]] animated:YES];
}


- (void)logout {
    self.user = nil;
    [HUserDefaults deleteObjectForKey:kStorageUserInfoKey];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        HNavigationController *navController = (HNavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        HTabBarController *tabBarController = navController.viewControllers.firstObject;
        
        UIViewController *currentVC = tabBarController.viewControllers[tabBarController.selectedIndex];
        UIViewController *firstPresentVC = currentVC.presentedViewController;
        if (firstPresentVC) {
            [currentVC dismissViewControllerAnimated:YES completion:nil];
        }
        
        if (LoginFirst) {
            navController.viewControllers = @[[[LoginController alloc] init]];
        }
        
    });
}

@end
