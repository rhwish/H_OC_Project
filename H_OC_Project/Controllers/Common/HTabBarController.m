//
//  HTabBarController.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import "HTabBarController.h"

#import "HomeController.h"
#import "OtherController.h"
#import "MineController.h"

@interface HTabBarController ()

@end

@implementation HTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor whiteColor];
    
    HomeController *homeVC = [[HomeController alloc] init];
    homeVC.tabBarItem.title = @"Home";
    homeVC.tabBarItem.tag = 0;
    [self addChildViewController:homeVC];
    
    OtherController *otherVC = [[OtherController alloc] init];
    otherVC.tabBarItem.title = @"Other";
    otherVC.tabBarItem.tag = 1;
    [self addChildViewController:otherVC];
    
    MineController *mineVC = [[MineController alloc] init];
    mineVC.tabBarItem.title = @"Mine";
    mineVC.tabBarItem.tag = 2;
    [self addChildViewController:mineVC];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}



@end
