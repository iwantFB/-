//
//  FoundCollectionReusableHeaderView.m
//  openeyes
//
//  Created by YSmac1 on 16/10/18.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "FoundCollectionReusableHeaderView.h"
#import "YGBanner.h"

@implementation FoundCollectionReusableHeaderView
{
    YGBanner *_banner;
}
- (void)prepareForReuse
{
    [super prepareForReuse];
     _banner = [[YGBanner alloc] initWithFrame:self.bounds imageHandle:^(NSInteger index) {
        if(_delegate && [_delegate respondsToSelector:@selector(foundCollectionReusableHeaderView:didCilckImageindex:)]){
            [_delegate foundCollectionReusableHeaderView:self didCilckImageindex:index];
        }
    }];
    [self addSubview:_banner];
}

- (void)setDataArr:(NSArray *)dataArr
{
    if(_dataArr != dataArr){
        _dataArr = [dataArr copy];
        [_banner reloadYGBanner:_dataArr];
    }
}

@end
