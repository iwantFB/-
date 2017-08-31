//
//  BaseNaviViewController.m
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "BaseNaviViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface BaseNaviViewController ()<NSURLSessionDataDelegate>

@end

@implementation BaseNaviViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configSubViews];
}

- (void)configSubViews
{
    //将返回的按钮设置为自定义图片
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"backImage"] ];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"backImage"]];
    self.navigationBar.tintColor = [UIColor blackColor];
//
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"backImage"]  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [super pushViewController:viewController animated:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
