//
//  TabbarViewController.m
//  openeyes
//
//  Created by YSmac1 on 16/10/11.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "TabbarViewController.h"
#import "FHSelectedViewController.h"
#import "FoundViewController.h"
#import "AuthorViewController.h"
#import "MineViewController.h"
#import "BaseNaviViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSubViewControllers];
    
}

- (void)initSubViewControllers
{
    self.viewControllers = [self createViewControllersWithClassStringarr:@[@"FHSelectedViewController",@"FoundViewController",@"AuthorViewController",@"MineViewController"]];;
}

-  (NSArray *)createViewControllersWithClassStringarr:(NSArray *)classStringArr
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *titleArr = @[@"精选",@"发现",@"作者",@"我的"];
    for (int i = 0; i < classStringArr.count; i++) {
        UIViewController *VC = [[NSClassFromString(classStringArr[i]) alloc] init];
        VC.title = titleArr[i];
        BaseNaviViewController *navi = [[BaseNaviViewController alloc] initWithRootViewController:VC];
        [arr addObject:navi];
    }
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    return arr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
