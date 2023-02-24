//
//  ModalController.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/24.
//

#import "ModalController.h"

@interface ModalController ()

@end

@implementation ModalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *enBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enBtn.tag = 1;
    enBtn.vParam = @"en";
    enBtn.frame = CGRectMake(0, 0, 100, 44);
    enBtn.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/3.0);
    enBtn.backgroundColor = UIColor.systemOrangeColor;
    [enBtn setTitle:H_Language(@"l_en_language") forState:UIControlStateNormal];
    [enBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [enBtn addTarget:self action:@selector(onChangeLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enBtn];
    
    UIButton *zhBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhBtn.tag = 2;
    zhBtn.vParam = @"zh-Hans";
    zhBtn.frame = CGRectMake(0, 0, 100, 44);
    zhBtn.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    zhBtn.backgroundColor = UIColor.systemOrangeColor;
    [zhBtn setTitle:H_Language(@"l_zh_language") forState:UIControlStateNormal];
    [zhBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [zhBtn addTarget:self action:@selector(onChangeLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhBtn];
}


#pragma mark - Action
// 切换语言
- (void)onChangeLanguage:(UIButton *)sender {
    [[UserManager shareInstance] updateUserLocale:sender.vParam];
}

@end
