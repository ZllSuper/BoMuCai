//
//  RegistInputTextFiled.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "RegistInputTextFiled.h"

@implementation RegistInputTextFiled

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.inputTextFiled];
        [self addSubview:self.lineView];
        
        [self.inputTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.top.mas_equalTo(self);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.inputTextFiled);
            make.right.mas_equalTo(self.inputTextFiled);
            make.height.mas_equalTo(@1);
            make.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self.inputTextFiled.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - textFiledDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate)
    {
        [self.delegate textFiledDidEndEditing:self];
    }
}

#pragma mark - get
- (UITextField *)inputTextFiled
{
    if (!_inputTextFiled)
    {
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        leftLabel.text = @"*";
        leftLabel.textColor = [UIColor redColor];
        leftLabel.font = Font_sys_14;
        
        _inputTextFiled = [[UITextField alloc] init];
        _inputTextFiled.font = Font_sys_14;
        _inputTextFiled.leftView = leftLabel;
        _inputTextFiled.leftViewMode = UITextFieldViewModeAlways;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
