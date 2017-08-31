//
//  SelectedVCCell.m
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "SelectedVCCell.h"

@implementation SelectedVCCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
        
        _shadeImageView = [[UIImageView alloc] init];
        _shadeImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:MyChinFont size:15.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont systemFontOfSize:12.f];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_bgImageView];
        [self.contentView addSubview:_shadeImageView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_messageLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgImageView.frame = self.bounds;
    self.shadeImageView.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(5, self.bounds.size.height/2.0-20, self.bounds.size.width - 10, 30);
    self.messageLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+5, SCREEN_WIDTH, 25);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
