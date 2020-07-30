//
//  ZZHomeViewController.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZHomeViewController.h"
#import <JXPagingView/JXPagerView.h>
#import <JXCategoryView/JXCategoryView.h>
#import "ZYTeamplayerHeadView.h"
#import "ZZContentViewController.h"

#define JXTableHeaderViewHeight (kIs_iPhoneX?200+44:200)
// 菜单项View高
#define JXheightForHeaderInSection 40

@interface ZZHomeViewController ()<JXPagerViewDelegate, JXCategoryViewDelegate,JXPagerMainTableViewGestureDelegate,ZZBaseViewControllerProtocol>
/**
 顶部View（自定义View）
 */
@property (nonatomic,strong) ZYTeamplayerHeadView *teamplayerHeadV;
/**
 菜单项View
 */
@property (nonatomic,strong) JXCategoryTitleView *categoryView;
/**
 内容View
 */
@property (nonatomic, strong) JXPagerView *pagingView;

/**
 菜单项标题数组
 */
@property (nonatomic,copy) NSArray *itemArr;

@property (nonatomic, strong) NSMutableArray              *viewControllers;

@end

@implementation ZZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)zz_addSubviews{
    [self.view addSubview:self.pagingView];

}

#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.teamplayerHeadV;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}
- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView{
    return self.itemArr.count;
}


- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    ZZContentViewController *list = (ZZContentViewController*)self.viewControllers[index];
    return list;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}


- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    //计算偏移量
//    CGFloat P = scrollView.contentOffset.y/(JXTableHeaderViewHeight-kNavBarAndStatusBarHeight);
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index{
}

#pragma mark - JXPagerMainTableViewGestureDelegate
- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark 懒加载
/**
总视图
 */
-(JXPagerView *)pagingView{
    if(!_pagingView){
        _pagingView = [[JXPagerView alloc] initWithDelegate:self];
        _pagingView.frame = CGRectMake(0, kTopBarHeight, kScreenWidth, kScreenHeight-kTopBarHeight-KBottomBarHeight);
    }
    return _pagingView;
}
/**
 自定义头部视图
 */
-(ZYTeamplayerHeadView *)teamplayerHeadV{
    if(!_teamplayerHeadV){
        _teamplayerHeadV=[ZYTeamplayerHeadView new];
        [_teamplayerHeadV setFrame:CGRectMake(0, 0, kScreenWidth, JXTableHeaderViewHeight)];
        _teamplayerHeadV.backgroundColor = [UIColor yellowColor];
    }
    return _teamplayerHeadV;
}
/**
 菜单项视图View
 */
-(JXCategoryTitleView *)categoryView{
    if(!_categoryView){
        //
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, JXheightForHeaderInSection)];
        // dele
        _categoryView.delegate = self;
        // 设置菜单项标题数组
        _categoryView.titles = self.itemArr;
        // 背景色
        _categoryView.backgroundColor = [UIColor grayColor];
        // 标题色、标题选中色、标题字体、标题选中字体
        _categoryView.titleColor = kTitleColor;
        _categoryView.titleSelectedColor = kTintClolor;
        _categoryView.titleFont=kFont(16);
        _categoryView.titleSelectedFont=kFontBold(16);
        // 标题色是否渐变过渡
        _categoryView.titleColorGradientEnabled = YES;
        // 下划线
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        // 下划线颜色
        lineView.indicatorColor = kTintClolor;
        // 下划线宽度
        lineView.indicatorWidth = 35;
        _categoryView.indicators = @[lineView];
        // 联动（categoryView和pagingView）
        self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagingView.listContainerView;
        // 返回上一页侧滑手势（仅在index==0时有效）
//        self.navigationController.interactivePopGestureRecognizer.enabled = (_categoryView.selectedIndex == 0);
        _pagingView.pinSectionHeaderVerticalOffset = 0;//悬浮高度
        _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
    }
    return _categoryView;
}

/**
 菜单项标题数组
 */
-(NSArray *)itemArr{
    if(!_itemArr){
        _itemArr=@[@"球员",@"信息"];
        }
    return _itemArr;
}

-(NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
        ZZContentViewController *vc = [[ZZContentViewController alloc]init];
        ZZContentViewController *vc1 = [[ZZContentViewController alloc]init];
        [_viewControllers addObject:vc];
        [_viewControllers addObject:vc1];
    }
    return _viewControllers;
}
                        
@end
