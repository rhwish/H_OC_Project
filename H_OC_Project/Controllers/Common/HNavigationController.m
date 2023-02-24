//
//  HNavigationController.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/23.
//

#import "HNavigationController.h"

#import <GKNavigationBar/GKNavigationBar.h>

@interface HNavigationController ()

@end

@implementation HNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_openScrollLeftPush = YES;
    self.gk_openSystemNavHandle = YES;
}


@end
