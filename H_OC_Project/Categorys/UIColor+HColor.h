//
//  UIColor+HColor.h
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HColor)

/* 竖向渐变色 */
+ (UIColor *)h_gradientVertFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
