//
//  VideoInfoCell.h
//  openeyes
//
//  Created by YSmac1 on 16/10/17.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^moreInfoBlock)();

@interface VideoInfoCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLable;

@property (strong, nonatomic)UILabel *messageLable;

@property (assign, nonatomic)moreInfoBlock block;

@end
