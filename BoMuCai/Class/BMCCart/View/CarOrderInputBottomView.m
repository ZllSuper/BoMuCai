//
//  CarOrderInputBottomView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarOrderInputBottomView.h"

@implementation CarOrderInputBottomView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.countLabel];
        [self addSubview:self.tipLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.payBtn];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(70);
        }];
        
        [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.moneyLabel.mas_right).offset(10);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(DEF_SCREENWIDTH * 0.28);
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.countLabel.mas_right);
            make.centerY.mas_equalTo(self);
        }];
        
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.tipLabel.mas_right).offset(5);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(80);
        }];
    }
    return self;
}

#pragma mark - get
- (UILabel *)countLabel
{
    if (!_countLabel)
    {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = Color_MainText;
        _countLabel.font = Font_sys_14;
        _countLabel.text = @"共0件";
    }
    return _countLabel;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = Color_MainText;
        _tipLabel.font = Font_sys_14;
        _tipLabel.text = @"合计:";
        _tipLabel.textAlignment = NSTextAlignmentRight;
    }
    return _tipLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = Color_Main_Dark;
        _moneyLabel.font = Font_sys_14;
        _moneyLabel.text = @"￥0.00";
    }
    return _moneyLabel;
}

- (UIButton *)payBtn
{
    if (!_payBtn)
    {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        [_payBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_payBtn setTitleColor:Color_White forState:UIControlStateNormal];
        _payBtn.titleLabel.font = Font_sys_14;
    }
    return _payBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
