//
//  DiscoverViewModel.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiscoverViewModel : NSObject
@property (nonatomic, strong) RACCommand *command;

@property (nonatomic, strong) NSMutableArray *dataSource;


-(void)loadData;
@end

NS_ASSUME_NONNULL_END
