//
//  HNetworkMethod.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/17.
//

#import <Foundation/Foundation.h>

#import "HNetwork.h"

#import "ResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HRequestSuccess)(ResponseModel *responseModel);

@interface HNetworkMethod : NSObject

// GET请求
+ (void)GET:(NSString *)URL parameters:(id)parameters success:(nullable HRequestSuccess)success failure:(nullable HNetworkFail)failure;

// GET JSON
+ (void)GETJSON:(NSString *)URL parameters:(id)parameters success:(HRequestSuccess)success failure:(HNetworkFail)failure;

// POST FormData
+ (void)POST:(NSString *)URL parameters:(id)parameters success:(nullable HRequestSuccess)success failure:(nullable HNetworkFail)failure;

// POST JSON
+ (void)POSTJSON:(NSString *)URL parameters:(id)parameters success:(nullable HRequestSuccess)success failure:(nullable HNetworkFail)failure;

// 上传图片
+ (void)uploadImages:(NSArray<UIImage *> *)images imageScale:(CGFloat)imageScale imageType:(NSString *)imageType progress:(HNetworkProgress)progress success:(HRequestSuccess)success failure:(HNetworkFail)failure;

// 上传文件
+ (void)uploadFile:(NSString *)filePath progress:(nullable HNetworkProgress)progressBlock success:(nullable HRequestSuccess)success failure:(nullable HNetworkFail)failure;

@end

NS_ASSUME_NONNULL_END
