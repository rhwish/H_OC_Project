//
//  HSandBox.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "HSandBox.h"

@implementation HSandBox

/*
 @description:检查某个文件或目录是否存在
 @params:isDir: 是否为文件夹
 @return:结果
 */
+ (BOOL)fileIsExistInPath:(NSString *)path isDirectory:(BOOL)isDir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    return isExist;
}


// 获取指定目录下对应文件夹路径
+ (NSString *)getSandboxCatalogDirPath:(NSString *)catalogPath withDirName:(NSString *)name {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 对应文件夹路径
    NSString *dataPath = [catalogPath stringByAppendingPathComponent:name];
    // 判断对应文件夹是否存在
    BOOL isDir = YES;
    BOOL isExist = [[self class] fileIsExistInPath:dataPath isDirectory:isDir];
    if (!isExist) {
        NSError *creatError;
        [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&creatError];
    }
    return dataPath;
}


// 复制文件到指定目录
+ (BOOL)copyItemAtPath:(NSString *)fromPath toPath:(NSString *)toPath error:(NSError *__autoreleasing  _Nullable *)error {
    // 先要保证源文件路径存在，不然抛出异常
    if (![self fileIsExistInPath:fromPath isDirectory:NO]) {
        [NSException raise:@"非法的源文件路径" format:@"源文件路径%@不存在，请检查源文件路径", fromPath];
        return NO;
    }
    
    // 如果存在同名文件，先删除
    if ([self fileIsExistInPath:toPath isDirectory:NO]) {
        [self removeItemAtPath:toPath error:error];
    }
    
    // 复制文件，如果不覆盖且文件已存在则会复制失败
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:fromPath toPath:toPath error:error];
    
    return isSuccess;
}

// 删除指定文件
+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError *__autoreleasing  _Nullable *)error {
    if ([self fileIsExistInPath:path isDirectory:NO]) {
        return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
    }
    return YES;
}

@end
