//
//  LoginController.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import "LoginController.h"

#import "HTabBarController.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(0, 0, 100, 44);
    loginBtn.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    loginBtn.backgroundColor = UIColor.systemOrangeColor;
    [loginBtn setTitle:H_Language(@"l_login") forState:UIControlStateNormal];
    [loginBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}


#pragma mark - Action
// login
- (void)onLogin {
    UserModel *user = [[UserModel alloc] init];
    user.userId = 1;
    [[UserManager shareInstance] updateUser:user];
    [HUserDefaults saveObject:@{@"userId": @(1)} forKey:kStorageUserInfoKey];
    
    if (LoginFirst) {
        HTabBarController *tabBarController = [[HTabBarController alloc] init];
        self.navigationController.viewControllers = @[tabBarController];
    } else {
        [self dismissModalVCWithCompletion:nil];
    }
    
}


@end
