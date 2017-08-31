//
//  MineViewController.m
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "MineViewController.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <AVKit/AVPlayerViewController.h>

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的";
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
