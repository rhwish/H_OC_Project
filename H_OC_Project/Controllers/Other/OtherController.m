//
//  OtherController.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import "OtherController.h"

#import "ModalController.h"
#import "LoginController.h"

@interface OtherController ()

@end

@implementation OtherController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *modalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    modalBtn.frame = CGRectMake(0, 0, 100, 44);
    modalBtn.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    modalBtn.backgroundColor = UIColor.systemOrangeColor;
    [modalBtn setTitle:H_Language(@"l_modal") forState:UIControlStateNormal];
    [modalBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [modalBtn addTarget:self action:@selector(onModal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modalBtn];
}


#pragma mark - Action
// modal
- (void)onModal {
    UserModel *user = [UserManager shareInstance].user;
    if (!user) { // 登录
        LoginController *loginVC = [[LoginController alloc] init];
        [self modalVC:loginVC completion:nil];
        return;
    }
    ModalController *modalVC = [[ModalController alloc] init];
    [self modalVC:modalVC completion:nil];
}

@end
