//
//  HNetwork.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/17.
//

#import "HNetwork.h"

#import <AFNetworking/AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

@implementation HNetwork

/* 所有请求任务 */
static NSMutableArray *_allSessionTask;

static AFHTTPSessionManager *_sessionManager;

static NSDictionary *_baseParameters;

static NSString * _baseURL;


/*所有的请求task数组*/
+ (NSMutableArray *)allSessionTask{
    if (!_allSessionTask) {
        _allSessionTask = [NSMutableArray array];
    }
    return _allSessionTask;
}


#pragma mark -- 初始化相关属性
+ (void)initialize{
    _sessionManager = [AFHTTPSessionManager manager];
    //设置请求超时时间
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    //设置服务器返回结果的类型:JSON(AFJSONResponseSerializer,AFHTTPResponseSerializer)
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"multipart/form-data",@"application/x-www-form-urlencoded", nil];
    //开始监测网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //打开状态栏菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}


/* 有网YES, 无网:NO */
+ (BOOL)hasNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

/* 手机网络:YES, 反之:NO */
+ (BOOL)isWWANNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

/* WiFi网络:YES, 反之:NO */
+ (BOOL)isWiFiNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

/* 取消指定URL的HTTP请求 */
+ (void)cancelRequestWithURL:(NSString *)URL{
    if (!URL) { return; }
    
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

/* 取消所有HTTP请求 */
+ (void)cancelAllRequest{
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)startMonitoring{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)stopMonitoring{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

/* 实时获取网络状态,通过Block回调实时获取(此方法可多次调用) */
+ (void)networkStatusWithBlock:(HNetworkStatus)networkStatus{
    //开启网络监听
    [self startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkStatus ? networkStatus(HNetworkStatusUnknown) : nil;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus ? networkStatus(HNetworkStatusNotReachable) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus ? networkStatus(HNetworkStatusReachableWWAN) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus ? networkStatus(HNetworkStatusReachableWiFi) : nil;
                break;
            default:
                break;
        }
    }];
}

