//
//  LoginInputTextFiledView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "LoginInputTextFiledView.h"

@implementation LoginInputTextFiledView

- (instancetype)init
{
    if (self = [super init])
    {
        self.clipsToBounds = NO;
        
        [self addSubview:self.inputTextFiled];
        [self addSubview:self.lineView];
        [self addSubview:self.errorTipLabel];
        
        [self.inputTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(@1);
            make.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self.inputTextFiled.mas_bottom);
        }];
        
        [self.errorTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@15);
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.sourceDelegate)
    {
        BOOL error = [self.sourceDelegate inputTextFiledErrorWithEndEditing:self];
        self.errorTipLabel.hidden = error;
        if (!error)
        {
            [UIView shakeViewHorizontal:self.errorTipLabel];
            self.lineView.backgroundColor = [UIColor redColor];
        }
        else
        {
            self.lineView.backgroundColor = Color_Gray_Line;
        }
    }
}

#pragma mark = get
- (UITextField *)inputTextFiled
{
    if (!_inputTextFiled)
    {
        _inputTextFiled = [[UITextField alloc] init];
        _inputTextFiled.font = Font_sys_14;
        _inputTextFiled.delegate = self;
    }
    return _inputTextFiled;
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

- (UILabel *)errorTipLabel
{
    if (!_errorTipLabel)
    {
        _errorTipLabel = [[UILabel alloc] init];
        _errorTipLabel.font = Font_sys_10;
        _errorTipLabel.textColor = [UIColor redColor];
        _errorTipLabel.hidden = YES;
    }
    return _errorTipLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
