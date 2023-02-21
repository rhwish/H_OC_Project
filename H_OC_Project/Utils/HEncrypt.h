//
//  HEncrypt.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HEncryptMode) {
    HEncryptAES128      = 0,
    HEncryptAES192,
    HEncryptAES256,
    HEncryptDES,
    HEncrypt3DES,
};

/* 加密Util */
@interface HEncrypt : NSObject

#pragma mark - AES
/* AES128 ECB 加密 */
+ (nullable NSString *)stringByAES128ECBEncrypt:(NSString *)string key:(NSString *)key;

/* AES128 ECB 解密 */
+ (nullable NSString *)stringByAES128ECBDecrypt:(NSString *)string key:(NSString *)key;

/*
 @description:AES和DES通用的加密方法
 @params:mode 算法
 @params:data 需要加密的二进制数据
 @params:key 密钥
 @params:options 补码方式(PKCS7Padding/None)和加密模式(CBC/ECB，默认CBC)
 @params:iv 向量，ECB不需要
 @return:加密之后二进制的数据
 */
+ (nullable NSData *)h_dataByEncrypt:(NSData *)data key:(NSString *)key mode:(HEncryptMode)mode options:(CCOptions)options iv:(nullable NSString *)iv;


/*
 @description:AES和DES通用的解密方法
 @params:mode 算法
 @params:data 需要解密的二进制数据
 @params:key 密钥
 @params:options 补码方式(PKCS7Padding/None)和加密模式(CBC/ECB，默认CBC)
 @params:iv 向量，ECB不需要
 @return:解密之后二进制的数据
 */
+ (nullable NSData *)h_dataByDecrypt:(NSData *)data key:(NSString *)key mode:(HEncryptMode)mode options:(CCOptions)options iv:(nullable NSString *)iv;

@end

NS_ASSUME_NONNULL_END
