//
//  MineController.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import "MineController.h"

@interface MineController ()

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(0, 0, 100, 44);
    logoutBtn.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    logoutBtn.backgroundColor = UIColor.systemOrangeColor;
    [logoutBtn setTitle:H_Language(@"l_logout") forState:UIControlStateNormal];
    [logoutBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(onLogout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
}


#pragma mark - Action
// logout
- (void)onLogout {
    [[UserManager shareInstance] logout];
}

@end
