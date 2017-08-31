//
//  FoundBannerModel.h
//  openeyes
//
//  Created by YSmac1 on 16/10/17.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "JSONModel.h"

@interface FoundBannerModel : JSONModel

@property (copy, nonatomic)NSString *image;

@property (copy, nonatomic)NSString *actionUrl;

@property (copy, nonatomic)NSString *title;

@property (assign, nonatomic)NSInteger shade;

@property (copy, nonatomic)NSString<Ignore> *imgUrl;


@end
