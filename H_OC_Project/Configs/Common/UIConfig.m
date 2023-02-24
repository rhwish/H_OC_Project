//
//  UIConfig.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/24.
//

#import "UIConfig.h"

#import <UIKit/UIKit.h>

@implementation UIConfig

+ (void)config {
    if (@available(iOS 15.0, *)) {
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
}

@end
