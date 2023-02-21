//
//  ViewController.m
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HLog(@"%@", [[NSLocale preferredLanguages] objectAtIndex:0]);
    HLog(@"%@", [[[NSBundle mainBundle] preferredLocalizations] firstObject]);
    HLog(@"%@", SHADER_STRING(@"331"));
}


@end
