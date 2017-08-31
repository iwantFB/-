//
//  VideoPlayView.m
//  openeyes
//
//  Created by YSmac1 on 16/10/14.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "VideoPlayView.h"

@implementation VideoPlayView

@synthesize cancelBtn = cancelBtn;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self _setTopViewUI];
    }
    return self;
}

- (void)_setTopViewUI
{
    self.backgroundColor = [UIColor redColor];
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    self.clipsToBounds = YES;
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 10, 44, 44);
    [cancelBtn setImage:[UIImage imageNamed:@"btn_backdown_normal"] forState:UIControlStateNormal];
    cancelBtn.hidden = YES;
    [cancelBtn addTarget:self action:@selector(_cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.frame = CGRectMake(0, 0, 50, 50);
    _playBtn.center = self.center;
    [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    _playBtn.hidden = YES;
    [_playBtn addTarget:self action:@selector(_playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_playBtn];
    
    //设置放大的动画
    [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(showImage:) userInfo:nil repeats:YES];
    [self showImage:nil];
}

- (void)layoutSubviews
{
    _imageView.frame = self.bounds;
    _playBtn.center = self.center;
    [super layoutSubviews];
}

- (void)_cancelBtnAction:(UIButton *)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(videoPlayViewCancel)]){
        [_delegate videoPlayViewCancel];
    }
}

- (void)_playBtnAction:(UIButton *)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(playVideo)]){
        [_delegate playVideo];
    }
}

#pragma mark - 动画效果
- (void)showImage:(NSTimer *)timer
{
    [UIView animateWithDuration:6 animations:^{
//        if(CGAffineTransformIsIdentity(_imageView.transform)){
            _imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
//        }else{
            _imageView.transform = CGAffineTransformIdentity;
//        }
    }];
}

@end
