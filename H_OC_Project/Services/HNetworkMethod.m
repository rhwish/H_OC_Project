//
//  HNetworkMethod.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/17.
//

#import "HNetworkMethod.h"

#import "HApiInterface.h"

@implementation HNetworkMethod
// GET
+ (void)GET:(NSString *)URL parameters:(id)parameters success:(HRequestSuccess)success failure:(HNetworkFail)failure {
    //设置对应接口的Url
    [self requestWithMethod:HRequestMethodGET withJson:NO url:URL parameters:parameters success:success failure:failure];
}

// GET JSON
+ (void)GETJSON:(NSString *)URL parameters:(id)parameters success:(HRequestSuccess)success failure:(HNetworkFail)failure {
    //设置对应接口的Url
    [self requestWithMethod:HRequestMethodGET withJson:YES url:URL parameters:parameters success:success failure:failure];
}

// POST FormData
+ (void)POST:(NSString *)URL parameters:(id)parameters success:(HRequestSuccess)success failure:(HNetworkFail)failure {
    //设置对应接口的Url
    [self requestWithMethod:HRequestMethodPOST withJson:NO url:URL parameters:parameters success:success failure:failure];
}

// POST JSON
+ (void)POSTJSON:(NSString *)URL parameters:(id)parameters success:(HRequestSuccess)success failure:(HNetworkFail)failure {
    //设置对应接口的Url
    [self requestWithMethod:HRequestMethodPOST withJson:YES url:URL parameters:parameters success:success failure:failure];
}

#pragma mark - 请求的公共方法

+ (void)requestWithMethod:(HRequestMethod)method withJson:(BOOL)isJson url:(NSString *)URL parameters:(NSDictionary *)parameters success:(HRequestSuccess)success failure:(HNetworkFail)failure {
    
    if (isJson) {
        [HNetwork setRequestSerializer:HRequestSerializerJSON];
    } else {
        [HNetwork setRequestSerializer:HRequestSerializerHTTP];
    }
    
    NSString *buildVersion = @"1";
//    NSString *locale = [KUserDefaults queryObjectForKey:kStorageAppLanguageKey];
//    NSString *localeN = [KConvert getLanguageNumberByLocale:locale];
    
    // header
    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:@{
        @"Accept": @"application/json",
        @"applicationId": @"2", // iOS默认是2
        @"buildVersion": buildVersion,
        @"applicationClientType": @"2", // iOS默认是2
        @"lang": @"en"
    }];
    
    // token
    UserManager *userManager = [UserManager shareInstance];
    UserModel *user = userManager.user;
    if (user && user.token) {
        [header setValue:user.token forKey:@"token"];
    }
    
    // 设置请求头
    [HNetwork setHeader: [header mutableCopy]];
    
    //可以设置全局等待的指示器
//    BOOL disableLoading = [parameters[@"disableLoading"] boolValue];
//    if (!disableLoading) {
//        [KDialog showLoadingWithEnableInteraction:YES];
//    }
    
//    Loading
    NSDictionary *params = parameters;
//    if ([parameters jk_hasKey:@"disableLoading"]) {
//        NSMutableDictionary *p = [NSMutableDictionary dictionaryWithDictionary:parameters];
//        [p removeObjectForKey:@"disableLoading"];
//        params = p.mutableCopy;
//    }
    
    // 请求方式
    NSString *requestMethod = method == HRequestMethodPOST ? @"POST" : method == HRequestMethodGET ? @"GET" : @"其他";
    HLog(@"\n请求接口：%@%@\n 请求头：%@\n 请求方式：%@\n 是否为POSTJSON：%@\n 请求参数：%@\n",kApiPrefix, URL, header, requestMethod, isJson ? @"是" : @"否", params);
    
    // 发起请求
    H_StartTime;
    [HNetwork HTTPWithMethod:method url:URL parameters:params headers:nil success:^(id  _Nonnull responseObject) {
        HLog(@"\n请求结果 -> URL：%@%@\n 用户uid：%ld\n 请求耗时：%.f\n 参数：%@ 结果：%@\n", kApiPrefix, URL, user.userId, H_EndDuration, params, responseObject);
//        if (!disableLoading) {
//            [KDialog hideLoading];
//        }
        
//        ResponseModel *responseModel = [ResponseModel mj_objectWithKeyValues:responseObject];
//        if (responseModel.code == kSuccessCode || responseModel.code == kListSuccessCode) {
//            // 请求成功
//            responseModel.isKSuccess = YES;
//        } else {
//            responseModel.isKSuccess = NO;
//            if (responseModel.code == kTokenExpiredCode) {
//                // token 过期
//                // 停止所有接口请求
//                [HNetwork cancelAllRequest];
//                [KDialog showToast:KLanguage(@"network_token_expired")];
//
//                [[UserManager shareInstance] logout];
//                // 139 579 840
//
//            } else {
//                if (responseModel.code == kPartyIsNotExistCode) {
//                    TopAlertModel *alertModel = [[TopAlertModel alloc] init];
//                    alertModel.title = KLanguage(@"top_alert_party_is_ended");
//                    alertModel.duration = 1;
//                    [KDialog showTopAlertWithModel:alertModel];
//
//                } else {
//                    // 其他异常
//                    NSString *errorString = responseModel.resultMsg;
//                    if ([errorString isEmpty]) {
//                        errorString = KLanguage(@"network_request_failed");
//                    }
//                    [KDialog showToast:errorString];
//                }
//            }
//        }
//        if (success) {
//            success(responseModel);
//        }
    } failure:^(NSError * _Nonnull error) {
//        KLog(@"\n请求失败 -> URL：%@%@\n 结果：%@\n", kApiPrefix, URL, error.localizedDescription);
//        if (!disableLoading) {
////            dispatch_async(dispatch_get_main_queue(), ^{
////                [hud removeFromSuperview];
////            });
//            [KDialog hideLoading];
//        }
//        if (failure) {
//            failure(error);
//        }
//        [KDialog showToast:KLanguage(@"network_request_failed")];
    }];
}


