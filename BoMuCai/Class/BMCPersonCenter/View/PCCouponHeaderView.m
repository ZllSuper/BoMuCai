//
//  PCCouponHeaderView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCCouponHeaderView.h"

@implementation PCCouponHeaderView
- (instancetype)init
{
    if (self = [super init])
    {
        UIView *leftLine = [self lineView];
        UIView *rightLine = [self lineView];
        [self addSubview:leftLine];
        [self addSubview:rightLine];
        [self addSubview:self.tipLabel];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self.tipLabel.mas_left).offset(-5);
            make.height.mas_equalTo(0.7);
            make.centerY.mas_equalTo(self);
        }];
        
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.tipLabel.mas_right).offset(5);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo(0.7);
            make.centerY.mas_equalTo(self);
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

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = Color_Text_LightGray;
        _tipLabel.font = Font_sys_14;
        _tipLabel.text = @"已失效的券";
    }
    return _tipLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
