//
//  UIView+HView.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "UIView+HView.h"

#import <objc/message.h>

@implementation UIView (HView)

// 实现setter、getter方法
- (id)vParam {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setVParam:(id)vParam {
    objc_setAssociatedObject(self, @selector(vParam), vParam, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
