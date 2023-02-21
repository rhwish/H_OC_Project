//
//  HApiInterface.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/17.
//

#import "HApiInterface.h"

@implementation HApiInterface

#if DevelopServer
NSString *const kApiPrefix = @"";
#elif ProductServer
NSString *const kApiPrefix = @"";
#endif

#pragma mark - Login
NSString *const kLogin = @"xxx/";

@end
