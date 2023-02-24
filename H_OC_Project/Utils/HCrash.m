//
//  HCrash.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "HCrash.h"

#import <JJException/JJException.h>

@interface HCrash ()<JJExceptionHandle>

@end

@implementation HCrash

+ (HCrash *)shareCrashManager {
    static HCrash *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HCrash alloc] init];
    });
    return manager;
}

- (void)startCrashGuard {
    #ifdef DEBUG
        
    #else
        // JJException
        [JJException configExceptionCategory:JJExceptionGuardAll];
        [JJException startGuardException];
        [JJException registerExceptionHandle:self];
    #endif
}


#pragma mark - JJExceptionHandle
/* 处理异常上报 */
- (void)handleCrashException:(NSString *)exceptionMessage exceptionCategory:(JJExceptionGuardCategory)exceptionCategory extraInfo:(NSDictionary *)info {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSException *exception = [NSException exceptionWithName:[self getExceptionType:exceptionCategory] reason:exceptionMessage userInfo:userInfo];
}

- (void)handleCrashException:(nonnull NSString *)exceptionMessage extraInfo:(nullable NSDictionary *)info {
    
}


// 获取已知的异常类型
- (NSString *)getExceptionType:(JJExceptionGuardCategory)category {
    NSString *exceptionTypeStr = @"";
    switch (category) {
        case JJExceptionGuardNone:
            exceptionTypeStr = @"JJ None";
            break;
        case JJExceptionGuardUnrecognizedSelector:
            exceptionTypeStr = @"JJExceptionGuardUnrecognizedSelector";
            break;
        case JJExceptionGuardDictionaryContainer:
            exceptionTypeStr = @"JJExceptionGuardDictionaryContainer";
            break;
        case JJExceptionGuardArrayContainer:
            exceptionTypeStr = @"JJExceptionGuardArrayContainer";
            break;
        case JJExceptionGuardZombie:
            exceptionTypeStr = @"JJExceptionGuardZombie";
            break;
        case JJExceptionGuardKVOCrash:
            exceptionTypeStr = @"JJExceptionGuardKVOCrash";
            break;
        case JJExceptionGuardNSTimer:
            exceptionTypeStr = @"JJExceptionGuardNSTimer";
            break;
        case JJExceptionGuardNSNotificationCenter:
            exceptionTypeStr = @"JJExceptionGuardNSNotificationCenter";
            break;
        case JJExceptionGuardNSStringContainer:
            exceptionTypeStr = @"JJExceptionGuardNSStringContainer";
            break;
        case JJExceptionGuardAllExceptZombie:
            exceptionTypeStr = @"JJExceptionGuardAllExceptZombie";
            break;
        case JJExceptionGuardAll:
            exceptionTypeStr = @"JJExceptionGuardAll";
            break;
        default:
            exceptionTypeStr = @"JJ 未知";
            break;
    }
    
    return exceptionTypeStr;
}

@end
