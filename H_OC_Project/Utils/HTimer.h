//
//  HTimer.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/* 计时器  比NSTimer和CADisplayLink计时准确 */
@interface HTimer : NSObject

/*
 @description:执行任务
 @params:task  任务Block
 @params:start 开始时间
 @params:interval 时间间隔
 @params:repeats 是否重复
 @params:async 是否异步
 @return:返回任务名称
 */
+ (NSString *)execTask:(void(^)(void))task
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;


/*
 @description:执行任务
 @params:target 选择器执行者
 @params:selector 选择器
 @params:start 开始时间
 @params:interval 时间间隔
 @params:repeats 是否重复
 @params:async 是否异步
 @return:返回任务名称
 */
+ (NSString *)execTask:(id)target
              selector:(SEL)selector
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;


/*
 @description:取消任务
 @params:taskName 任务名称
 @return:nil
 */
+ (void)cancelTask:(NSString *)taskName;

@end

NS_ASSUME_NONNULL_END
