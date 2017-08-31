//
//  YGBanner.h
//  ScrollView循环滚到-2
//
//  Created by wuyiguang on 16/1/8.
//  Copyright (c) 2016年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGBannerModel : NSObject

//@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgUrl;

@end


typedef void(^imageHandle)(NSInteger index);


@interface YGBanner : UIView

//当前下标
@property (nonatomic, assign)NSInteger currIndex;

/**
 *  YGBanner实例方法
 */
- (instancetype)initWithFrame:(CGRect)frame imageHandle:(imageHandle)handle;
/**
 *  刷新轮播上的UI显示
 *
 *  @param models 传入YGBannerModel模型数组
 */
- (void)reloadYGBanner:(NSArray *)models;

//关闭定时器
- (void)stopTimer;

//重启定时器
- (void)startTimer;

//重设图片
- (void)reloadImageView;
@end
