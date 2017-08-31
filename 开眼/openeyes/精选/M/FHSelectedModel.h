//
//  FHSelectedModel.h
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "JSONModel.h"

@interface FHSelectedModel : JSONModel

@property (copy, nonatomic)NSString *title;

@property (copy, nonatomic)NSString *category;

@property (copy, nonatomic)NSString *duration;

@property (copy, nonatomic)NSString *coverForFeed;

@property (copy, nonatomic)NSString *playUrl;

@property (copy, nonatomic)NSString *model_description;

@property (strong, nonatomic)NSDictionary *consumption;

@end
