//
//  ZZLoadConfiguration.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZLoadConfiguration.h"
@implementation ZZLoadConfiguration
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] ls_setHUDStyle];
        [[self class] initCoreData];
    });
}

#pragma mark --- 初始化提示框风格 ---
+ (void)ls_setHUDStyle {
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setInfoImage:nil];
}
#pragma mark --- 初始化coredata ---
+ (void)initCoreData{
    
}


@end
