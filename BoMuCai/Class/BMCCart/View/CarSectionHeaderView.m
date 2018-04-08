//
//  CarSectionHeaderView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarSectionHeaderView.h"

@implementation CarSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = Color_White;
        
        UIControl *control = [self backActionControl];
        
        [self addSubview:control];
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightArrow];
        
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.size.mas_equalTo(CGSizeMake(16, 14));
            make.centerY.mas_equalTo(self);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
            make.centerY.mas_equalTo(self);
        }];
        
        [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-16);
            make.centerY.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - action
- (void)actionControlAction
{
    [self.delegate headerViewDidSelectAction:self];
}

#pragma mark - get
- (void)setWeakModel:(CarShopModel *)weakModel
{
    _weakModel = weakModel;
    self.titleLabel.text = weakModel.shopName;

}

- (UIControl *)backActionControl
{
    UIControl *actionControl = [[UIControl alloc] init];
    [actionControl addTarget:self action:@selector(actionControlAction) forControlEvents:UIControlEventTouchUpInside];
    return actionControl;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = ImageWithName(@"PCSectionIcon");
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font_sys_15;
        _titleLabel.textColor = Color_MainText;
    }
    return _titleLabel;
}

- (UIImageView *)rightArrow
{
    if (!_rightArrow)
    {
        _rightArrow = [[UIImageView alloc] init];
        _rightArrow.image = ImageWithName(@"RightArrow");
    }
    return _rightArrow;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
