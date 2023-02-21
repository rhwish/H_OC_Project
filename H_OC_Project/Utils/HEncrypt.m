//
//  HEncrypt.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "HEncrypt.h"

#import "NSData+HEncode.h"
#import "NSString+HEncode.h"

@implementation HEncrypt
#pragma mark - AES
+ (nullable NSString *)stringByAES128ECBEncrypt:(NSString *)string key:(NSString *)key {
    NSData *result = [self h_dataByEncrypt:string.h_utf8Data key:key mode:HEncryptAES128 options:kCCOptionPKCS7Padding|kCCOptionECBMode iv:nil];
    NSString *resultStr = result.h_base64Encode.h_utf8String;
    return [resultStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
}

+ (nullable NSString *)stringByAES128ECBDecrypt:(NSString *)string key:(NSString *)key {
    NSData *result = [self h_dataByDecrypt:string.h_base64DecodeData key:key mode:HEncryptAES128 options:kCCOptionPKCS7Padding | kCCOptionECBMode iv:nil];
    return result.h_utf8String;
}


+ (nullable NSData *)k_dataByEncrypt:(NSData *)data key:(NSString *)key mode:(HEncryptMode)mode options:(CCOptions)options iv:(nullable NSString *)iv {
    NSData *encodeData = [self encryptOperation:kCCEncrypt mode:mode value:data key:key options:options iv:iv];
    return encodeData;
}

+ (nullable NSData *)k_dataByDecrypt:(NSData *)data key:(NSString *)key mode:(HEncryptMode)mode options:(CCOptions)options iv:(nullable NSString *)iv {
    return [self encryptOperation:kCCDecrypt mode:mode value:data key:key options:options iv:iv];
}

+ (NSData *)encryptOperation:(CCOperation)operation mode:(HEncryptMode)mode value:(NSData *)data key:(NSString *)key options:(CCOptions)options iv:(NSString *)iv {
    NSUInteger keySize;
    CCAlgorithm algorithm;
    NSUInteger blockSize;
    switch (mode) {
        case HEncryptAES128: {
            keySize = kCCKeySizeAES128;
            algorithm = kCCAlgorithmAES128;
            blockSize = kCCBlockSizeAES128;
            break;
        }
        case HEncryptAES192: {
            keySize = kCCKeySizeAES192;
            algorithm = kCCAlgorithmAES128;
            blockSize = kCCBlockSizeAES128;
            break;
        }
        case HEncryptAES256: {
            keySize = kCCKeySizeAES256;
            algorithm = kCCAlgorithmAES128;
            blockSize = kCCBlockSizeAES128;
            break;
        }
        case HEncryptDES: {
            keySize = kCCKeySizeDES;
            algorithm = kCCAlgorithmDES;
            blockSize = kCCBlockSizeDES;
            break;
        }
        case HEncrypt3DES: {
            keySize = kCCKeySize3DES;
            algorithm = kCCAlgorithm3DES;
            blockSize = kCCBlockSize3DES;
            break;
        }
        default: {
            return nil;
        }
    }
    NSInteger keyLength = MAX(keySize, key.length);
    char keyPtr[keyLength + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = data.length;
    size_t bufferSize = dataLength + blockSize;
    void * buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    char ivPtr[blockSize+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    if (iv != nil) {
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    }
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          algorithm,
                                          options,
                                          keyPtr,
                                          keySize,
                                          ivPtr,
                                          data.bytes,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData * result = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        if (result != nil) {
            return result;
        }
    } else {
        if (buffer) {
            free(buffer);
            buffer = NULL;
        }
    }
    return nil;
}

@end
