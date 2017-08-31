//
//  FoundCollectionViewCell.h
//  openeyes
//
//  Created by YSmac1 on 16/10/18.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoundCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)UIImageView *cellImageView;

@property (strong, nonatomic)UILabel *titleLabel;

@property (strong, nonatomic)UIView *maskView;

@property (strong, nonatomic)UILongPressGestureRecognizer *longG;

@end
