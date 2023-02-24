//
//  NavigationConfig.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import "NavigationConfig.h"

@implementation NavigationConfig

+ (void)config {
    // 配置导航栏属性
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure * _Nonnull configure) {
        // 导航栏背景色
        configure.backgroundColor = [UIColor whiteColor];
        // 导航栏标题颜色
        configure.titleColor = [UIColor blackColor];
        // 导航栏标题字体
        configure.titleFont = [UIFont systemFontOfSize:FONT(18) weight:UIFontWeightMedium];
        
        configure.lineHidden = YES;
        
        configure.lineColor = H_UIColorFromHex(0xFFF5F6F7, 1);
        
        // back image
//        UIImage *backImage = [UIImage imageNamed:@"navigation_back_black_ar_down_kbundle"];
//        if (isKRTL) {
//            backImage = [UIImage imageWithCGImage:backImage.CGImage scale:backImage.scale orientation:UIImageOrientationDown];
//        }
//        configure.backImage = backImage;
        
        // 不去修改导航栏的白名单
//        configure.shiledItemSpaceVCs = @[NSClassFromString(@"TZPhotoPickerController"), @"TZAlbumPickerController", @"TZ"];
    }];
    
    [GKGestureConfigure setupCustomConfigure:^(GKGestureHandleConfigure * _Nonnull configure) {
        configure.gk_translationX = 15;
        configure.gk_translationY = 20;
        configure.gk_scaleX = 0.90;
        configure.gk_scaleY = 0.92;
//        configure.shiledGuestureVCs = @[NSClassFromString(@"TZPhotoPickerController"), @"TZAlbumPickerController", @"TZ"];
        configure.gk_openScrollViewGestureHandle = YES;
    }];
}

@end
