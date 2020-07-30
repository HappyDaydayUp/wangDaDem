//
//  ZZBaseTableViewController.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZBaseTableViewController : ZZBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;

@property(nonatomic ,strong)NSMutableArray *dataSource;

@end

NS_ASSUME_NONNULL_END
