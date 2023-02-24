//
//  RequestConfig.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/24.
//

#import "RequestConfig.h"

// 禁止代理抓包
#import "ZXRequestBlock.h"

// 调试工具
#ifdef DEBUG
  #import <MTHawkeye/MTRunHawkeyeInOneLine.h>
#endif

@implementation RequestConfig

+ (void)config {
    #ifdef DEBUG
        // Hawkeye
        [MTRunHawkeyeInOneLine start];
    #else
    // 禁用代理抓包+DNS劫持
        [ZXRequestBlock disableHttpProxy];
        [ZXRequestBlock enableHttpDns];
    #endif
}

@end
