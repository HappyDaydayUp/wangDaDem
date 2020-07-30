//
//  ZZContentViewController.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZContentViewController.h"
#import "ZZHomeSecondViewController.h"
@interface ZZContentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

@implementation ZZContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];

  
}
#pragma mark --- <UITableViewDelegate,UITableViewDataSource> ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell + %ld",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZHomeSecondViewController *vc =[[ZZHomeSecondViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- 懒加载 ---
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight - KBottomBarHeight - 40)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        if (@available(iOS 11.0, *)) {
        //            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        ////            self.tableView.estimatedRowHeight =44;
        ////            self.tableView.estimatedSectionHeaderHeight = 0;
        ////            self.tableView.estimatedSectionFooterHeight = 0;
        ////            self.tableView.rowHeight = UITableViewAutomaticDimension;
        //        }
        //        else {
        //            self.automaticallyAdjustsScrollViewInsets = NO;
        ////            self.tableView.estimatedRowHeight = 44;
        ////            self.tableView.estimatedSectionHeaderHeight = 0;
        ////            self.tableView.estimatedSectionFooterHeight = 0;
        ////            self.tableView.rowHeight = UITableViewAutomaticDimension;
        //
        //        }
    }
    return _tableView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate
- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
@end

