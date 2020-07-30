//
//  ZZBaseViewController.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZZBaseViewProtocol;

@protocol ZZBaseViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <ZZBaseViewProtocol>)viewModel;

- (void)zz_bindViewModel;
- (void)zz_addSubviews;
- (void)zz_layoutNavigation;
- (void)zz_getNewData;
- (void)recoverkeyboard;


@end
@interface ZZBaseViewController : UIViewController

//- (void)zz_bindViewModel;
//- (void)zz_addSubviews;
//- (void)zz_layoutNavigation;
//- (void)zz_getNewData;
//- (void)recoverkeyboard;

@end

NS_ASSUME_NONNULL_END
