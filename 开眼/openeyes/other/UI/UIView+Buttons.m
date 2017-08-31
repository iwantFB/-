//
//  UIView+Buttons.m
//  openeyes
//
//  Created by YSmac1 on 16/10/17.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "UIView+Buttons.h"
#import <objc/runtime.h>
const char *btnBlockKey = "btnBlockKey";

const char *lineViewKey = "lineViewKey";

@implementation UIView (Buttons)

- (void)addBButtonsWithimages:(NSArray *)images titles:(NSArray *)titles btnClick:(btnClickBlock)block
{
    if(CGRectEqualToRect(self.frame, CGRectZero)){
        NSLog(@"设置frame值");
        return ;
    }
    objc_setAssociatedObject(self, btnBlockKey, block, OBJC_ASSOCIATION_COPY);
    [self createButtonsWithImages:images titles:titles clear:NO];

}

- (void)createButtonsWithImages:(NSArray *)images titles:(NSArray *)titles clear:(BOOL)clear
{
    CGFloat btnWidth = CGRectGetWidth(self.frame)/(titles.count);
    CGFloat btnHeight = CGRectGetHeight(self.frame);
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*btnWidth, 0,btnWidth,btnHeight);
        [btn setImage:images[i] forState:UIControlStateNormal];
        if(!clear) [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.tag = 38784783+i;
    }
    
    if(clear){
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self insertSubview:lineView atIndex:0];
        
        objc_setAssociatedObject(self, lineViewKey, lineView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)btnAction:(UIButton *)sender
{
    
    UIView *lineView = objc_getAssociatedObject(self, lineViewKey);
    btnClickBlock block = objc_getAssociatedObject(self, btnBlockKey);
    [UIView animateWithDuration:0.3 animations:^{
        lineView.center = sender.center;
    }];
    if(block) block(sender,sender.tag-38784783);
}

#pragma mark - 创建指示
- (void)addButtonWithTitle:(NSArray *)titles font:(UIFont *)font btnClick:(btnClickBlock)block
{
    objc_setAssociatedObject(self, btnBlockKey, block, OBJC_ASSOCIATION_COPY);
    [self createBtnWithTitles:titles font:font];
}

- (void)createBtnWithTitles:(NSArray *)titles font:(UIFont *)font
{
    CGFloat labelW = SCREEN_WIDTH/(titles.count);
    CGFloat labelH = CGRectGetHeight(self.frame);
    
    for (int i = 0; i < titles.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelW * i, 0, labelW, labelH)];
        label.text = titles[i];
        label.font = font;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    
    [self createButtonsWithImages:nil titles:titles clear:YES];
}

@end
