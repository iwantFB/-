//
//  NetWorkingTool.h
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <Foundation/Foundation.h>

//失败后的回调
typedef void(^failBlock)(NSURLSessionDataTask *  task, NSError *  error);

//成功后的回调
typedef void(^successBlock)(NSURLSessionDataTask *  task, id   responseObject);

@interface NetWorkingTool : NSObject

+ (void)requestDataWithUrl:(NSString *)url parameters:(NSDictionary *)parameters sucess:( successBlock)success fail:( failBlock)fail;

@end
