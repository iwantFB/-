//
//  MBPrograssTool.h
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;

@interface MBPrograssTool : NSObject

+ (void)showAlertWithStatus:(NSString *)status;

//隐藏所有
+ (void)hideAllHub;
@end
