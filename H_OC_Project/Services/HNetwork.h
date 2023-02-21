//
//  HNetwork.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AFHTTPSessionManager;

/*
 请求方式
 */
typedef NS_ENUM(NSUInteger, HRequestMethod){
    /* GET请求方式 */
    HRequestMethodGET = 0,
    /* POST请求方式 */
    HRequestMethodPOST,
    /* HEAD请求方式 */
    HRequestMethodHEAD,
    /* PUT请求方式 */
    HRequestMethodPUT,
    /* PATCH请求方式 */
    HRequestMethodPATCH,
    /* DELETE请求方式 */
    HRequestMethodDELETE
};

/*
 网络状态
 */
typedef NS_ENUM(NSUInteger, HNetworkStatusType){
    /* 未知网络 */
    HNetworkStatusUnknown,
    /* 无网路 */
    HNetworkStatusNotReachable,
    /* 手机网络 */
    HNetworkStatusReachableWWAN,
    /* WiFi网络 */
    HNetworkStatusReachableWiFi,
};

/*
 请求数据格式
 */
typedef NS_ENUM(NSUInteger, HRequestSerializer){
    /* 设置请求数据为JSON格式 */
    HRequestSerializerJSON,
    /* 设置请求数据为二进制格式 */
    HRequestSerializerHTTP
};

/*
 相应数据格式
 */
typedef NS_ENUM(NSUInteger, HResponseSerializer) {
    /* 设置响应数据为JSON格式 */
    HResponseSerializerJSON,
    /* 设置响应数据为二进制格式 */
    HResponseSerializerHTTP
};

/* 请求的成功Block */
typedef void(^HNetworkSuccess)(id responseObject);

/* 请求的失败Block */
typedef void(^HNetworkFail)(NSError *error);

/* 下载的Block */
typedef void(^HNetworkDownload)(NSString *path);

/* 上传或者下载的进度 */
typedef void(^HNetworkProgress)(NSProgress *progress);

/* 网络状态Block */
typedef void(^HNetworkStatus)(HNetworkStatusType status);

@interface HNetwork : NSObject

/* 有网YES, 无网:NO */
+ (BOOL)hasNetwork;

/* 手机网络:YES, 反之:NO */
+ (BOOL)isWWANNetwork;

/* WiFi网络:YES, 反之:NO */
+ (BOOL)isWiFiNetwork;

/* 取消指定URL的HTTP请求 */
+ (void)cancelRequestWithURL:(NSString *)URL;

/* 取消所有HTTP请求 */
+ (void)cancelAllRequest;

/* 开启网络监听 */
+ (void)startMonitoring;

/* 停止网络监听 */
+ (void)stopMonitoring;

/*
 @description:实时获取网络状态,通过Block回调实时获取(此方法可多次调用)，内部已默认开启网络监听
 @params:networkStatus 返回当前网络类型的枚举
 */
+ (void)networkStatusWithBlock:(HNetworkStatus)networkStatus;

/* 是否打开网络加载菊花(默认打开) */
+ (void)openNetworkActivityIndicator:(BOOL)open;

/* 设置请求超时时间(默认30s) */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/* 设置接口根路径, 设置后所有的网络访问都使用相对路径 尽量以"/"结束 */
+ (void)setBaseURL:(NSString *)baseURL;

/* 设置接口基本参数(如:用户ID, Token) */
+ (void)setBaseParameters:(NSDictionary *)parameters;

/* 预设接口请求头 */
+ (void)setHeader:(NSDictionary *)header;


#pragma mark -- 网络请求 --

