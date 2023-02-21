//
//  NSData+HEncode.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (HEncode)

/* 转String */
@property(nullable, readonly, copy) NSString *h_utf8String;

/* base64加密 */
@property(nullable, readonly, copy) NSData *h_base64Encode;

/* base64解密 */
@property(nullable, readonly, copy) NSData *h_base64Decode;

@end

NS_ASSUME_NONNULL_END
