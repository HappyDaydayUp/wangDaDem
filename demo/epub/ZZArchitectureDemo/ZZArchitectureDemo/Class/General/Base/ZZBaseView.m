//
//  ZZBaseView.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZBaseView.h"
#import "AppDelegate.h"
@implementation ZZBaseView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self zz_setupViews];
        [self zz_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id <ZZBaseViewProtocol>)viewModel{
    self = [super init];
    if (self) {
        [self zz_setupViews];
        [self zz_bindViewModel];
    }
    return self;
}
- (void)zz_bindViewModel{}
- (void)zz_setupViews{}
- (void)zz_addRouternKeyBoard{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}
@end
