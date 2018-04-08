//
//  CarPayBtnFooterView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarPayBtnFooterView.h"

@implementation CarPayBtnFooterView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.payBtn];
        [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo(44);
            make.centerY.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - get
- (UIButton *)payBtn
{
    if (!_payBtn)
    {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        _payBtn.layer.cornerRadius = 6;
        _payBtn.layer.masksToBounds = YES;
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
