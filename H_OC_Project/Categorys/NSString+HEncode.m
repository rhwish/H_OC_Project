//
//  NSString+HEncode.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "NSString+HEncode.h"

#import "NSData+HEncode.h"

@implementation NSString (HEncode)

- (NSData *)h_utf8Data {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)h_base64DecodeData {
    return [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSString *)h_base64Encode {
    return [self.h_utf8Data base64EncodedStringWithOptions:0];
}

- (NSString *)h_base64Decode {
    return self.h_base64DecodeData.h_utf8String;
}

- (NSString *)h_urlEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)h_urlDecode {
    return [self stringByRemovingPercentEncoding];
}
@end
