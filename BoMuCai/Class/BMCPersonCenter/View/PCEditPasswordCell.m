//
//  PCEditPasswordCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCEditPasswordCell.h"

@implementation PCEditPasswordCell

- (instancetype) init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.textFiled];
        [self addSubview:self.lineView];
        
        [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.top.and.bottom.mas_equalTo(self);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo(0.7);
        }];
    }
    return self;
}

#pragma mark - get
- (UITextField *)textFiled
{
    if (!_textFiled)
    {
        _textFiled = [[UITextField alloc] init];
        _textFiled.font = Font_sys_14;
        _textFiled.textColor = Color_MainText;
    }
    return _textFiled;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = Color_Gray_Line;
    }
    return _lineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
