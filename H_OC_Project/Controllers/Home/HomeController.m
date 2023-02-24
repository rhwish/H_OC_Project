//
//  HomeController.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import "HomeController.h"

#import "LoginController.h"
#import "PushController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(0, 0, 100, 44);
    pushBtn.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    pushBtn.backgroundColor = UIColor.systemOrangeColor;
    [pushBtn setTitle:H_Language(@"l_push") forState:UIControlStateNormal];
    [pushBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(onPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
}


#pragma mark - Action
// push
- (void)onPush {
    UserModel *user = [UserManager shareInstance].user;
    if (!user) { // 登录
        LoginController *loginVC = [[LoginController alloc] init];
        [self modalVC:loginVC completion:nil];
        return;
    }
    PushController *pushVC = [[PushController alloc] init];
    [self pushVC:pushVC];
}

@end
