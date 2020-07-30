//
//  ZZMineViewController.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZMineViewController.h"
#import "ZZLoginViewController.h"

#import "ZZArchitectureDemo-Swift.h"

@interface ZZMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;

@end

@implementation ZZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航栏为透明，并根据当前tableView的偏移量设置对应的 alpha
    self.navigationController.navigationBar.translucent = YES;
    [self setNavigationBarColorWithOffsetY:self.tableView.contentOffset.y];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 设置导航栏 为不透明
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.subviews[0].alpha = 1.0;
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MyTestViewController *textVC = [MyTestViewController new];
    
    [self.navigationController pushViewController:textVC animated:true];
    
    
#if 0
    
    ZZLoginViewController *vc = [[ZZLoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
#endif
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        [self setNavigationBarColorWithOffsetY:offsetY];
    }
}
// 界面滑动时导航栏随偏移量 实时变化
- (void)setNavigationBarColorWithOffsetY:(CGFloat)offsetY {
    UIImageView *backView = self.navigationController.navigationBar.subviews[0];
    if (offsetY <= 0) {
        backView.alpha = 0;
    } else if (offsetY > 0 && offsetY < kTopBarHeight) {
        backView.alpha = offsetY / kTopBarHeight;
    } else if (offsetY >= kTopBarHeight ) {//&& offsetY <= NavBar_HEIGHT + 30
        backView.alpha = 1;
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
