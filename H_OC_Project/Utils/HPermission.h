//
//  HPermission.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 权限授权
typedef NS_ENUM(NSUInteger, PermissionResultType) {
    PermissionResultTypeAuthed,
    PermissionResultTypeDenied,
    PermissionResultTypeNotDetermined,
};

typedef void(^PermissionResultBlock)(PermissionResultType type, NSString *msg);

@interface HPermission : NSObject

// 获取通讯录权限
+ (void)getContactPermission:(PermissionResultBlock)block;

// 获取位置权限
+ (void)getLocationPermission:(PermissionResultBlock)block;

// 获取通知权限
+ (void)getNotificationPermission:(PermissionResultBlock)block;

// 获取录音权限
+ (void)getMicrophonePermission:(PermissionResultBlock)block;

// 获取相册权限
+ (void)getPhotoLibraryPermission:(PermissionResultBlock)block;

// 获取相机权限
+ (void)getCameraPermission:(PermissionResultBlock)block;

// 获取日历权限
+ (void)getCalendarPermission:(PermissionResultBlock)block;

// 获取提醒权限
+ (void)getReminderPermission:(PermissionResultBlock)block;

// 跳转应用设置
+ (void)openApplicationSetting;

@end

NS_ASSUME_NONNULL_END
