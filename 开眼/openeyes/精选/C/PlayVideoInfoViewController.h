//
//  PlayVideoInfoViewController.h
//  openeyes
//
//  Created by YSmac1 on 16/10/14.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHSelectedModel;

@interface PlayVideoInfoViewController : UIViewController

@property (nonatomic)CGRect imgOrginalFrame;

@property (nonatomic, strong)NSArray *allDataArr;

- (instancetype)initWithimgOrginalFrame:(CGRect)imgOrginalFrame image:(UIImage *)image model:(FHSelectedModel *)model;

@end
