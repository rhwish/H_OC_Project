//
//  UserManager.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "UserManager.h"

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
    }
    return self;
}


// 从本地加载用户信息
- (void)loadUser {
    
}

@end
