//
//  WaresTypeView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BuyCountView.h"

@implementation BuyCountView

- (instancetype)init
{
    if (self = [super init])
    {
        [self addSubview:self.reduceBtn];
        [self addSubview:self.addBtn];
        [self addSubview:self.countTextFiled];
        
        [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.bottom.mas_equalTo(self);
        }];
        
        [self.countTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.reduceBtn.mas_right).offset(2);
            make.size.mas_equalTo(CGSizeMake(40, 30));
            make.centerY.mas_equalTo(self.reduceBtn);
        }];
        
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.countTextFiled.mas_right).offset(2);
            make.centerY.mas_equalTo(self.countTextFiled);
            make.size.mas_equalTo(self.reduceBtn);
        }];
        
    }
    return self;
}

#pragma mark action
- (void)addBtnAction
{
    NSInteger count = [self.countTextFiled.text integerValue];
    count++;
    if (count <= self.maxCount)
    {
        self.countTextFiled.text = [NSString stringWithFormat:@"%ld",count];
    }
    self.addBtn.enabled = count < self.maxCount;
    self.reduceBtn.enabled = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:nil];

}

- (void)reduceBtnAction
{
    NSInteger count = [self.countTextFiled.text integerValue];
    count--;
    if (count >= 1)
    {
        self.countTextFiled.text = [NSString stringWithFormat:@"%ld",count];
    }
    self.reduceBtn.enabled = count > 1;
    self.addBtn.enabled = YES;;
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - get

- (UIButton *)reduceBtn
{
    if (!_reduceBtn)
    {
        _reduceBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [_reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_reduceBtn setTitleColor:Color_Text_LightGray forState:UIControlStateDisabled];
        _reduceBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_reduceBtn setTitle:@"-" forState:0];
        _reduceBtn.enabled = NO;
        [_reduceBtn addTarget:self action:@selector(reduceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceBtn;
}

- (UIButton *)addBtn
{
    if (!_addBtn)
    {
        _addBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addBtn setTitleColor:Color_Text_LightGray forState:UIControlStateDisabled];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_addBtn setTitle:@"+" forState:0];
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UITextField *)countTextFiled
{
    if (!_countTextFiled)
    {
        _countTextFiled = [[UITextField alloc] init];
        _countTextFiled.text = @"1";
        _countTextFiled.textAlignment = NSTextAlignmentCenter;
        _countTextFiled.font = [UIFont systemFontOfSize:15];
        _countTextFiled.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        _countTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _countTextFiled;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
