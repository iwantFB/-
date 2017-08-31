//
//  NetWorkingTool.m
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "NetWorkingTool.h"
#import "AFHTTPSessionManager.h"

static AFHTTPSessionManager *manager;
@implementation NetWorkingTool

+ (AFHTTPSessionManager *)netWorkManager
{
    if(!manager){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
            
            // 设置超时时间
            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            manager.requestSerializer.timeoutInterval = 10.f;
            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
        });
    }
    return manager;
}

+ (void)requestDataWithUrl:(NSString * )url parameters:(NSDictionary *)parameters sucess:(_Nonnull successBlock)success fail:(_Nonnull failBlock)fail;
{
        [[NetWorkingTool netWorkManager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

@end
