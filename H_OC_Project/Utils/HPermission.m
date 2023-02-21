//
//  HPermission.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "HPermission.h"

#import <Photos/Photos.h>
#import <EventKit/EventKit.h>
#import <Contacts/Contacts.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>

@interface HPermission ()<CLLocationManagerDelegate>

@end

static PermissionResultBlock permissionBlock = nil;

@implementation HPermission

+ (void)getContactPermission:(PermissionResultBlock)block {
    CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    if (authStatus == CNAuthorizationStatusAuthorized) {
        // 已授权
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeAuthed, @"");
        });
    } else if (authStatus == CNAuthorizationStatusNotDetermined) {
        // 用户未决断
        // 触发授权
        [[[CNContactStore alloc] init] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    block(PermissionResultTypeAuthed, @"");
                } else {
                    block(PermissionResultTypeDenied, @"用户已拒绝");
                }
            });
        }];
    } else {
        // 已拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeDenied, @"用户已拒绝");
        });
    }
}

// 获取位置权限
+ (void)getLocationPermission:(PermissionResultBlock)block {
    permissionBlock = block;
    
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];

    if (authStatus == kCLAuthorizationStatusAuthorizedAlways || authStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // 已授权
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeAuthed, @"");
        });
    } else if (authStatus == kCLAuthorizationStatusNotDetermined) {
        // 用户未决断
        // 触发授权
        CLLocationManager * locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        // 在app打开期间使用定位权限
        [locationManager requestWhenInUseAuthorization];
        // app在后台也可以持续定位
//        [locationManager requestAlwaysAuthorization];
    } else {
        // 已拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeDenied, @"用户已拒绝");
        });
    }
}

// 获取通知权限
+ (void)getNotificationPermission:(PermissionResultBlock)block {
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        // 获取状态
        UNAuthorizationStatus authStatus = settings.authorizationStatus;
        
        if (authStatus == UNAuthorizationStatusAuthorized) {
            // 已授权
            dispatch_async(dispatch_get_main_queue(), ^{
                block(PermissionResultTypeAuthed, @"");
            });
        } else if (authStatus == UNAuthorizationStatusNotDetermined) {
            // 用户未决断
            // 触发授权
            UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                //  granted 代表允许与否
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 回到主线程
                    if (granted) {
                        block(PermissionResultTypeAuthed, @"");
                    } else {
                        block(PermissionResultTypeDenied, @"用户已拒绝");
                    }
                });
            }];
        } else {
            // 已拒绝
            dispatch_async(dispatch_get_main_queue(), ^{
                block(PermissionResultTypeDenied, @"用户已拒绝");
            });
        }
    }];
}

// 获取录音权限
+ (void)getMicrophonePermission:(PermissionResultBlock)block {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if (authStatus == AVAuthorizationStatusAuthorized) {
        // 已授权
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeAuthed, @"");
        });
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // 用户未决断
        // 触发授权
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 回到主线程
                if (granted) {
                    block(PermissionResultTypeAuthed, @"");
                } else {
                    block(PermissionResultTypeDenied, @"用户已拒绝");
                }
            });
        }];
    } else {
        // 已拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeDenied, @"用户已拒绝");
        });
    }
}

// 获取相册权限
+ (void)getPhotoLibraryPermission:(PermissionResultBlock)block {
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
    if (authStatus == PHAuthorizationStatusAuthorized) {
        // 已授权
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeAuthed, @"");
        });
    } else if (authStatus == PHAuthorizationStatusNotDetermined) {
        // 用户未决断
        // 触发授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    block(PermissionResultTypeAuthed, @"");
                } else {
                    block(PermissionResultTypeDenied, @"用户已拒绝");
                }
            });
        }];
    } else {
        // 已拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeDenied, @"用户已拒绝");
        });
    }
}

// 获取相机权限
+ (void)getCameraPermission:(PermissionResultBlock)block {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusAuthorized) {
        // 已授权
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeAuthed, @"");
        });
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // 用户未决断
        // 触发授权
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    block(PermissionResultTypeAuthed, @"");
                } else {
                    block(PermissionResultTypeDenied, @"用户已拒绝");
                }
            });
         }];
    } else {
        // 已拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeDenied, @"用户已拒绝");
        });
    }
}


// 获取日历权限
+ (void)getCalendarPermission:(PermissionResultBlock)block {
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    if (authStatus == EKAuthorizationStatusAuthorized) {
        // 已授权
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeAuthed, @"");
        });
    } else if (authStatus == EKAuthorizationStatusNotDetermined) {
        // 用户未决断
        // 触发授权
        EKEventStore *store = [[EKEventStore alloc] init];
        if ([store respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        block(PermissionResultTypeAuthed, @"");
                    } else {
                        block(PermissionResultTypeDenied, @"用户已拒绝");
                    }
                });
            }];
        }
    } else {
        // 已拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeDenied, @"用户已拒绝");
        });
    }
}

// 获取提醒权限
+ (void)getReminderPermission:(PermissionResultBlock)block {
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    if (authStatus == EKAuthorizationStatusAuthorized) {
        // 已授权
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeAuthed, @"");
        });
    } else if (authStatus == EKAuthorizationStatusNotDetermined) {
        // 用户未决断
        // 触发授权
        EKEventStore *store = [[EKEventStore alloc] init];
        if ([store respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
            [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        block(PermissionResultTypeAuthed, @"");
                    } else {
                        block(PermissionResultTypeDenied, @"用户已拒绝");
                    }
                });
            }];
        }
    } else {
        // 已拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            block(PermissionResultTypeDenied, @"用户已拒绝");
        });
    }
}


// 跳转应用设置
+ (void)openApplicationSetting {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
}

@end
