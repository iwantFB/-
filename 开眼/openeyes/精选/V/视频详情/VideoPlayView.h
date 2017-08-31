//
//  VideoPlayView.h
//  openeyes
//
//  Created by YSmac1 on 16/10/14.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoPlayViewDelegate <NSObject>

//返回按钮
- (void)videoPlayViewCancel;

//播放按钮
- (void)playVideo;

@end

@interface VideoPlayView : UIView

@property (strong, nonatomic)UIImageView *imageView;

@property (strong, nonatomic)UIButton *playBtn;

@property (strong, nonatomic)UIButton *cancelBtn;

@property (weak, nonatomic)id<VideoPlayViewDelegate>delegate;

@end
