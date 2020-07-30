//
//  ZZBaseViewModel.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZBaseViewModel.h"

@implementation ZZBaseViewModel
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    ZZBaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel zz_initialize];
    }
    return viewModel;
}
- (instancetype)initWithModel:(id)model{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)requestData{
    //延时两秒模拟网咯请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
    });
}

/**
 * 初始化
 */
- (void)zz_initialize{}
@end
