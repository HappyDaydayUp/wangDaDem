//
//  AModule.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/28.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "AModule.h"
#import "ViewController.h"
@implementation AModule
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    NSLog(@"AMOULDE");
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
      self.window.backgroundColor = [UIColor clearColor];
      ViewController *root = [[ViewController alloc]init];
      self.window.rootViewController = root;
      [self.window makeKeyAndVisible];
     return YES;
}

@end
