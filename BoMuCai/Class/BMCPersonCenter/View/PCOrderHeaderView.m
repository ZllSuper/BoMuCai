//
//  PCOrderHeaderView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderHeaderView.h"

@implementation PCOrderHeaderView

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
        [self addSubview:self.statueLabel];
        
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
            make.centerY.mas_equalTo(self);
        }];
        
        [self.statueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-16);
            make.centerY.mas_equalTo(self);
        }];
        
        [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
            make.centerY.mas_equalTo(self);
            make.right.mas_lessThanOrEqualTo(self.statueLabel.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(7.5, 13.5));
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
        _iconImageView.image = ImageWithName(@"ShopBottomActivity");
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
        [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
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

- (UILabel *)statueLabel
{
    if (!_statueLabel)
    {
        _statueLabel = [[UILabel alloc] init];
        _statueLabel.font = Font_sys_14;
        _statueLabel.textColor = Color_Main_Dark;
        _statueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _statueLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
