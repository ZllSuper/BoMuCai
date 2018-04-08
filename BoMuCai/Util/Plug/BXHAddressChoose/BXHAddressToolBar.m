//
//  BXHAddressToolBar.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHAddressToolBar.h"

@implementation BXHAddressToolBar

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.titleLabel];
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.bottom.mas_equalTo(self);
            make.width.mas_equalTo(60);
        }];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.top.and.bottom.mas_equalTo(self);
            make.width.mas_equalTo(60);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - get
- (UIButton *)leftBtn
{
    if (!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:Color_Text_Gray forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = Font_sys_14;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = Font_sys_14;
    }
    return _rightBtn;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = Color_MainText;
        _titleLabel.font = Font_sys_14;
        _titleLabel.text = @"省市区";
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
