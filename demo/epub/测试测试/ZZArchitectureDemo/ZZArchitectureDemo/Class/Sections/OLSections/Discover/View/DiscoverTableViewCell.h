//
//  DiscoverTableViewCell.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "DiscoverListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DiscoverTableViewCell : BaseTableViewCell

@property (nonatomic, strong) DiscoverListModel *showModel;


@end

NS_ASSUME_NONNULL_END
