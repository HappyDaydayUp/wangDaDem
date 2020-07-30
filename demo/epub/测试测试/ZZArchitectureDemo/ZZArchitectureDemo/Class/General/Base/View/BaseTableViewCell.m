//
//  BaseTableViewCell.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setConsrains];
    }
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.bottomLine];
}
-(void)setConsrains{}


-(void)setModel:(BaseModel* )model{
    _model = model;
}
-(UIView *)topLine{
    if (!_topLine) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = [UIColor systemGrayColor];
    }
    return _topLine;
}
-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor systemGrayColor];
    }
    return _bottomLine;
}
@end

