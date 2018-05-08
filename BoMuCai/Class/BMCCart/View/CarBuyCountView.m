//
//  CarBuyCountView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarBuyCountView.h"

@implementation CarBuyCountView

- (instancetype)init
{
    if (self = [super init])
    {
        [self creatSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    self.layer.borderColor = Color_Gray_Line.CGColor;
    self.layer.borderWidth = 1;
    
    [self addSubview:self.reduceBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.countTextFiled];
    [self addSubview:self.countTextBtn];

    UIView *lineView1 = [self lineView];
    UIView *lineView2 = [self lineView];
    [self addSubview:lineView1];
    [self addSubview:lineView2];
    
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reduceBtn.mas_right);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(self).offset(5);
        make.bottom.mas_equalTo(self).offset(-5);
    }];
    
    [self.countTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView1.mas_right);
        make.size.mas_equalTo(self.reduceBtn);
        make.centerY.mas_equalTo(self.reduceBtn);
    }];
    
    [self.countTextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.countTextFiled);
    }];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countTextFiled.mas_right);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(self).offset(5);
        make.bottom.mas_equalTo(self).offset(-5);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView2.mas_right);
        make.centerY.mas_equalTo(self.countTextFiled);
        make.size.mas_equalTo(self.reduceBtn);
        make.right.mas_equalTo(self);
    }];
}

#pragma mark - action
- (void)certain
{
    [self.countTextFiled resignFirstResponder];
}

#pragma mark - get
- (UIView *)lineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = Color_Gray_Line;
    return lineView;
}

- (UIButton *)reduceBtn
{
    if (!_reduceBtn)
    {
        _reduceBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceBtn setTitleColor:[UIColor blackColor] forState:0];
        _reduceBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_reduceBtn setTitle:@"-" forState:0];
        [_reduceBtn setTitleColor:Color_Text_LightGray forState:UIControlStateDisabled];
    }
    return _reduceBtn;
}

- (UIButton *)addBtn
{
    if (!_addBtn)
    {
        _addBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitleColor:[UIColor blackColor] forState:0];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_addBtn setTitle:@"+" forState:0];
        [_addBtn setTitleColor:Color_Text_LightGray forState:UIControlStateDisabled];

    }
    return _addBtn;
}

- (UITextField *)countTextFiled
{
    if (!_countTextFiled)
    {
        _countTextFiled = [[UITextField alloc] init];
        _countTextFiled.text = @"1";
        _countTextFiled.inputAccessoryView = [self accessoryView];
        _countTextFiled.textAlignment = NSTextAlignmentCenter;
        _countTextFiled.font = [UIFont systemFontOfSize:15];
        _countTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _countTextFiled;
}

- (UIButton *)countTextBtn
{
    if (!_countTextBtn)
    {
        _countTextBtn = [[UIButton alloc] init];
    }
    return _countTextBtn;
}

- (UIToolbar *)accessoryView
{
    if(!_accessoryView)
    {
        _accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREENWIDTH, 40)];
        _accessoryView.userInteractionEnabled = YES;
        _accessoryView.translucent = NO;
        _accessoryView.barTintColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        
        UIButton *certain = [UIButton buttonWithType:UIButtonTypeCustom];
        [certain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        certain.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [certain setTitleColor:Color_Main_Light forState:UIControlStateNormal];
        [certain setTitle:@"完成" forState:UIControlStateNormal];
        certain.layer.cornerRadius = 3.f;
        [certain addTarget:self action:@selector(certain) forControlEvents:UIControlEventTouchUpInside];
        [_accessoryView addSubview:certain];
        [certain mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_accessoryView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(40, 30));
            make.centerY.mas_equalTo(_accessoryView);
        }];
        
    }
    
    return _accessoryView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
