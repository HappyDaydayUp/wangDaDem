//
//  DisCoverViewController.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "DisCoverViewController.h"
#import "DiscoverViewModel.h"
#import "DiscoverTableViewCell.h"
@interface DisCoverViewController ()
@property(nonatomic ,strong)DiscoverViewModel *vm;
@end

@implementation DisCoverViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self.vm loadData];

    //注册cell
    [self.tableView registerClass:[DiscoverTableViewCell class] forCellReuseIdentifier:@"cellID"];

}



#pragma mark --- table代理 ---
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return self.vm.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.vm.dataSource[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor secondarySystemBackgroundColor];
    cell.showModel = self.vm.dataSource[indexPath.section][indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

#pragma mark --- lazy ---
- (DiscoverViewModel *)vm{
    if (!_vm){
        _vm = [[DiscoverViewModel alloc] init];
    }
    return _vm;
}


@end
