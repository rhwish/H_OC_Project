//
//  HSandBox.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/* 沙盒 */
@interface HSandBox : NSObject

/*
 @description:检查某个文件或目录是否存在
 @params:isDir: 是否为文件夹
 @return:结果
 */
+ (BOOL)fileIsExistInPath:(NSString *)path isDirectory:(BOOL)isDir;

/* 获取指定目录下对应文件夹路径 */
+ (NSString *)getSandboxCatalogDirPath:(NSString *)catalogPath withDirName:(NSString *)name;

/* 复制文件到指定目录 */
+ (BOOL)copyItemAtPath:(NSString *)fromPath toPath:(NSString *)toPath error:(NSError *__autoreleasing *)error;

/* 删除指定文件 */
+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError *__autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
