//
//  PCOrderDetailPhoneBottomView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderDetailPhoneBottomView.h"

@implementation PCOrderDetailPhoneBottomView
- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        UIView *lineView = [self lineView];
        [self addSubview:lineView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.phoneIcon];
        [self addSubview:self.phoneBtn];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
        [self.phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.titleLabel.mas_left).offset(-15);
            make.centerY.mas_equalTo(self);
        }];
        
        [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - get
- (UIView *)lineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = Color_Gray_Line;
    return lineView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font_sys_14;
        _titleLabel.textColor = Color_MainText;
        _titleLabel.text = @"平台服务电话：180-3188-3945";
    }
    return _titleLabel;
}

- (UIButton *)phoneIcon
{
    if (!_phoneIcon)
    {
        _phoneIcon = [[UIButton alloc] init];
        [_phoneIcon setImage:ImageWithName(@"PCPhoneCallBtn") forState:UIControlStateNormal];
    }
    return _phoneIcon;
}

- (UIButton *)phoneBtn
{
    if (!_phoneBtn)
    {
        _phoneBtn = [[UIButton alloc] init];
        [_phoneBtn addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

- (void)phoneButtonAction
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18031883945"]];
}

@end
