//
//  HDelayPerform.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/* 延迟执行 */
@interface HDelayPerform : NSObject

/*
 @description:开始延迟执行  每次调用就重新开始计时   用完记得 执行h_cancelDelayPerform
 @params:perform  执行内容
 @return:delay 延迟时间
 */
+ (void)h_startDelayPerform:(void(^)(void))perform afterDelay:(NSTimeInterval)delay;

/* 取消延迟执行 */
+ (void)h_cancelDelayPerform;

@end

NS_ASSUME_NONNULL_END
