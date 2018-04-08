//
//  ShopCouponBtn.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/22.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopCouponBtn.h"

@implementation ShopCouponBtn

- (instancetype)init
{
    if (self = [super init])
    {
        [self setBackgroundImage:ImageWithResizableImage(@"ShopCouponBack", UIEdgeInsetsMake(10, 10, 10, 10)) forState:UIControlStateNormal];
//        [self setBackgroundImage:ImageWithResizableImage(@"ShopCouponSelBack", UIEdgeInsetsMake(10, 10, 10, 10)) forState:UIControlStateSelected];
        [self setBackgroundImage:ImageWithResizableImage(@"ShopCouponSelBack", UIEdgeInsetsMake(10, 10, 10, 10)) forState:UIControlStateDisabled];

        [self addSubview:self.unitLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.descLabel];
        
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_centerY).offset(5);
        }];
        
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.moneyLabel.mas_bottom);
            make.centerX.mas_equalTo(self);
        }];
        
        [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.moneyLabel);
            make.right.mas_equalTo(self.moneyLabel.mas_left);
        }];
    }
    return self;
}

#pragma mark - set / get
- (void)setWeakModel:(ShopCouponModel *)weakModel
{
    _weakModel = weakModel;
    
    self.moneyLabel.text = MoneyDeal(_weakModel.denomination);
    self.descLabel.text = [NSString stringWithFormat:@"满%@可用",MoneyDeal(_weakModel.quota)];
    BOOL selected = ([weakModel.receiveNum intValue] > 0);
    self.enabled = !selected;
}

- (UILabel *)unitLabel
{
    if (!_unitLabel)
    {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.font = Font_sys_10;
        _unitLabel.textColor = Color_White;
        _unitLabel.text = @"￥";
    }
    return _unitLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:(DEF_SCREENWIDTH <= 320 ? 20 : 25)];
        _moneyLabel.textColor = Color_White;
    }
    return _moneyLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = Font_sys_10;
        _descLabel.textColor = Color_White;
    }
    return _descLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