/* 是否打开网络加载菊花(默认打开) */
+ (void)openNetworkActivityIndicator:(BOOL)open{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

/* 设置请求超时时间(默认30s) */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time{
    _sessionManager.requestSerializer.timeoutInterval = time;
}

/* 设置接口根路径, 设置后所有的网络访问都使用相对路径 尽量以"/"结束 */
+ (void)setBaseURL:(NSString *)baseURL{
    _baseURL = baseURL;
}

/* 设置接口基本参数(如:用户ID, Token) */
+ (void)setBaseParameters:(NSDictionary *)parameters{
    _baseParameters = parameters;
}

/* 设置接口请求头 */
+ (void)setHeader:(NSDictionary *)header{
    for (NSString * key in header.allKeys) {
        [_sessionManager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
}


#pragma mark -- GET请求
+ (void)GET:(NSString *)URL
 parameters:(NSDictionary *)parameters
    headers:(NSDictionary<NSString *,NSString *>*)headers
    success:(HNetworkSuccess)success
    failure:(HNetworkFail)failure{
    [self HTTPWithMethod:HRequestMethodGET url:URL parameters:parameters headers:headers success:success failure:failure];
}


#pragma mark -- POST请求
+ (void)POST:(NSString *)URL
  parameters:(NSDictionary *)parameters
     headers:(NSDictionary<NSString *,NSString *>*)headers
     success:(HNetworkSuccess)success
     failure:(HNetworkFail)failure{
    [self HTTPWithMethod:HRequestMethodPOST url:URL parameters:parameters headers:headers success:success failure:failure];
}

#pragma mark -- HEAD请求
+ (void)HEAD:(NSString *)url
  parameters:(NSDictionary *)parameters
     headers:(NSDictionary<NSString *,NSString *>*)headers
     success:(HNetworkSuccess)success
     failure:(HNetworkFail)failure{
    [self HTTPWithMethod:HRequestMethodHEAD url:url parameters:parameters headers:headers success:success failure:failure];
}


#pragma mark -- PUT请求
+ (void)PUT:(NSString *)url
 parameters:(NSDictionary *)parameters
    headers:(NSDictionary<NSString *,NSString *>*)headers
    success:(HNetworkSuccess)success
    failure:(HNetworkFail)failure{
    [self HTTPWithMethod:HRequestMethodPUT url:url parameters:parameters headers:headers success:success failure:failure];
}


#pragma mark -- PATCH请求
+ (void)PATCH:(NSString *)url
   parameters:(NSDictionary *)parameters
      headers:(NSDictionary<NSString *,NSString *>*)headers
      success:(HNetworkSuccess)success
      failure:(HNetworkFail)failure{
    [self HTTPWithMethod:HRequestMethodPATCH url:url parameters:parameters headers:headers success:success failure:failure];
}


#pragma mark -- DELETE请求
+ (void)DELETE:(NSString *)url
    parameters:(NSDictionary *)parameters
       headers:(NSDictionary<NSString *,NSString *>*)headers
       success:(HNetworkSuccess)success
       failure:(HNetworkFail)failure {
    [self HTTPWithMethod:HRequestMethodDELETE url:url parameters:parameters headers:headers success:success failure:failure];
}


#pragma mark -- 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)url parameters:(NSDictionary *)parameters
                                headers:(NSDictionary<NSString *,NSString *>*)headers
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(HNetworkProgress)progress
                                success:(HNetworkSuccess)success
                                failure:(HNetworkFail)failure{
    NSURLSessionTask *sessionTask = [_sessionManager POST:url parameters:parameters headers:headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //添加-文件
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        failure? failure(error) : nil;
    }];
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
}

#pragma mark -- 上传图片文件
+ (NSURLSessionTask *)uploadImageURL:(NSString *)url parameters:(NSDictionary *)parameters
                             headers:(NSDictionary<NSString *,NSString *>*)headers
                              images:(NSArray<UIImage *> *)images
                                name:(NSString *)name
                            fileName:(NSString *)fileName
                          imageScale:(CGFloat)imageScale
                           imageType:(NSString *)imageType
                            progress:(HNetworkProgress)progress
                             success:(HNetworkSuccess)success
                             failure:(HNetworkFail)failure{
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:url parameters:parameters headers:headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            NSString *imageFileName = fileName;
            if (!imageFileName) {
                // 默认图片的文件名, 若fileNames为nil就使用
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                imageFileName = NSStringFormat(@"%@%lu.%@", str, idx, imageType ?: @"jpg");
            }
            
            [formData appendPartWithFileData:imageData name:name fileName:NSStringFormat(@"%@%lu.%@",fileName,(unsigned long)idx,imageType ? imageType : @"jpeg")
                                    mimeType:NSStringFormat(@"image/%@",imageType ? imageType : @"jpeg")];
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        failure? failure(error) : nil;
    }];
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
};

#pragma mark -- 下载文件
+ (NSURLSessionTask *) downloadWithURL:(NSString *)url fileDir:(NSString *)fileDir progress:(HNetworkProgress)progress success:(HNetworkDownload)success
                               failure:(HNetworkFail)failure{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建DownLoad目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];

        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allSessionTask] removeObject:downloadTask];
        if (failure && error) {
            failure ? failure(error) : nil;
            return;
        }
        success ? success(filePath.absoluteString) : nil;
    }];
    //开始下载
    [downloadTask resume];
    
    //添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil;
    
    return downloadTask;
}


+ (NSURLSessionTask *) downloadTaskWithResumeData:(NSData *)resumeData
                                          fileDir:(NSString *)fileDir
                                         progress:(HNetworkProgress)progress
                                          success:(HNetworkDownload)success
                                          failure:(HNetworkFail)failure{
    
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithResumeData:resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
        
    }destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建DownLoad目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];

        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allSessionTask] removeObject:downloadTask];
        if (failure && error) {
            failure ? failure(error) : nil;
            return;
        }
        success ? success(filePath.absoluteString) : nil;
    }];
    
    //开始下载
    [downloadTask resume];
    
    //添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil;
    
    return downloadTask;
}

