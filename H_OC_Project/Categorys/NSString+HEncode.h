//
//  NSString+HEncode.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HEncode)

/* 转Data */
@property(nullable, readonly, copy) NSData *h_utf8Data;

/* base64解密 */
- (NSData *)h_base64DecodeData;

/* base64加密字符串 */
@property(nullable, readonly, copy) NSString *h_base64Encode;
/* base64解密字符串 */
@property(nullable, readonly, copy) NSString *h_base64Decode;

/* url编码字符串 */
@property(nullable, readonly, copy) NSString *h_urlEncode;
/* url解码字符串 */
@property(nullable, readonly, copy) NSString *h_urlDecode;

@end

NS_ASSUME_NONNULL_END
