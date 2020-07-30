//
//  ZZBaseViewModel.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger{
    LSHeaderRefresh_HasMoreData = 1,
    LSHeaderRefresh_HasNoMoreData,
    LSFooterRefresh_HasMoreData,
    LSFooterRefresh_HasNoMoreData,
    LSRefreshError,
    LSRefreshUI,
} LSRefreshDataStatus;
@protocol ZZBaseViewModelProtocol <NSObject>

@optional
- (instancetype)initWithModel:(id)model;

/**
 * 初始化
 */
- (void)zz_initialize;
@end
@interface ZZBaseViewModel : NSObject
@property (nonatomic, assign) CGFloat rowHeight;//行高
/**获取消息列表的第一条数据，并对比*/
- (void)getSignalMessage;
//RACCommand
@property (nonatomic, strong) RACCommand *autoLoginCommand;
//RACSubject
@property (nonatomic, strong) RACSubject *pushSubject;

@property (nonatomic, strong) NSMutableArray *dataSource;//数据源

- (void)requestData;




@end

NS_ASSUME_NONNULL_END
