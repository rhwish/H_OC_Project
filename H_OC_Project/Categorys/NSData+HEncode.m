//
//  NSData+HEncode.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/21.
//

#import "NSData+HEncode.h"

@implementation NSData (HEncode)

- (NSString *)h_utf8String {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}
- (NSData *)h_base64Encode {
    return [self base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSData *)h_base64Decode {
    return [[NSData alloc] initWithBase64EncodedData:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

@end
