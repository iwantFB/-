//
//  SelectedHeaderView.m
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "SelectedHeaderView.h"

@implementation SelectedHeaderView
{
    UIButton *searchBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.frame = self.bounds;
        
        _bgImageView.image = [UIImage imageNamed:@"Wallpaper.png"];
        [self insertSubview:_bgImageView atIndex:0];
        
        searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.frame = CGRectMake(SCREEN_WIDTH - 54.0, 10, 44, 44);
        [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:searchBtn];
        
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _centerImageView.center = self.center;
        _centerImageView.backgroundColor = [UIColor greenColor];
        [self addSubview:_centerImageView];
        
        _refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
        _refreshLabel.center = CGPointMake(self.center.x, CGRectGetHeight(frame) - 20 - 7.5);
        _refreshLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        _refreshLabel.text = [self createTimeStr];
        _refreshLabel.textAlignment = NSTextAlignmentCenter;
        _refreshLabel.backgroundColor = [UIColor clearColor];
        _refreshLabel.textColor = [UIColor whiteColor];
        _refreshLabel.font = [UIFont fontWithName:MyEnFontTwo size:14];
        [self addSubview:_refreshLabel];
        
        _shadeLayer = [CAGradientLayer layer];
        _shadeLayer.frame = self.bounds;
        _shadeLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
        _shadeLayer.opacity = 0;
        [self.layer addSublayer:_shadeLayer];
    }
    return self;
}

- (NSString *)createTimeStr
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM.dd";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSString *str = [NSString stringWithFormat:@"- %ld, %@-",(long)comp.weekday,[formatter stringFromDate:date]];
    return str;
}

- (void)searchBtnAction:(UIButton *)btn
{
    if(_deleagate && [_deleagate respondsToSelector:@selector(selectedViewSearchBtnDidTouched)]){
        [_deleagate selectedViewSearchBtnDidTouched];
    }
}

@end
