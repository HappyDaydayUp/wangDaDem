//
//  DiscoverListModel.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DiscoverListModel : BaseModel

@property(nonatomic ,copy)NSString *name;
@property(nonatomic ,copy)NSString *img;
@property(nonatomic ,assign)int topLine;
@property(nonatomic ,assign)int bottomLine;

@end

NS_ASSUME_NONNULL_END
