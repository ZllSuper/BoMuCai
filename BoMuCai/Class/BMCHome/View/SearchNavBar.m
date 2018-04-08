//
//  SearchNavBar.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "SearchNavBar.h"

@implementation SearchNavBar

- (instancetype)init
{
    if (self = [super init])
    {
        self.type = @"商品";
        
        self.backgroundColor = Color_White;
        
        [self addSubview:self.searchTextField];
        [self addSubview:self.cancelBtn];
        
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(62, 44));
            make.top.mas_equalTo(self).offset(20);
        }];
        
        [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self.cancelBtn.mas_left);
            make.centerY.mas_equalTo(self.cancelBtn);
            make.height.mas_equalTo(@30);
        }];
    }
    return self;
}

- (void)setType:(NSString *)type
{
    _type = type;
    [self.typeBtn setTitle:type forState:UIControlStateNormal];
}

#pragma mark - action
- (void)typeBtnAction
{
    if (self.delegate)
    {
        [self.delegate navbarSearchTypeBtnAction:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.delegate)
    {
        [self.delegate navbarSearchAction:self];
    }
    return YES;
}

#pragma mark - get
- (UIButton *)typeBtn
{
    if (!_typeBtn)
    {
        _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeBtn setTitle:@"商品" forState:UIControlStateNormal];
        [_typeBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        _typeBtn.titleLabel.font = Font_sys_14;
        [_typeBtn addTarget:self action:@selector(typeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _typeBtn;
}

- (UITextField *)searchTextField
{
    if (!_searchTextField)
    {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = Color_Gray_Line;
        [leftView addSubview:self.typeBtn];
        [leftView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(leftView).offset(-10);
            make.width.mas_equalTo(@1);
            make.top.mas_equalTo(leftView).offset(5);
            make.bottom.mas_equalTo(leftView).offset(-5);
        }];

        
        [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(leftView);
            make.bottom.mas_equalTo(leftView);
            make.left.mas_equalTo(leftView);
            make.right.mas_equalTo(lineView.mas_left);
        }];
        
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.delegate = self;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.leftView = leftView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.font = Font_sys_14;
        _searchTextField.placeholder = @"输入要寻找的宝贝";
        _searchTextField.backgroundColor = Color_TextFiledBack;
        _searchTextField.layer.cornerRadius = 10;
        _searchTextField.layer.masksToBounds = YES;
    }
    return _searchTextField;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = Font_sys_14;
    }
    return _cancelBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
