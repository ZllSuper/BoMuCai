//
//  CarOrderInputFooterView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarOrderInputFooterView.h"

@implementation OrderInputCouponFooter

- (instancetype)init
{
    if (self = [super init])
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.couponLabel];
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:ImageWithName(@"RightArrow")];
        [self addSubview:arrow];
        
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-16);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(16);
        }];
        
        [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(arrow.mas_left).offset(-16);
        }];
    }
    return self;
}

#pragma mark - set / get
- (void)setShowCoupon:(BOOL)showCoupon
{
    _showCoupon = showCoupon;
    if (showCoupon)
    {
        self.couponLabel.textColor = Color_MainText;
    }
    else
    {
        self.couponLabel.textColor = Color_Text_LightGray;
    }
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font_sys_14;
        _titleLabel.textColor = Color_MainText;
        _titleLabel.text = @"优惠券";
    }
    return _titleLabel;
}

- (UILabel *)couponLabel
{
    if (!_couponLabel)
    {
        _couponLabel = [[UILabel alloc] init];
        _couponLabel.font = Font_sys_14;
        _couponLabel.textAlignment = NSTextAlignmentRight;
        _couponLabel.textColor = Color_Text_LightGray;
        _couponLabel.text = @"未使用";
    }
    return _couponLabel;
}

@end

@implementation CarOrderInputFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = Color_White;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.frePriceLabel];
        [self addSubview:self.couponView];
        [self addSubview:self.countLabel];
        [self addSubview:self.tipLabel];
        [self addSubview:self.totalPriceLabel];
        [self addSubview:self.frePriceSecLabel];
        
        UIView *lineView = [self lineView];
        UIView *midLine = [self lineView];
        UIView *bottomLine = [self bottomLineView];
        [self addSubview:lineView];
        [self addSubview:midLine];
        [self addSubview:bottomLine];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.top.mas_equalTo(self).offset(10);
        }];
        
        [self.frePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-16);
            make.centerY.mas_equalTo(self.titleLabel);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo(0.7);
        }];
        
        [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(self);
            make.top.mas_equalTo(lineView.mas_bottom);
            make.height.mas_equalTo(@40);
        }];
        
        [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.couponView.mas_bottom);
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo(0.7);
        }];
        
        [self.frePriceSecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-16);
            make.top.mas_equalTo(midLine.mas_bottom).offset(10);
            make.height.mas_equalTo(self.tipLabel);
        }];
        
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.frePriceSecLabel.mas_left);
            make.top.mas_equalTo(midLine.mas_bottom).offset(10);
            make.height.mas_equalTo(self.totalPriceLabel);
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.totalPriceLabel.mas_left);
            make.centerY.mas_equalTo(self.totalPriceLabel);
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.tipLabel.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.tipLabel);
        }];
        
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(10);
        }];
        
    }
    return self;
}

#pragma mark - action
- (void)couponViewAction
{
    if (self.actionProtcol)
    {
        [self.actionProtcol footerViewCouponAction:self];
    }
}

#pragma mark - get / set
- (void)setShopModel:(CarShopModel *)shopModel
{
    _shopModel = shopModel;
    NSString *fre = _StrFormate(@"%ld",(long)shopModel.totalYunFei);
    self.frePriceLabel.text = _StrFormate(@"￥%@",MoneyDeal(fre));
    self.countLabel.text = _StrFormate(@"共计%ld件宝贝",(long)shopModel.buyNum);
    NSInteger prc = shopModel.totalPrice+shopModel.totalYunFei;
    NSString *price = _StrFormate(@"%ld",(long)prc);
    self.totalPriceLabel.text = _StrFormate(@"￥%@",MoneyDeal(price));
    if (shopModel.couponModel)
    {
        self.couponView.couponLabel.text = shopModel.couponModel.name;
        self.couponView.couponLabel.text = [NSString stringWithFormat:@"-¥ %@", MoneyDeal(shopModel.couponModel.denomination)];

        self.couponView.showCoupon = YES;
        
        NSInteger prc = shopModel.totalPrice+shopModel.totalYunFei-shopModel.couponModel.denomination.integerValue;
        NSString *price = _StrFormate(@"%ld",(long)prc);
        self.totalPriceLabel.text = _StrFormate(@"￥%@",MoneyDeal(price));
    }
    else
    {
        self.couponView.showCoupon = NO;
    }
}

- (UIView *)lineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = Color_Gray_Line;
    return lineView;
}

- (UIView *)bottomLineView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = Color_Gray_bg;
    return view;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font_sys_14;
        _titleLabel.textColor = Color_MainText;
        _titleLabel.text = @"运费";
    }
    return _titleLabel;
}

- (UILabel *)frePriceLabel
{
    if (!_frePriceLabel)
    {
        _frePriceLabel = [[UILabel alloc] init];
        _frePriceLabel.font = Font_sys_14;
        _frePriceLabel.textColor = Color_MainText;
    }
    return _frePriceLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel)
    {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = Color_MainText;
        _countLabel.font = Font_sys_14;
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = Font_sys_14;
        _tipLabel.textColor = Color_MainText;
        _tipLabel.text = @"合计：";
        _tipLabel.textAlignment = NSTextAlignmentRight;
    }
    return _tipLabel;
}

- (UILabel *)totalPriceLabel
{
    if (!_totalPriceLabel)
    {
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.textColor = Color_Main_Dark;
        _totalPriceLabel.font = Font_sys_14;
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalPriceLabel;
}

- (UILabel *)frePriceSecLabel
{
    if (!_frePriceSecLabel)
    {
        _frePriceSecLabel = [[UILabel alloc] init];
        _frePriceSecLabel.textColor = Color_Text_Gray;
        _frePriceSecLabel.font = Font_sys_10;
    }
    return _frePriceSecLabel;
}

- (OrderInputCouponFooter *)couponView
{
    if (!_couponView)
    {
        _couponView = [[OrderInputCouponFooter alloc] init];
        [_couponView addTarget:self action:@selector(couponViewAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _couponView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
