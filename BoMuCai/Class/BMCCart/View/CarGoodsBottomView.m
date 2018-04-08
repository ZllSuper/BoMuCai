//
//  CarGoodsBottomView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarGoodsBottomView.h"

@implementation CarGoodsBottomView
- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.allSelectBtn];
        [self addSubview:self.tipLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.payBtn];
        
        [self.allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
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
            make.left.mas_equalTo(self.allSelectBtn.mas_right);
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
- (UIButton *)allSelectBtn
{
    if (!_allSelectBtn)
    {
        _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        [_allSelectBtn setImage:ImageWithName(@"CarGoodUnSel") forState:UIControlStateNormal];
        [_allSelectBtn setImage:ImageWithName(@"CarGoodSel") forState:UIControlStateSelected];
        _allSelectBtn.titleLabel.font = Font_sys_14;
        _allSelectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    return _allSelectBtn;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = Color_MainText;
        _tipLabel.font = Font_sys_14;
        NSString *text = @"合计(含运费):";
        NSRange range = [text rangeOfString:@"(含运费)"];
        NSMutableAttributedString *outStr = [[NSMutableAttributedString alloc] initWithString:text];
        [outStr addAttributes:@{NSForegroundColorAttributeName : Color_MainText, NSFontAttributeName : Font_sys_14} range:NSMakeRange(0, text.length)];
        [outStr addAttributes:@{NSForegroundColorAttributeName : Color_Text_LightGray, NSFontAttributeName : Font_sys_10} range:range];
        _tipLabel.attributedText = outStr;
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
        [_payBtn setTitle:@"结算 (0)" forState:UIControlStateNormal];
        [_payBtn setTitleColor:Color_White forState:UIControlStateNormal];
        _payBtn.titleLabel.font = Font_sys_14;
    }
    return _payBtn;
}

@end
