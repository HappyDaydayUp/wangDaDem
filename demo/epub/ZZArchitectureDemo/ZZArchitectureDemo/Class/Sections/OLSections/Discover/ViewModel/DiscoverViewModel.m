//
//  DiscoverViewModel.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "DiscoverViewModel.h"
#import "DiscoverListModel.h"
@interface DiscoverViewModel()


@end
@implementation DiscoverViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)loadData{
    NSArray * array = @[
        @[
            @{@"name":@"朋友圈",@"img":@"mine_baoming",@"topLine":@"0",@"bottomLine":@"0"}
        ],
        @[
            @{@"name":@"扫一扫",@"img":@"mine_baoming",@"topLine":@"0",@"bottomLine":@"1"},
            @{@"name":@"摇一摇",@"img":@"mine_baoming",@"topLine":@"1",@"bottomLine":@"0"}
        ],
        @[
            @{@"name":@"看一看",@"img":@"mine_baoming",@"topLine":@"0",@"bottomLine":@"1"},
            @{@"name":@"搜一搜",@"img":@"mine_baoming",@"topLine":@"1",@"bottomLine":@"0"}
        ],
        @[
            @{@"name":@"附近的人",@"img":@"mine_baoming",@"topLine":@"0",@"bottomLine":@"0"}
        ],
        @[
            @{@"name":@"购物",@"img":@"mine_baoming",@"topLine":@"0",@"bottomLine":@"1"},
            @{@"name":@"游戏",@"img":@"mine_baoming",@"topLine":@"1",@"bottomLine":@"0"}
        ],
        @[
            @{@"name":@"小程序",@"img":@"mine_baoming",@"topLine":@"0",@"bottomLine":@"0"}
        ]
    ];
    [self.dataSource addObjectsFromArray:[DiscoverListModel mj_objectArrayWithKeyValuesArray:array]];
}

- (void)setUp{
    _command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"开始请求");
            
            NSLog(@"请求成功");
            
            NSLog(@"处理数据");
            
            [subscriber sendNext:@"请求完成，数据给你"];
            
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束了");
            }];
        }];
        
    }];
}


#pragma mark --- lazy ---
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
