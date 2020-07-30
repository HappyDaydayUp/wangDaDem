//
//  ZZRootViewController.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZRootViewController.h"
#import "ZZHomeViewController.h"
#import "ZZMineViewController.h"
#import "DisCoverViewController.h"
@interface ZZRootViewController ()


@end

@implementation ZZRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewControllers];
   
    [self configNav];
}
-(void)configNav{
    [UINavigationBar appearance].translucent = YES;
    [UINavigationBar appearance].barTintColor = [UIColor systemBackgroundColor];
    [UINavigationBar appearance].shadowImage = [UIImage new];//取出导航栏下放横线

}
/**
*  初始化所有的子控制器
*/
- (void)setupAllChildViewControllers
{
    // 1.首页
    ZZHomeViewController *home = [[ZZHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"ic_tab_fenlei" selectedImageName:@"ic_tab_fenlei_seleced"];
//   3.我的
    ZZMineViewController *mine1 = [[ZZMineViewController alloc] init];
    [self setupChildViewController:mine1 title:@"分类" imageName:@"ic_tab_wode" selectedImageName:@"ic_tab_wode_seleced"];
    DisCoverViewController *mine2 = [[DisCoverViewController alloc] init];
       [self setupChildViewController:mine2 title:@"发现" imageName:@"ic_tab_wode" selectedImageName:@"ic_tab_wode_seleced"];
    ZZMineViewController *mine3 = [[ZZMineViewController alloc] init];
       [self setupChildViewController:mine3 title:@"我的" imageName:@"ic_tab_wode" selectedImageName:@"ic_tab_wode_seleced"];
    
    
  
}

/**
*  初始化一个子控制器
*
*  @param childVc          需要初始化的子控制器

*  @param title            标题

*  @param imageName        图标

*  @param selectedImageName 选中的图标

*/
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;

    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];

    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = selectedImage;

    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];

}

@end
