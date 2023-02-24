//
//  BaseViewController.h
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import <UIKit/UIKit.h>

#import "HNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

/* 页面更新数据block */
typedef void(^OnUpdatePageDataBlock)(id data);

@interface BaseViewController : UIViewController

#pragma mark - Navigation
// push to next page
- (void)pushVC:(UIViewController *)vc;

// push vc from rootVC to next page
- (void)pushVCFromRoot:(UIViewController *)vc;

// back to last page(from push type)
- (void)popVC;

// back to special page(from push type)
- (void)popToVC:(UIViewController *)vc;

// back to root page(from push type)
- (void)popToRootVC;

// use new page replace current page
- (void)replaceVC:(UIViewController *)vc;

// 返回上一个界面
- (void)backVC;

// show new page(modal type)
- (void)modalVC:(UIViewController *)vc completion:(void (^ __nullable)(void))completion;

// dismiss modal page
- (void)dismissModalVCWithCompletion:(void (^ __nullable)(void))completion;

// dismiss all modal page
- (void)dismissAllModalVCWithCompletion:(void (^ __nullable)(void))completion;


#pragma mark - Get Method
// get key window
- (UIWindow *)getKeyWindow;

// get root view controller
- (HNavigationController *)getRootViewController;


#pragma mark - Update data
// 更新数据
- (void)onUpdateData:(CommonOperationBlock)block;

@end

NS_ASSUME_NONNULL_END
