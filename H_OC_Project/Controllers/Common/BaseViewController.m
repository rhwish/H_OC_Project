//
//  BaseViewController.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import "BaseViewController.h"

#import <GKNavigationBar/GKNavigationBar.h>

@interface BaseViewController ()

// 更新页面数据Block
@property (copy, nonatomic, readwrite) CommonOperationBlock updateDataBlock;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.gk_navigationBar.hidden = YES;
}


#pragma mark - Navigation
// push to next page
- (void)pushVC:(UIViewController *)vc {
    [self.navigationController pushViewController:vc animated:YES];
}

// push vc from rootVC to next page
- (void)pushVCFromRoot:(UIViewController *)vc {
    HNavigationController *rootVC = [self getRootViewController];
    [rootVC pushViewController:vc animated:YES];
}

// back to last page(from push type)
- (void)popVC {
    UIViewController *firstPresentVC = self.presentedViewController;
    if (firstPresentVC) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

// back to special page(from push type)
- (void)popToVC:(UIViewController *)vc {
    [self.navigationController popToViewController:vc animated:YES];
}

// back to root page(from push type)
- (void)popToRootVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// use new page replace current page
- (void)replaceVC:(UIViewController *)vc {
    NSMutableArray *navViewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [navViewControllers removeLastObject];
    [navViewControllers addObject:vc];
    [self.navigationController setViewControllers:navViewControllers animated:YES];
}

// 返回上一个界面
- (void)backVC {
    if (self.presentingViewController) {
        [self dismissModalVCWithCompletion:nil];
    } else {
        [self popVC];
    }
}

// show new page(modal type)
- (void)modalVC:(UIViewController *)vc completion:(void (^ __nullable)(void))completion {
    [self presentViewController:vc animated:YES completion:completion];
}

// dismiss modal page
- (void)dismissModalVCWithCompletion:(void (^ __nullable)(void))completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

// dismiss all modal page
- (void)dismissAllModalVCWithCompletion:(void (^ __nullable)(void))completion; {
    UIViewController *presentingViewController = self.presentingViewController ;
    UIViewController *lastVC = self ;
    while (presentingViewController) {
        id temp = presentingViewController;
        presentingViewController = [presentingViewController presentingViewController];
        lastVC = temp ;
    }

    [lastVC dismissViewControllerAnimated:YES completion:^{
        if (completion) {
            completion();
        }
    }];
}


#pragma mark - Get Method
// get key window
- (UIWindow *)getKeyWindow {
    return [UIApplication sharedApplication].keyWindow;
}

// get root view controller
- (HNavigationController *)getRootViewController {
    HNavigationController *rootVC = (HNavigationController *)[self getKeyWindow].rootViewController;
    return rootVC;
}


#pragma mark - Update data
// 更新数据
- (void)onUpdateData:(CommonOperationBlock)block {
    self.updateDataBlock = block;
}


@end
