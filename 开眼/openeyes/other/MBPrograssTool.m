//
//  MBPrograssTool.m
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "MBPrograssTool.h"
#import "MBProgressHUD.h"
@implementation MBPrograssTool

+ (void)showAlertWithStatus:(NSString *)status
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    hud.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    hud.labelText = status;
    hud.removeFromSuperViewOnHide = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [hud show:YES];
}

+ (void)hideAllHub
{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
