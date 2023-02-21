//
//  HUserDefaults.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/* UserDefaults */
@interface HUserDefaults : NSObject

// 存储:BOOL
+ (void)saveBool:(BOOL)value forKey:(NSString *)key;

// 存储:Integer
+ (void)saveInteger:(NSInteger)value forKey:(NSString *)key;

// 存储:Object
+ (void)saveObject:(id)value forKey:(NSString *)key;

// 读取:BOOL
+ (BOOL)queryBoolForKey:(NSString *)key;

// 读取:Integer
+ (NSInteger)queryIntegerForKey:(NSString *)key;

// 读取:Object
+ (id)queryObjectForKey:(NSString *)key;

// 删除
+ (void)deleteObjectForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
