//
//  TopTenCell.m
//  openeyes
//
//  Created by YSmac1 on 16/10/19.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "TopTenCell.h"

@implementation TopTenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _rankView = [[UIView alloc] initWithFrame:CGRectZero];
        _rankView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_rankView];
        
        _rankLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rankLabel.font = [UIFont fontWithName:MyEnFontTwo size:13];
        _rankLabel.textColor = [UIColor whiteColor];
        _rankLabel.textAlignment = NSTextAlignmentCenter;
        _rankLabel.backgroundColor = [UIColor clearColor];
        [_rankView addSubview:_rankLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat selfH = CGRectGetHeight(self.bounds);
    _rankView.frame = CGRectMake(0, 0, 30, 20);
    _rankView.center = CGPointMake(self.center.x, selfH - 20 - 20);
    
    _rankLabel.frame = _rankView.bounds;
    
    //线条
    for (int i = 0; i < 2; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, i *  CGRectGetHeight(_rankView.bounds), CGRectGetWidth(_rankView.bounds), 1)];
        lineView.backgroundColor = [UIColor whiteColor];
        [_rankView addSubview:lineView];
    }
    
}


@end
