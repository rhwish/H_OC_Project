//
//  NetworkConfig.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import "NetworkConfig.h"

#import "HNetwork.h"
#import "HApiInterface.h"

@implementation NetworkConfig

+ (void)config {
    //设置基础的Url
    [HNetwork setBaseURL:kApiPrefix];

    //设置超时时间
    [HNetwork setRequestTimeoutInterval:5.0f];
}

@end
