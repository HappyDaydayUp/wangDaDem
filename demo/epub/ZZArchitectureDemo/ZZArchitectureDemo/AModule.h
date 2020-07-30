//
//  AModule.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/28.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AModule : NSObject<ModuleProtocol>
@property (strong, nonatomic) UIWindow * window;

@end

NS_ASSUME_NONNULL_END
