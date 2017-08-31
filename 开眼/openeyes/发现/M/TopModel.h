//
//  TopModel.h
//  openeyes
//
//  Created by YSmac1 on 16/10/19.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "JSONModel.h"

@interface TopModel : JSONModel

@property (copy, nonatomic)NSString *title;

@property (copy, nonatomic)NSString *category;

@property (copy, nonatomic)NSString *duration;

@property (copy, nonatomic)NSString *playUrl;

@property (copy, nonatomic)NSString *model_description;

@property (strong, nonatomic)NSDictionary *consumption;

@property (strong, nonatomic)NSDictionary *cover;

@end
