//
//  AppDelegate.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/27.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "AppDelegate.h"
//#import "ModuleManager.h
#import "ZZRootViewController.h"
#import "ZZLoadConfiguration.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//+(void)load{
//     //load modules
//    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"ModulesRegister" ofType:@"plist"];
//    [[ModuleManager sharedInstance] loadModulesWithPlistFile:plistPath];
//    
//}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor clearColor];
        self.window.rootViewController = [[ZZRootViewController alloc]init];
        [self.window makeKeyAndVisible];
    return YES;
}




@end
