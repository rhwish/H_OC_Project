//
//  NSString+HString.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HString)

#pragma mark - Empty
// 是否为空字符串
- (BOOL)isEmpty;


#pragma mark - Trim
// 去除首尾空格
- (NSString *)trim;

// 去掉所有空格
- (NSString *)trimAll;


#pragma mark - Replace
// 将多个空格替换为单空格
- (NSString *)replaceMultiSpaceToSingleSpace;

// 将指定位置字符使用特定字符替换
- (NSString *)replaceStringStartLength:(NSInteger)startLength endLength:(NSInteger)endLength by:(NSString *)byStr;


#pragma mark - RegExp
// 判断字符串是否是ETH钱包地址
- (BOOL)regExp_isETHWalletAddress:(NSString *)evalStr;

// 判断字符串是否为纯数字
- (BOOL)regExp_isPureNumber:(NSString *)evalStr;

// 判断字符串是否为数字+字母
- (BOOL)regExp_isNumberAndAlphabet:(NSString *)evalStr;

@end

NS_ASSUME_NONNULL_END
