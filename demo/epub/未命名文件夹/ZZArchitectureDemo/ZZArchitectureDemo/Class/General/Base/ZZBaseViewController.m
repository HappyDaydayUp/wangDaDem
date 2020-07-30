//
//  ZZBaseViewController.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZBaseViewController.h"

@interface ZZBaseViewController ()

@end

@implementation ZZBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    ZZBaseViewController *viewController = [super allocWithZone:zone];
    @WeakObj(viewController)

    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        @StrongObj(viewController)
        [viewController zz_addSubviews];
         [viewController zz_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(RACTuple * _Nullable x) {
           @StrongObj(viewController)
           [viewController zz_layoutNavigation];
            [viewController zz_getNewData];
       }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<ZZBaseViewProtocol>)viewModel{
    if (self == [super init]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];

}
- (void)zz_bindViewModel{}
- (void)zz_addSubviews{
}
- (void)zz_layoutNavigation{
//    self.navigationController.navigationBar.translucent=YES;
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.subviews[0].alpha = 0;
//  self.navigationController.navigationBar.tintColor = [UIColor redColor];//返回箭头颜色
//    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];//背景颜色
//    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];

//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};//标题颜色
//    self.navigationController.navigationBar.translucent = YES;//透明
//[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kYCLCyanColor] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];//取出导航栏下放横线
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];//取出返回键后面的字


//
}
- (UIImage*)createImageWithColor: (UIColor*) color

{

CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);

UIGraphicsBeginImageContext(rect.size);

CGContextRef context = UIGraphicsGetCurrentContext();

CGContextSetFillColorWithColor(context, [color CGColor]);

CGContextFillRect(context, rect);

UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();

UIGraphicsEndImageContext();

return theImage;

}

- (void)zz_getNewData{}
- (void)recoverkeyboard{}



@end
