//
//  ModuleManager.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/27.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleProtocol.h"

@interface ModuleManager : NSObject

+ (instancetype)sharedInstance;

- (void)loadModulesWithPlistFile:(NSString *)plistFile;

- (NSArray<id<ModuleProtocol>> *)allModules;

@end
