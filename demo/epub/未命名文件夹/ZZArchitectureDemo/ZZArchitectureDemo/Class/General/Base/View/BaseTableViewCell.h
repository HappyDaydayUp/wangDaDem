//
//  BaseTableViewCell.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell


@property(nonatomic ,strong)UIView *topLine;
@property(nonatomic ,strong)UIView *bottomLine;


@property(nonatomic ,strong)BaseModel* model;

/// 设置子UI
-(void)setupUI;

/// 布局子UI
-(void)setConsrains;

@end

NS_ASSUME_NONNULL_END
