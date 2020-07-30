//
//  JHCollectionReusableView.m
//  HiiN
//
//  Created by 张健华-迈动 on 2017/3/7.
//  Copyright © 2017年 huanli. All rights reserved.
//

#import "JHCollectionReusableView.h"
#import "JHCollectionViewLayoutAttributes.h"

@interface JHCollectionReusableView()


@property (nonatomic, strong) UIView *backView;

@end


@implementation JHCollectionReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self backViewLayout];
    }
    return self;
}




- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[JHCollectionViewLayoutAttributes class]]) {
        JHCollectionViewLayoutAttributes *attr = (JHCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
        
        NSLog(@"applyLayoutAttributes======>>>>>HJOPKKKK");
        
        CGFloat x = attr.edgeIndets.left;
        CGFloat y = attr.edgeIndets.top;
        CGFloat width = attr.frame.size.width - attr.edgeIndets.left - attr.edgeIndets.right;
        CGFloat heigth = attr.frame.size.height - attr.edgeIndets.top - attr.edgeIndets.bottom;
        
        self.backView.frame = CGRectMake(x, y, width, heigth);
        
    }
}


#pragma mark -- LayUI

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = UIColor.darkGrayColor;
    }
    
    return _backView;
}

- (void)backViewLayout {
    self.backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


@end
