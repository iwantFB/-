//
//  UIView+Buttons.h
//  openeyes
//
//  Created by YSmac1 on 16/10/17.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClickBlock)(UIButton *sender, NSInteger tag);

@interface UIView (Buttons)

- (void)addBButtonsWithimages:(NSArray *)images titles:(NSArray *)titles btnClick:(btnClickBlock)block;

- (void)addButtonWithTitle:(NSArray *)titles font:(UIFont *)font btnClick:(btnClickBlock)block;

@end
