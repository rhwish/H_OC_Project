//
//  HUserDefaults.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "HUserDefaults.h"

@implementation HUserDefaults

// 存储:BOOL
+ (void)saveBool:(BOOL)value forKey:(NSString *)key {
    NSString *relevantKey = [self getRelevantKey:key];
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:relevantKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 存储:Integer
+ (void)saveInteger:(NSInteger)value forKey:(NSString *)key {
    NSString *relevantKey = [self getRelevantKey:key];
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:relevantKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 存储:Object
+ (void)saveObject:(id)value forKey:(NSString *)key {
    NSString *relevantKey = [self getRelevantKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:relevantKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 读取:BOOL
+ (BOOL)queryBoolForKey:(NSString *)key {
    NSString *relevantKey = [self getRelevantKey:key];
    return [[NSUserDefaults standardUserDefaults] boolForKey:relevantKey];
}

// 读取:Integer
+ (NSInteger)queryIntegerForKey:(NSString *)key {
    NSString *relevantKey = [self getRelevantKey:key];
    return [[NSUserDefaults standardUserDefaults] integerForKey:relevantKey];
}

// 读取:Object
+ (id)queryObjectForKey:(NSString *)key {
    NSString *relevantKey = [self getRelevantKey:key];
    return [[NSUserDefaults standardUserDefaults] objectForKey:relevantKey];
}

// 删除
+ (void)deleteObjectForKey:(NSString *)key {
    NSString *relevantKey = [self getRelevantKey:key];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:relevantKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 根据key判断当前存储是否需要跟用户id关联,并返回关联后的key
+ (NSString *)getRelevantKey:(NSString *)originalKey {
    // 需要关联用户id的key列表
    NSArray *whiteKeys = @[
        
    ];
    
    if ([whiteKeys containsObject:originalKey]) {
        UserModel *user = [UserManager shareInstance].user;
        if (user) {
            return [NSString stringWithFormat:@"%ld_%@", [UserManager shareInstance].user.userId, originalKey];
        } else {
            return originalKey;
        }
    } else {
        return originalKey;
    }
    
}

@end
