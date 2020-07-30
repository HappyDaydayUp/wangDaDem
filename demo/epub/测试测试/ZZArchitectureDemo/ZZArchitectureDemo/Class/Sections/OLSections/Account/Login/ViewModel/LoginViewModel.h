//
//  LoginViewModel.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/8.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) RACSignal *btnEnableSignal;
@property (nonatomic, strong) RACCommand *loginCommand;
@end

NS_ASSUME_NONNULL_END
