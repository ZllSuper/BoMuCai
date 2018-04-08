//
//  PersonCenterOrderStatueView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PersonCenterOrderStatueView.h"

@implementation OrderStatueControl
- (instancetype)init
{
    if (self = [super init])
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.iconImageView];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_centerY).offset(-5);
            make.centerX.mas_equalTo(self);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_centerY).offset(5);
            make.centerX.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - get
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font_sys_12;
        _titleLabel.textColor = Color_MainText;
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

@end

@implementation PersonCenterOrderStatueView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.waitPayBtn];
        [self addSubview:self.waitSendBtn];
        [self addSubview:self.waitReceiveBtn];
        [self addSubview:self.backGoodsBtn];
        [self addSubview:self.allBtn];
        
        [self.waitPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.bottom.mas_equalTo(self);
        }];
        
        [self.waitSendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.waitPayBtn);
            make.top.and.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self.waitPayBtn.mas_right);
        }];
        
        [self.waitReceiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.waitSendBtn);
            make.top.and.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self.waitSendBtn.mas_right);
        }];
        
        [self.backGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.waitReceiveBtn);
            make.top.and.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self.waitReceiveBtn.mas_right);
        }];
        
        [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.backGoodsBtn);
            make.top.and.bottom.and.right.mas_equalTo(self);
            make.left.mas_equalTo(self.backGoodsBtn.mas_right);
        }];
    }
    return self;
}

#pragma mark - get
- (OrderStatueControl *)waitPayBtn
{
    if (!_waitPayBtn)
    {
        _waitPayBtn = [[OrderStatueControl alloc] init];
        _waitPayBtn.titleLabel.text = @"待付款";
        _waitPayBtn.iconImageView.image = ImageWithName(@"PCOrderStatueIcon1");
    }
    return _waitPayBtn;
}

- (OrderStatueControl *)backGoodsBtn
{
    if (!_backGoodsBtn)
    {
        _backGoodsBtn = [[OrderStatueControl alloc] init];
        _backGoodsBtn.titleLabel.text = @"退货订单";
        _backGoodsBtn.iconImageView.image = ImageWithName(@"PCOrderStatueIcon4");
    }
    return _backGoodsBtn;
}

- (OrderStatueControl *)waitSendBtn
{
    if (!_waitSendBtn)
    {
        _waitSendBtn = [[OrderStatueControl alloc] init];
        _waitSendBtn.titleLabel.text = @"待发货";
        _waitSendBtn.iconImageView.image = ImageWithName(@"PCOrderStatueIcon2");
    }
    return _waitSendBtn;
}

- (OrderStatueControl *)waitReceiveBtn
{
    if (!_waitReceiveBtn)
    {
        _waitReceiveBtn = [[OrderStatueControl alloc] init];
        _waitReceiveBtn.titleLabel.text = @"待收货";
        _waitReceiveBtn.iconImageView.image = ImageWithName(@"PCOrderStatueIcon3");
    }
    return _waitReceiveBtn;
}

- (OrderStatueControl *)allBtn
{
    if (!_allBtn)
    {
        _allBtn = [[OrderStatueControl alloc] init];
        _allBtn.titleLabel.text = @"全部订单";
        _allBtn.iconImageView.image = ImageWithName(@"PCOrderStatueIcon5");
    }
    return _allBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
