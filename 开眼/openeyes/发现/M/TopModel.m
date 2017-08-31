//
//  TopModel.m
//  openeyes
//
//  Created by YSmac1 on 16/10/19.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "TopModel.h"

@implementation TopModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"model_description"}];
}

@end
