//
//  NSString+HString.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "NSString+HString.h"

@implementation NSString (HString)
#pragma mark - Empty
// 是否为空字符串
- (BOOL)isEmpty {
    return [self isNil] || [self isNULL] || [self isNSNullClass] || [self isNullString] || [self isEqualToString:@""];
}


#pragma mark - Trim
// 去除首尾空格
- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 去掉所有空格
- (NSString *)trimAll {
    return [[self trim] stringByReplacingOccurrencesOfString:@" " withString:@""];
}


#pragma mark - Replace
// 将多个空格替换为单空格
- (NSString *)replaceMultiSpaceToSingleSpace {
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:@" {1,}" options:NSRegularExpressionCaseInsensitive error:nil];
    return [regEx stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@" "];
}

// 将指定位置字符使用特定字符替换
- (NSString *)replaceStringStartLength:(NSInteger)startLength endLength:(NSInteger)endLength by:(NSString *)byStr {
    if ([self isEmpty]) return @"";
    if (self.length > (startLength+endLength) && startLength < endLength) {
        NSString *prefix = [self substringToIndex:startLength];
        NSString *suffix = [self substringFromIndex:self.length-endLength];
        return [NSString stringWithFormat:@"%@...%@", prefix, suffix];
    }
    return self;
}


#pragma mark - RegExp
// 判断字符串是否是ETH钱包地址
- (BOOL)regExp_isETHWalletAddress:(NSString *)evalStr {
    NSString *ethRexp=@"^0x[a-fA-F0-9]{40,}$";
    NSPredicate *ethRexpPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ethRexp];
    return [ethRexpPre evaluateWithObject:evalStr];
}

// 判断字符串是否为纯数字
- (BOOL)regExp_isPureNumber:(NSString *)evalStr {
    NSString *ethRexp=@"^[0-9]+$";
    NSPredicate *ethRexpPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ethRexp];
    return [ethRexpPre evaluateWithObject:evalStr];
}

// 判断字符串是否为数字+字母
- (BOOL)regExp_isNumberAndAlphabet:(NSString *)evalStr {
    NSString *ethRexp=@"^[A-Za-z0-9]+$";
    NSPredicate *ethRexpPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ethRexp];
    return [ethRexpPre evaluateWithObject:evalStr];
}


#pragma mark - Private
// 是否为nil
- (BOOL)isNil {
    return self == nil;
}

// 是否为NULL
- (BOOL)isNULL {
    return self == NULL;
}

// 是否为<null> (NSNull class)
- (BOOL)isNSNullClass {
    return [self isEqual:[NSNull null]];
}

// 是否为"<null>"
- (BOOL)isNullString {
    return [self isEqualToString:@"<null>"];
}

@end
