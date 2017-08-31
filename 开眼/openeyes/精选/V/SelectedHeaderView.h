//
//  SelectedHeaderView.h
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectedHeaderViewDelegate <NSObject>

- (void)selectedViewDidTouched;

- (void)selectedViewSearchBtnDidTouched;

@end

@interface SelectedHeaderView : UIView

@property (strong, nonatomic)UIImageView *bgImageView;

@property (strong, nonatomic)UIImageView *centerImageView;

@property (strong, nonatomic)UILabel *refreshLabel;

@property (strong, nonatomic)CAGradientLayer *shadeLayer;

@property (weak, nonatomic)id<SelectedHeaderViewDelegate>deleagate;

@end
