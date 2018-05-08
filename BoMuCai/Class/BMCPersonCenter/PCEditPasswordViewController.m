//
//  PCEditPasswordViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCEditPasswordViewController.h"

#import "PCEditPasswordCell.h"

#import "PCChangePasswordRequest.h"

@interface PCEditPasswordViewController ()

@property (nonatomic, strong) PCEditPasswordCell *passwordOrCell;

@property (nonatomic, strong) PCEditPasswordCell *passwordNewCell;

@property (nonatomic, strong) PCEditPasswordCell *passwordConfirmCell;

@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation PCEditPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"修改密码";
    
    [self.view addSubview:self.passwordOrCell];
    [self.view addSubview:self.passwordNewCell];
    [self.view addSubview:self.passwordConfirmCell];
    [self.view addSubview:self.submitBtn];
    
    [self.passwordOrCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(8);
        make.height.mas_equalTo(44);
    }];
    
    [self.passwordNewCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.passwordOrCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.passwordConfirmCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.passwordNewCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.passwordConfirmCell.mas_bottom).offset(30);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
- (void)changePasswordRequest
{
    __weak typeof(self) weakSelf = self;
    PCChangePasswordRequest *request = [[PCChangePasswordRequest alloc] init];
    request.password = self.passwordOrCell.textFiled.text;
    request.passwordNew = self.passwordNewCell.textFiled.text;
    request.phone = [AccountInfo shareInstance].phone;
    ProgressShow(self.view);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            ToastShowBottom(@"修改成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        ToastShowBottom(NetWorkErrorTip);
    }];
}

#pragma mark - action
- (void)bottomBtnAction
{
    [self.view endEditing:YES];
    if(StringIsEmpty(self.passwordOrCell.textFiled.text) || ![TSRegularExpressionUtil validatePassword:self.passwordOrCell.textFiled.text])
    {
        ToastShowCenter(@"请输入6～16位数字和字母原密码");
        return;
    }
    
    if(StringIsEmpty(self.passwordNewCell.textFiled.text) || ![TSRegularExpressionUtil validatePassword:self.passwordNewCell.textFiled.text])
    {
        ToastShowCenter(@"请输入6～16位数字和字母新密码");
        return;
    }

    
    if(StringIsEmpty(self.passwordConfirmCell.textFiled.text))
    {
        ToastShowCenter(@"请输入确认密码");
        return;
    }
    
    if(![self.passwordNewCell.textFiled.text isEqualToString:self.passwordConfirmCell.textFiled.text])
    {
        ToastShowCenter(@"新密码两次输入不一致");
        return;
    }
    
    [self changePasswordRequest];
}

#pragma mark - get
- (PCEditPasswordCell *)passwordOrCell
{
    if (!_passwordOrCell)
    {
        _passwordOrCell = [[PCEditPasswordCell alloc] init];
        _passwordOrCell.textFiled.placeholder = @"请输入原密码";
        _passwordOrCell.textFiled.secureTextEntry = YES;
    }
    return _passwordOrCell;
}

- (PCEditPasswordCell *)passwordNewCell
{
    if (!_passwordNewCell)
    {
        _passwordNewCell = [[PCEditPasswordCell alloc] init];
        _passwordNewCell.textFiled.placeholder = @"请输入新密码";
        _passwordNewCell.textFiled.secureTextEntry = YES;
    }
    return _passwordNewCell;
}

- (PCEditPasswordCell *)passwordConfirmCell
{
    if (!_passwordConfirmCell)
    {
        _passwordConfirmCell = [[PCEditPasswordCell alloc] init];
        _passwordConfirmCell.textFiled.placeholder = @"请确认密码";
        _passwordConfirmCell.lineView.hidden = YES;
        _passwordConfirmCell.textFiled.secureTextEntry = YES;
    }
    return _passwordConfirmCell;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn)
    {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = Font_sys_14;
        _submitBtn.layer.cornerRadius = 6;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn addTarget:self action:@selector(bottomBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
