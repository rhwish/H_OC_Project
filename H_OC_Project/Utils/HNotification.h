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

@end

NS_ASSUME_NONNULL_END