#pragma mark - GET请求
/*
 @description:GET请求
 @param URL 请求地址
 @param parameters 请求参数
 @param headers 附加到默认请求header的headers
 @param cachePolicy 缓存策略
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)GET:(NSString *)URL
 parameters:(NSDictionary *)parameters
    headers:(nullable NSDictionary<NSString *,NSString *>*)headers
    success:(HNetworkSuccess)success
    failure:(HNetworkFail)failure;


#pragma mark - POST请求
/*
 @description:POST请求
 @param URL 请求地址
 @param parameters 请求参数
 @param headers 附加到默认请求header的headers
 @param cachePolicy 缓存策略
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)POST:(NSString *)URL
  parameters:(NSDictionary *)parameters
     headers:(nullable NSDictionary<NSString *,NSString *>*)headers
     success:(HNetworkSuccess)success
     failure:(HNetworkFail)failure;


#pragma mark - HEAD请求
/*
 @description:HEAD请求
 @param url 请求地址
 @param parameters 请求参数
 @param headers 附加到默认请求header的headers
 @param cachePolicy 缓存策略
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)HEAD:(NSString *)url
  parameters:(NSDictionary *)parameters
     headers:(nullable NSDictionary<NSString *,NSString *>*)headers
     success:(HNetworkSuccess)success
     failure:(HNetworkFail)failure;


#pragma mark - PUT请求
/*
 @description:PUT请求
 @param url 请求地址
 @param parameters 请求参数
 @param headers 附加到默认请求header的headers
 @param cachePolicy 缓存策略
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)PUT:(NSString *)url
 parameters:(NSDictionary *)parameters
    headers:(nullable NSDictionary<NSString *,NSString *>*)headers
    success:(HNetworkSuccess)success
    failure:(HNetworkFail)failure;


#pragma mark - PATCH请求
/*
 @description:PATCH请求
 @param url 请求地址
 @param parameters 请求参数
 @param headers 附加到默认请求header的headers
 @param cachePolicy 缓存策略
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)PATCH:(NSString *)url
   parameters:(NSDictionary *)parameters
      headers:(nullable NSDictionary<NSString *,NSString *>*)headers
      success:(HNetworkSuccess)success
      failure:(HNetworkFail)failure;


#pragma mark - DELETE请求
/*
 @description:DELETE请求
 @param url 请求地址
 @param parameters 请求参数
 @param headers 附加到默认请求header的headers
 @param cachePolicy 缓存策略
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)DELETE:(NSString *)url
    parameters:(NSDictionary *)parameters
       headers:(nullable NSDictionary<NSString *,NSString *>*)headers
       success:(HNetworkSuccess)success
       failure:(HNetworkFail)failure;


#pragma mark - 自定义
/*
 @description:自定义请求方式
 @param method 请求方式(GET, POST, HEAD, PUT, PATCH, DELETE)
 @param url 请求地址
 @param parameters 请求参数
 @param headers 附加到默认请求header的headers
 @param cachePolicy 缓存策略
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)HTTPWithMethod:(HRequestMethod)method
                   url:(NSString *)url
            parameters:(NSDictionary *)parameters
               headers:(nullable NSDictionary<NSString *,NSString *>*)headers
               success:(HNetworkSuccess)success
               failure:(HNetworkFail)failure;


#pragma mark -- 上传文件
/*
 @description:上传文件
 @param url 服务器地址
 @param parameters 上传参数
 @param headers 附加到默认请求header的headers
 @param name 与服务器对应的字段
 @param filePath 文件对应本地的路径
 @param progress 上传进度
 @param success  上传成功
 @param failure  上传失败
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)url parameters:(NSDictionary *)parameters
                                headers:(nullable NSDictionary<NSString *,NSString *>*)headers
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(HNetworkProgress)progress
                                success:(HNetworkSuccess)success
                                failure:(HNetworkFail)failure;


#pragma mark -- 上传多张图片文件
/*
 @description:上传单/多张图片文件
 @param url 服务器地址
 @param parameters 上传参数
 @param headers 附加到默认请求header的headers
 @param images 图片数组
 @param name 与服务器对应的字段
 @param fileName 文件名 最终结果处理为文件名+文件在数组中的index
 @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 @param imageType 图片的类型,png,jpeg
 @param progress  上传进度
 @param success  上传成功
 @param failure  上传失败
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *)uploadImageURL:(NSString *)url
                          parameters:(NSDictionary *)parameters
                             headers:(nullable NSDictionary<NSString *,NSString *>*)headers
                              images:(NSArray<UIImage *> *)images
                                name:(NSString *)name
                            fileName:(NSString *)fileName
                          imageScale:(CGFloat)imageScale
                           imageType:(NSString *)imageType
                            progress:(HNetworkProgress)progress
                             success:(HNetworkSuccess)success
                             failure:(HNetworkFail)failure;


#pragma mark -- 下载文件
/*
 @description:下载文件
 @param url 服务器地址
 @param fileDir 文件本地的沙盒路径（默认为DownLoad文件夹）
 @param progress 上传进度
 @param success  上传成功
 @param failure  上传失败
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *) downloadWithURL:(NSString *)url
                               fileDir:(nullable NSString *)fileDir
                              progress:(HNetworkProgress)progress
                               success:(HNetworkDownload)success
                               failure:(HNetworkFail)failure;

/*
 @description:下载文件
 @param resumeData 用于继续下载的数据
 @param fileDir 文件本地的沙盒路径（默认为DownLoad文件夹）
 @param progress 上传进度
 @param success  上传成功
 @param failure  上传失败
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *) downloadTaskWithResumeData:(NSData *)resumeData
                                          fileDir:(nullable NSString *)fileDir
                                         progress:(HNetworkProgress)progress
                                          success:(HNetworkDownload)success
                                          failure:(HNetworkFail)failure;


#pragma mark -- 重置AFHTTPSessionManager相关属性

#pragma mark - 设置AFHTTPSessionManager相关属性
#pragma mark 注意: 因为全局只有一个AFHTTPSessionManager实例,所以以下设置方式全局生效

/*
 @description:在开发中,如果以下的设置方式不满足项目的需求,就调用此方法获取AFHTTPSessionManager实例进行自定义设置
 @description:(注意: 调用此方法时要导入AFNetworking.h头文件,否则可能会报找不到AFHTTPSessionManager的❌)
 @param sessionManager AFHTTPSessionManager的实例
 */
+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager;

/*
 @description:设置网络请求参数的格式:默认为JSON格式
 @param requestSerializer HRequestSerializerJSON---JSON格式  HRequestSerializerHTTP--HTTP
 */
+ (void)setRequestSerializer:(HRequestSerializer)requestSerializer;

/*
 @description:设置服务器响应数据格式:默认为JSON格式
 @param responseSerializer HResponseSerializerJSON---JSON格式  HResponseSerializerHTTP--HTTP
 */
+ (void)setResponseSerializer:(HResponseSerializer)responseSerializer;

/*
 @description:设置请求头
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/*
 @description:配置自建证书的Https请求，参考链接:http://blog.csdn.net/syg90178aw/article/details/52839103
 @param cerPath 自建https证书路径
 @param validatesDomainName 是否验证域名(默认YES) 如果证书的域名与请求的域名不一致，需设置为NO
 服务器使用其他信任机构颁发的证书也可以建立连接，但这个非常危险，建议打开 .validatesDomainName=NO,主要用于这种情况:客户端请求的是子域名，而证书上是另外一个域名。因为SSL证书上的域名是独立的
 For example:证书注册的域名是www.baidu.com,那么mail.baidu.com是无法验证通过的
 */
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName;

@end

NS_ASSUME_NONNULL_END
