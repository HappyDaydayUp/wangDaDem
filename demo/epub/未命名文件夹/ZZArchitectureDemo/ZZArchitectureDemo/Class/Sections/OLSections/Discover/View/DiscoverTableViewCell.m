//
//  DiscoverTableViewCell.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/7.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "DiscoverTableViewCell.h"
@interface DiscoverTableViewCell()

@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)UIImageView *icon;
@property(nonatomic ,strong)UIImageView *arrow;


@end
@implementation DiscoverTableViewCell

-(void)setupUI{
    [super setupUI];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.arrow];
    
    
    @weakify(self)
    [RACObserve(self, showModel) subscribeNext:^(DiscoverListModel  *x) {
        
        @strongify(self)
        
        
        self.icon.image = [UIImage imageNamed:x.img];
        self.nameLabel.text = x.name;
        self.arrow.image = [UIImage imageNamed:@"mine_arrow"];
        
        [self.topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_offset(0);
            make.left.mas_offset(x.topLine==1?15:0);
            make.height.mas_equalTo(x.topLine==1?0.25:0.5);
        }];

        [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_offset(0);
            make.left.mas_offset(x.bottomLine==1?15:0);
            make.height.mas_equalTo(x.bottomLine==1?0.25:0.5);
        }];
        
    }];
    
    
    //    RAC(_icon, image) = [RACObserve(self, showModel) map:^id _Nullable(DiscoverListModel * _Nullable value) {
    //        return [UIImage imageNamed:value.img];
    //    }];
    
}
-(void)setShowModel:(DiscoverListModel *)showModel{
    _showModel = showModel;
}
-(void)setConsrains{
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(50);
        make.centerY.mas_offset(0);
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_offset(0);
    }];
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.mas_offset(0);
    }];
    
    
}



#pragma mark --- lazy ---
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
    }
    return _nameLabel;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}
-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow = [[UIImageView alloc]init];
    }
    return _arrow;
}
@end
