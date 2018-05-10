//
//  CarCountCalculateView.m
//  BoMuCai
//
//  Created by liangliang.zhu on 2018/5/8.
//  Copyright © 2018年 woshishui. All rights reserved.
//

#import "CarCountCalculateView.h"
#import "CarGoodModel.h"

@implementation CarCountCalculateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
        
        [self.countTextFiled becomeFirstResponder];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];

}

- (void)creatSubViews
{
    self.layer.borderColor = Color_Gray_Line.CGColor;
    self.layer.borderWidth = 1;
    
    [self addSubview:self.hideBtn];

    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.reduceBtn];
    [self.alertView addSubview:self.addBtn];
    [self.alertView addSubview:self.countTextFiled];
    
    [self addSubview:self.commitBtn];
    [self addSubview:self.cancelBtn];

    
    UIView *lineView0 = [self lineView];
    UIView *lineView1 = [self lineView];
    UIView *lineView2 = [self lineView];
    UIView *lineView3 = [self lineView];
    UIView *lineView4 = [self lineView];
    UIView *lineView5 = [self lineView];
    UIView *lineView6 = [self lineView];
    UIView *lineView7 = [self lineView];

    [self.alertView addSubview:lineView0];
    [self.alertView addSubview:lineView1];
    [self.alertView addSubview:lineView2];
    [self.alertView addSubview:lineView3];
    [self.alertView addSubview:lineView4];
    [self.alertView addSubview:lineView5];
    [self.alertView addSubview:lineView6];
    [self.alertView addSubview:lineView7];

    [self.hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self);
    }];
    
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-100);
        make.size.mas_equalTo(CGSizeMake(250, 200));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alertView).offset(20);
        make.centerX.mas_equalTo(self.alertView);
    }];
    
    [self.countTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 40));
        make.center.mas_equalTo(self.alertView);
    }];
    
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.countTextFiled.mas_left);
        make.top.mas_equalTo(self.countTextFiled);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countTextFiled.mas_right);
        make.top.mas_equalTo(self.countTextFiled);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reduceBtn.mas_right);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(self.reduceBtn).offset(5);
        make.bottom.mas_equalTo(self.reduceBtn).offset(-5);
    }];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countTextFiled.mas_right);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(self.countTextFiled).offset(5);
        make.bottom.mas_equalTo(self.countTextFiled).offset(-5);
    }];
    
    [lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reduceBtn);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(self.reduceBtn);
        make.bottom.mas_equalTo(self.reduceBtn);
    }];

    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reduceBtn);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.reduceBtn);
        make.right.mas_equalTo(self.addBtn);
    }];
    
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reduceBtn);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.reduceBtn);
        make.right.mas_equalTo(self.addBtn);
    }];
    
    [lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.addBtn);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(self.addBtn);
        make.bottom.mas_equalTo(self.addBtn);
    }];
    
    [lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commitBtn.mas_right);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(self.commitBtn).offset(5);
        make.bottom.mas_equalTo(self.commitBtn).offset(-5);
    }];
    
    [lineView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commitBtn);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.commitBtn);
        make.right.mas_equalTo(self.cancelBtn);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.alertView);
        make.bottom.mas_equalTo(self.alertView);
        make.height.mas_equalTo(@45);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commitBtn.mas_right);
        make.centerY.mas_equalTo(self.commitBtn);
        make.size.mas_equalTo(self.commitBtn);
        make.right.mas_equalTo(self.alertView);
    }];
}

#pragma mark - get
- (UIView *)alertView
{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = Color_White;
        _alertView.layer.cornerRadius = 10;
        _alertView.clipsToBounds = YES;
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"修改购买数量";
        _titleLabel.font = Font_sys_16;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

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
        [_reduceBtn addTarget:self action:@selector(reduceBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
        _countTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _countTextFiled;
}

- (UIButton *)hideBtn
{
    if (!_hideBtn) {
        _hideBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _hideBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [_hideBtn addTarget:self action:@selector(hideBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _hideBtn;
}

- (UIButton *)commitBtn
{
    if (!_commitBtn)
    {
        _commitBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitBtn setTitleColor:[UIColor blackColor] forState:0];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:Color_Orange forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:0];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(hideBtnAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _cancelBtn;
}


#pragma mark Action
- (void)hideBtnAction
{
    self.completion = nil;
    [self removeFromSuperview];
}

- (void)commitBtnAction
{
    NSInteger count = [self.countTextFiled.text integerValue];
    if (count >= 1) {
        if (self.completion) {
            self.completion(self.countTextFiled.text);
        }
        [self hideBtnAction];
    }
    else {
        ToastShowCenter(@"数量超出范围~");
    }
}

- (void)reduceBtnAction
{
    NSInteger count = [self.countTextFiled.text integerValue];
    count --;
    if (count >= 1) {
        self.countTextFiled.text = [NSString stringWithFormat:@"%ld",count];
    }
    else {
        ToastShowCenter(@"数量超出范围~");
    }
}

- (void)addBtnAction
{
    NSInteger count = [self.countTextFiled.text integerValue];
    count ++;
    if (count <= [self.carGoodModel.stock integerValue]) {
        self.countTextFiled.text = [NSString stringWithFormat:@"%ld",count];
    }
    else {
        ToastShowCenter(@"数量超出范围~");
    }
}

+ (void)showWithCarGoodModel:(CarGoodModel *)carGoodModel completion:(CarCountCalculateViewBlock)completion
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CarCountCalculateView *view = [[CarCountCalculateView alloc] initWithFrame:window.bounds];
    view.completion = completion;
    view.carGoodModel = carGoodModel;
    view.countTextFiled.text = carGoodModel.amount;
    [window addSubview:view];
}

#pragma mark Notifications
- (void)textFieldTextDidChangeNotification:(NSNotification *)noti
{
    NSString *number = [[NSString alloc] initWithFormat:@"%d", self.countTextFiled.text.intValue];
    self.countTextFiled.text  = number;
}

@end
