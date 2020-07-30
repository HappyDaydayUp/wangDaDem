//
//  ZZBaseView.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZZBaseViewControllerProtocol;

@protocol ZZBaseViewProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <ZZBaseViewProtocol>)viewModel;
- (void)zz_bindViewModel;
- (void)zz_setupViews;
- (void)zz_addRouternKeyBoard;
@end
@interface ZZBaseView : UIView

@end

NS_ASSUME_NONNULL_END
