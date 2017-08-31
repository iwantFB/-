//
//  VideoInfoCell.m
//  openeyes
//
//  Created by YSmac1 on 16/10/17.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "VideoInfoCell.h"

@implementation VideoInfoCell
{
    UIButton *_moreInfoBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self _setupUI];
    }
    return self;
}

- (void)_setupUI
{
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 54, 18)];
    _titleLable.font = [UIFont boldSystemFontOfSize:17];
    _titleLable.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLable];
    
    _messageLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 38, SCREEN_WIDTH-54, 13)];
    _messageLable.font = [UIFont systemFontOfSize:12];
    _messageLable.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_messageLable];
    
    _moreInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreInfoBtn setImage:[UIImage imageNamed:@"btn_backdown_normal"] forState:UIControlStateNormal];
    [_moreInfoBtn addTarget:self action:@selector(moreInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreInfoBtn];
}

- (void)moreInfoBtnAction:(UIButton *)sender
{
    if(_block) _block();
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _moreInfoBtn.frame = CGRectMake(SCREEN_WIDTH-54, 8, 44, 44);
}


@end
