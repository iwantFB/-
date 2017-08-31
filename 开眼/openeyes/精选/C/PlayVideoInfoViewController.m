//
//  PlayVideoInfoViewController.m
//  openeyes
//
//  Created by YSmac1 on 16/10/14.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "VideoPlayView.h"
#import "VideoPlayInfoView.h"

#import "PlayVideoInfoViewController.h"
#import  "FHSelectedViewController.h"
#import "VideoPlayViewController.h"

#import "FHSelectedModel.h"


@interface PlayVideoInfoViewController ()<VideoPlayViewDelegate>

@end

@implementation PlayVideoInfoViewController
{
    VideoPlayView *_topView;
    UIImageView *_bgImageView;
    
    VideoPlayInfoView *_bottomView;
    FHSelectedModel *_model;
}

- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}


#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:0.5 animations:^{//隐藏tabbar并改变frame值

        _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.6);
        [_topView layoutIfNeeded];
        
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT*0.6, SCREEN_WIDTH, SCREEN_HEIGHT *0.4);
    } completion:^(BOOL finished) {

        _topView.playBtn.hidden = NO;
        _topView.cancelBtn.hidden = NO;
    }];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changCurrentVC:)];
    [self.view addGestureRecognizer:pan];
}

- (instancetype)initWithimgOrginalFrame:(CGRect)imgOrginalFrame image:(UIImage *)image model:(FHSelectedModel *)model
{
    if(self = [super init]){
        _imgOrginalFrame = imgOrginalFrame;
        
        _model = model;
        _topView = [[VideoPlayView alloc] initWithFrame:imgOrginalFrame];
        _topView.delegate = self;
        _topView.imageView.image = image;
        [self.view addSubview:_topView];
        
        _bottomView = [[VideoPlayInfoView alloc] initWithFrame:imgOrginalFrame style:UITableViewStylePlain model:model];
        [self.view insertSubview:_bottomView belowSubview:_topView];
        
        [self _setUI];
    }
    return self;
}

- (void)_setUI
{
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgImageView.image = _topView.imageView.image;
    [self.view insertSubview:_bgImageView atIndex:0];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualView.frame = _bgImageView.bounds;
    [self.view insertSubview:visualView atIndex:1];
}

#pragma mark - videoPlayViewDelegate
- (void)playVideo
{
    VideoPlayViewController *playVC = [[VideoPlayViewController alloc] init];
    playVC.UrlString = _model.playUrl;
    playVC.titleStr = _model.title;
    playVC.duration = [_model.duration floatValue];
    [self showDetailViewController:playVC sender:nil];
}

- (void)videoPlayViewCancel
{
    _topView.playBtn.hidden = YES;
    _topView.cancelBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _topView.frame = _imgOrginalFrame;
        [_topView layoutIfNeeded];
        _bottomView.frame = _imgOrginalFrame;
    } completion:^(BOOL finished) {
        
        UIViewController *VC = self.parentViewController;
        [VC setNeedsStatusBarAppearanceUpdate];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - 手势
- (void)changCurrentVC:(UIPanGestureRecognizer *)sender
{
    
    NSLog(@"拖动了");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
