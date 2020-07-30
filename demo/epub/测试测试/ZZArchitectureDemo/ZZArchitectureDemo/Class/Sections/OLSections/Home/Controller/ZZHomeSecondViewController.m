//
//  ZZHomeViewController.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZHomeSecondViewController.h"
#import <JXPagingView/JXPagerView.h>
#import <JXCategoryView/JXCategoryView.h>
#import "ZYTeamplayerHeadView.h"
#import "ZZContentSecondViewController.h"

// 菜单项View高
#define JXheightForHeaderInSection 40

@interface ZZHomeSecondViewController ()< JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic,strong) JXCategoryTitleView *categoryView;
@property (nonatomic,strong) JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,copy) NSArray *itemArr;
@property (nonatomic, strong) NSMutableArray              *viewControllers;

@end

@implementation ZZHomeSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"sencond";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kTopBarHeight,kScreenWidth, JXheightForHeaderInSection)];
    self.categoryView.delegate = self;
    [self.view addSubview:self.categoryView];
    self.categoryView.titles = self.itemArr;
    self.categoryView.titleColorGradientEnabled = YES;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor redColor];
    lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    
    self.listContainerView.frame = CGRectMake(0, kTopBarHeight + JXheightForHeaderInSection, kScreenWidth, kScreenHeight - (kTopBarHeight + JXheightForHeaderInSection));
    self.listContainerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.listContainerView];
    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.listContainerView;
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
}


#pragma mark - JXCategoryViewDelegate
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

//点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
}

//滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index{
}

//正在滚动中的回调
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio{
}
//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.itemArr.count;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return self.viewControllers[index];
}
/**
 菜单项标题数组
 */
-(NSArray *)itemArr{
    if(!_itemArr){
        _itemArr=@[@"球员1",@"球员2",@"球员3",@"球员4",@"球员5",@"球员6",@"球员7",@"球员8"];
     
        [_itemArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"111%@",obj);
            [self.viewControllers addObject:[[ZZContentSecondViewController alloc]init]];

            if (idx == _itemArr.count - 1) {
                *stop = YES;
            }
        }];
    }
    return _itemArr;
}
-(NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}
@end
