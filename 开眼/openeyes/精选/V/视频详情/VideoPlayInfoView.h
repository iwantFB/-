//
//  VideoPlayInfoView.h
//  openeyes
//
//  Created by YSmac1 on 16/10/14.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHSelectedModel;

@interface VideoPlayInfoView : UITableView

@property (strong, nonatomic)FHSelectedModel *model;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style model:(FHSelectedModel *)model;

@end
