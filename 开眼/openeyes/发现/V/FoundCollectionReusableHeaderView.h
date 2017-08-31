//
//  FoundCollectionReusableHeaderView.h
//  openeyes
//
//  Created by YSmac1 on 16/10/18.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FoundCollectionReusableHeaderViewDelegate <NSObject>

- (void)foundCollectionReusableHeaderView:(UIView *)headerView didCilckImageindex:(NSInteger)imageIndex;

@end

@interface FoundCollectionReusableHeaderView : UICollectionReusableView

@property (weak, nonatomic)id<FoundCollectionReusableHeaderViewDelegate>delegate;

@property (strong, nonatomic)NSArray *dataArr;

@end
