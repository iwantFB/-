//
//  VideoPlayInfoView.m
//  openeyes
//
//  Created by YSmac1 on 16/10/14.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "VideoPlayInfoView.h"
#import "VideoInfoCell.h"
#import "FHSelectedModel.h"
#import "UIView+Buttons.h"
@interface VideoPlayInfoView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation VideoPlayInfoView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style model:(FHSelectedModel *)model
{
    self = [super initWithFrame:frame style:style];
    if(self){
        
        self.model = model;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.tableFooterView = [self tableFooterView];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        VideoInfoCell *cell = [[VideoInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.titleLable.text = self.model.title;
        cell.messageLable.text = [NSString stringWithFormat:@"#%@ / %@",self.model.category,[self timeStrForDuration:_model.duration]];
        cell.block = ^(){
            NSLog(@"block调用");
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 100)];
    label.font = [UIFont systemFontOfSize:12.0];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    [cell.contentView addSubview:label];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.model.model_description];
    //设置段落
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 6;
    [str addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, [self.model.model_description length])];
    label.attributedText = str;
    [label sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (UIView *)tableFooterView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    NSDictionary *dict = self.model.consumption;
    NSArray *arr = [NSArray arrayWithObjects:
                    [UIImage imageNamed:@"collect"],
                    [UIImage imageNamed:@"upload"],
                    [UIImage imageNamed:@"btn_airplay_normal"],
                    [UIImage imageNamed:@"btn_download_normal@2x"], nil];
    NSArray *messageArr = [NSArray arrayWithObjects:
                           [NSString stringWithFormat:@"%@",dict[@"collectionCount"]],
                           [NSString stringWithFormat:@"%@",dict[@"shareCount"]],
                           [NSString stringWithFormat:@"%@",dict[@"replyCount"]],
                           [NSString stringWithFormat:@"%@",@"缓存"], nil];
    [bgView addBButtonsWithimages:arr titles:messageArr btnClick:^(UIButton *sender, NSInteger tag) {
        [self bottomBtnAction:sender];
    }];
    return bgView;
}

- (void)createButtonInsertSuperView:(UIView *)superView frame:(CGRect)frame title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:btn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 60;
    }else if (indexPath.row == 1){
        return SCREEN_HEIGHT*0.4-60-40;
    }
    return 0;
}

- (void)bottomBtnAction:(UIButton *)sender
{
    NSLog(@"点击的 - %ld",sender.tag);
}


- (NSString *)timeStrForDuration:(NSString *)duration
{
    CGFloat time = [duration floatValue];
    return [NSString stringWithFormat:@"%02d'%02d\"",(int)time/60,(int)time%60];
}

@end