+ (void)HTTPWithMethod:(HRequestMethod)method
                   url:(NSString *)url
            parameters:(NSDictionary *)parameters
               headers:(NSDictionary<NSString *,NSString *>*)headers
               success:(HNetworkSuccess)success
               failure:(HNetworkFail)failure{
    
    if (_baseURL.length) {
        url = NSStringFormat(@"%@%@",_baseURL,url);
    }
    
    if (_baseParameters.count) {
        NSMutableDictionary * mutableBaseParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [mutableBaseParameters addEntriesFromDictionary:_baseParameters];
        parameters = [mutableBaseParameters copy];
    }
    
    [self httpWithMethod:method url:url parameters:parameters headers:headers success:success failure:failure];
}


#pragma mark -- 网络请求处理
+ (void)httpWithMethod:(HRequestMethod)method
                   url:(NSString *)url
            parameters:(NSDictionary *)parameters
               headers:(NSDictionary<NSString *,NSString *>*)headers
               success:(HNetworkSuccess)success
               failure:(HNetworkFail)failure{
    
    [self dataTaskWithHTTPMethod:method url:url parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
        [[self allSessionTask] removeObject:task];
    }];
    
}

+ (void)dataTaskWithHTTPMethod:(HRequestMethod)method url:(NSString *)url
                    parameters:(NSDictionary *)parameters
                       headers:(NSDictionary<NSString *,NSString *>*)headers
                       success:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    NSURLSessionTask *sessionTask;
    
    switch (method) {
        case HRequestMethodGET:{
            sessionTask = [_sessionManager GET:url parameters:parameters headers:headers progress:nil success:success failure:failure];
        }
            break;
        case HRequestMethodPOST:{
            sessionTask = [_sessionManager POST:url parameters:parameters headers:headers progress:nil success:success failure:failure];
        }
            break;
        case HRequestMethodHEAD:{
            sessionTask = [_sessionManager HEAD:url parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task) {
                success(task,nil);
            } failure:failure];
        }
            break;
        case HRequestMethodPUT:{
            sessionTask = [_sessionManager PUT:url parameters:parameters headers:headers success:success failure:failure];
        }
            break;
        case HRequestMethodPATCH:{
            sessionTask = [_sessionManager PATCH:url parameters:parameters headers:headers success:success failure:failure];
        }
            break;
        case HRequestMethodDELETE:{
            sessionTask = [_sessionManager DELETE:url parameters:parameters headers:headers success:success failure:failure];
            break;
        }
        default:
            break;
    }
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
}


+ (NSString *)getMethodStr:(HRequestMethod)method{
    switch (method) {
        case HRequestMethodGET:
            return @"GET";
            break;
        case HRequestMethodPOST:
            return @"POST";
            break;
        case HRequestMethodHEAD:
            return @"HEAD";
            break;
        case HRequestMethodPUT:
            return @"PUT";
            break;
        case HRequestMethodPATCH:
            return @"PATCH";
            break;
        case HRequestMethodDELETE:
            return @"DELETE";
            break;
            
        default:
            break;
    }
}


/************************************重置AFHTTPSessionManager相关属性**************/
#pragma mark -- 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(HRequestSerializer)requestSerializer{
    _sessionManager.requestSerializer = requestSerializer== HRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(HResponseSerializer)responseSerializer{
    _sessionManager.responseSerializer = responseSerializer== HResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}


+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field{
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}


+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName{
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    //使用证书验证模式
    AFSecurityPolicy *securitypolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //如果需要验证自建证书(无效证书)，需要设置为YES
    securitypolicy.allowInvalidCertificates = YES;
    //是否需要验证域名，默认为YES
    securitypolicy.validatesDomainName = validatesDomainName;
    securitypolicy.pinnedCertificates = [[NSSet alloc]initWithObjects:cerData, nil];
    [_sessionManager setSecurityPolicy:securitypolicy];
}


@end






#pragma mark -- NSDictionary,NSArray的分类
/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */
//#ifdef DEBUG
@implementation NSArray (AT)

- (NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@,\n",obj];
    }];
    [strM appendString:@")\n"];
    return  strM;
}
@end

@implementation NSDictionary (AT)

- (NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@ = %@,\n",key,obj];
    }];
    [strM appendString:@"}\n"];
    return  strM;
}

@end
