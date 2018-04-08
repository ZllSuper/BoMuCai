//
//  PCWaitPaySectionFooterView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCWaitPaySectionFooterView.h"

@implementation PCWaitPaySectionFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = Color_White;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.frePriceLabel];
        [self addSubview:self.countLabel];
        [self addSubview:self.tipLabel];
        [self addSubview:self.totalPriceLabel];
        [self addSubview:self.frePriceSecLabel];
        [self addSubview:self.phoneCallBtn];
        [self addSubview:self.cancelOrderBtn];
        [self addSubview:self.remindBtn];
        [self addSubview:self.thirdBtn];
        
        UIView *lineView = [self lineView];
        UIView *lineView2 = [self lineView];
        UIView *bottomLine = [self bottomLineView];
        [self addSubview:lineView];
        [self addSubview:lineView2];
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
        
        [self.frePriceSecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-16);
            make.top.mas_equalTo(lineView.mas_bottom).offset(10);
            make.height.mas_equalTo(self.tipLabel);
        }];
        
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.frePriceSecLabel.mas_left);
            make.height.mas_equalTo(self.tipLabel);
            make.centerY.mas_equalTo(self.frePriceSecLabel);
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.totalPriceLabel.mas_left);
            make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.tipLabel.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.tipLabel);
        }];
        
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo(0.7);
        }];
        
        [self.phoneCallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(10);
            make.centerY.mas_equalTo(self.remindBtn);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.remindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo(@30);
            make.top.mas_equalTo(lineView2.mas_bottom).offset(10);
            make.width.mas_equalTo(70);
        }];
        
        [self.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.remindBtn.mas_left).offset(-10);
            make.height.mas_equalTo(@30);
            make.centerY.mas_equalTo(self.remindBtn);
            make.width.mas_equalTo(70);
        }];
        
        [self.thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.cancelOrderBtn.mas_left).offset(-10);
            make.height.mas_equalTo(@30);
            make.centerY.mas_equalTo(self.remindBtn);
            make.width.mas_equalTo(70);
        }];

        
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self.remindBtn.mas_bottom).offset(10);
        }];
        
    }
    return self;
}

#pragma mark - action
- (void)phoneCallBtnAction
{
    [self.delegate footerViewPhoneBtnAction:self];
}

- (void)cancelOrderBtnAction
{
    [self.delegate footerViewCancelBtnAction:self];
}

- (void)remindBtnAction
{
    [self.delegate footerViewRemindBtnAction:self];
}

- (void)thirdBtnAction
{
    [self.delegate footerViewThirdBtnAction:self];
}

#pragma mark - get
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

- (UIButton *)phoneCallBtn
{
    if (!_phoneCallBtn)
    {
        _phoneCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneCallBtn setImage:ImageWithName(@"PCPhoneCallBtn") forState:UIControlStateNormal];
        [_phoneCallBtn addTarget:self action:@selector(phoneCallBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneCallBtn;
}

- (UIButton *)cancelOrderBtn
{
    if (!_cancelOrderBtn)
    {
        _cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelOrderBtn.layer.cornerRadius = 2;
        _cancelOrderBtn.layer.borderColor = Color_Gray_Line.CGColor;
        _cancelOrderBtn.layer.borderWidth = 1;
        _cancelOrderBtn.layer.masksToBounds = YES;
        [_cancelOrderBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        _cancelOrderBtn.titleLabel.font = Font_sys_14;
        [_cancelOrderBtn addTarget:self action:@selector(cancelOrderBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelOrderBtn;
}

- (UIButton *)remindBtn
{
    if (!_remindBtn)
    {
        _remindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _remindBtn.layer.cornerRadius = 2;
        _remindBtn.layer.borderColor = Color_Main_Dark.CGColor;
        _remindBtn.layer.borderWidth = 1;
        _remindBtn.layer.masksToBounds = YES;
        [_remindBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        _remindBtn.titleLabel.font = Font_sys_14;
        [_remindBtn addTarget:self action:@selector(remindBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _remindBtn;
}

- (UIButton *)thirdBtn
{
    if (!_thirdBtn)
    {
        _thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _thirdBtn.layer.cornerRadius = 2;
        _thirdBtn.layer.borderColor = Color_Gray_Line.CGColor;
        _thirdBtn.layer.borderWidth = 1;
        _thirdBtn.layer.masksToBounds = YES;
        [_thirdBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        _thirdBtn.titleLabel.font = Font_sys_14;
        [_thirdBtn addTarget:self action:@selector(thirdBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thirdBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
