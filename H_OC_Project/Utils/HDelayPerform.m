//
//  HDelayPerform.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "HDelayPerform.h"

//延迟执行的回调 静态全局变量
static dispatch_block_t h_delayBlock;

@implementation HDelayPerform

/*
 @description:开始延迟执行  每次调用就重新开始计时   用完记得 执行h_cancelDelayPerform
 @params:perform  执行内容
 @return:delay 延迟时间
 */
+ (void)h_startDelayPerform:(void(^)(void))perform afterDelay:(NSTimeInterval)delay {
    if (h_delayBlock != nil) {
        dispatch_block_cancel(h_delayBlock);
        h_delayBlock = nil;
    }
    if (h_delayBlock == nil) {
        h_delayBlock = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
            perform();
        });
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(),h_delayBlock);
}

/* 取消延迟执行 */
+ (void)h_cancelDelayPerform {
    if (h_delayBlock != nil) {
        dispatch_block_cancel(h_delayBlock);
        h_delayBlock = nil;
    }
}
@end
