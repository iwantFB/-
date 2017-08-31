//
//  FoundCollectionViewCell.m
//  openeyes
//
//  Created by YSmac1 on 16/10/18.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "FoundCollectionViewCell.h"

@implementation FoundCollectionViewCell
{

}
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _cellImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_cellImageView];
    
    _maskView = [[UIView alloc] initWithFrame:CGRectZero];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
    [self.contentView addSubview:_maskView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 20)];
    _titleLabel.center = _maskView.center;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:14.f];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_maskView addSubview:_titleLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _cellImageView.frame = self.bounds;
    _maskView.frame = self.bounds;
    _titleLabel.center = _maskView.center;
    
        _longG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [self addGestureRecognizer:_longG];
}

#pragma mark - 隐藏mask手势
- (void)panGestureAction:(UIPanGestureRecognizer *)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            _maskView.hidden = YES;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            _maskView.hidden = NO;
            break;
        }
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
        {
            _maskView.hidden = NO;
            break;
        }
            
        default:
            break;
    }
}

@end