// 上传图片
+ (void)uploadImages:(NSArray<UIImage *> *)images imageScale:(CGFloat)imageScale imageType:(NSString *)imageType progress:(HNetworkProgress)progress success:(HRequestSuccess)success failure:(HNetworkFail)failure {
    
//    // 文件名字
//    NSString *fileName = [NSString stringWithFormat:@"%ld-%llu", (long)[UserManager shareInstance].user.userId, [KDate timestampSince1970]];
//
//    // url
//    NSString *url = [NSString stringWithFormat:@"%@%@", kApiPrefix, kUpload];
//
//
//    [HNetwork uploadImageURL:url parameters:@{} headers:nil images:images name:@"file" fileName:fileName imageScale:1 imageType:@"png" progress:progress success:^(id  _Nonnull responseObject) {
//        KLog(@">> uploadMedia:%@ url:%@", responseObject, url);
//        ResponseModel *responseModel = [ResponseModel mj_objectWithKeyValues:responseObject];
//        if (responseModel.code == kSuccessCode) {
//            // 请求成功
//            responseModel.isKSuccess = YES;
//        } else {
//            responseModel.isKSuccess = NO;
//            if (responseModel.code == kTokenExpiredCode) {
//                // token 过期
//                // 停止所有接口请求
//                [HNetwork cancelAllRequest];
//                [KDialog showToast:KLanguage(@"network_token_expired")];
//
//            } else {
//                // 其他异常
//                NSString *errorString = responseModel.resultMsg;
//                if ([errorString isEmpty]) {
//                    errorString = KLanguage(@"network_request_failed");
//                }
//                [KDialog showToast:errorString];
//            }
//        }
//        if (success) {
//            success(responseModel);
//        }
//    } failure:^(NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//        [KDialog showToast:KLanguage(@"network_request_failed")];
//    }];
}

// 上传文件
+ (void)uploadFile:(NSString *)filePath progress:(HNetworkProgress)progressBlock success:(HRequestSuccess)success failure:(HNetworkFail)failure {
    // 文件名字
//    NSString *fileName = [NSString stringWithFormat:@"%ld-%llu", (long)[UserManager shareInstance].user.userId, [KDate timestampSince1970]];
//    NSString *url = [NSString stringWithFormat:@"%@%@", kApiPrefix, kUpload];
//
//    [HNetwork uploadFileWithURL:url parameters:@{} headers:nil name:fileName filePath:filePath progress:^(NSProgress * _Nonnull progress) {
//        KLog(@"upload_file:%.2f%%",100.0 * progress.completedUnitCount/progress.totalUnitCount);
//        if (progressBlock) {
//            progressBlock(progress);
//        }
//    } success:^(id  _Nonnull responseObject) {
//        KLog(@">> uploadMedia:%@", responseObject);
//        ResponseModel *responseModel = [ResponseModel mj_objectWithKeyValues:responseObject];
//        if (responseModel.code == kSuccessCode) {
//            // 请求成功
//            responseModel.isKSuccess = YES;
//        } else {
//            responseModel.isKSuccess = NO;
//            if (responseModel.code == kTokenExpiredCode) {
//                // token 过期
//                // 停止所有接口请求
//                [HNetwork cancelAllRequest];
//                [KDialog showToast:KLanguage(@"network_token_expired")];
//
//            } else {
//                // 其他异常
//                NSString *errorString = responseModel.resultMsg;
//                if ([errorString isEmpty]) {
//                    errorString = KLanguage(@"network_request_failed");
//                }
//                [KDialog showToast:errorString];
//            }
//        }
//        if (success) {
//            success(responseModel);
//        }
//    } failure:^(NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//        [KDialog showToast:KLanguage(@"network_request_failed")];
//    }];
}
@end
