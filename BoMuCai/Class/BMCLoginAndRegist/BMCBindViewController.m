//
//  BMCBindViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/10/30.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCBindViewController.h"
#import "LoginInputTextFiledView.h"
#import "STThirdPartBindRequest.h"

@interface BMCBindViewController () <LoginInputTextFiledViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) LoginInputTextFiledView *accountTextFiled;

@property (nonatomic, strong) LoginInputTextFiledView *passwordTextFiled;

@property (nonatomic, strong) UIButton *loginBtn;


@end

@implementation BMCBindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.accountTextFiled];
    [self.view addSubview:self.passwordTextFiled];
    [self.view addSubview:self.loginBtn];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(27);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(self.view).offset(16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(27);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.accountTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(@30);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(30);
    }];
    
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.accountTextFiled);
        make.right.mas_equalTo(self.accountTextFiled);
        make.top.mas_equalTo(self.accountTextFiled.mas_bottom).offset(30);
        make.height.mas_equalTo(@30);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(self.passwordTextFiled.mas_bottom).offset(30);
        make.height.mas_equalTo(@45);
    }];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}


- (void)thirdPartBindRequest
{
    STThirdPartBindRequest *request = [[STThirdPartBindRequest alloc] init];
    request.openId = self.openId;
    request.thirdType = self.thirdType;
    request.phone = self.accountTextFiled.inputTextFiled.text;
    request.password = self.passwordTextFiled.inputTextFiled.text;
    ProgressShow(self.view);
    BXHWeakObj(self);
    [request requestWithSuccess:^(BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            [[AccountInfo shareInstance] resetSourceWithDict:request.response.data];
            [[AccountInfo shareInstance] saveToDisk];
            ToastShowBottom(@"登录成功");
            [selfWeak.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            ToastShowBottom(request.response.message);
            ProgressHidden(selfWeak.view);
        }
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(selfWeak.view);
        ToastShowBottom(NetWorkErrorTip);
    }];
}

- (void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginBtnAction
{
    [self thirdPartBindRequest];
}


#pragma mark - textFiledDelegate
- (BOOL)inputTextFiledErrorWithEndEditing:(LoginInputTextFiledView *)textFiled
{
    BOOL returnBool = YES;
    
    if ([textFiled isEqual:self.accountTextFiled])
    {
        returnBool = [TSRegularExpressionUtil validateMobile:textFiled.inputTextFiled.text];
    }
    if ([TSRegularExpressionUtil validateMobile:self.accountTextFiled.inputTextFiled.text] && !StringIsEmpty(self.passwordTextFiled.inputTextFiled.text))
    {
        self.loginBtn.enabled = YES;
    }
    else
    {
        self.loginBtn.enabled = NO;
    }
    
    return returnBool;
}


#pragma mark - lazyLoad
- (UIButton *)backBtn
{
    if (!_backBtn)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:ImageWithName(@"PublicBackArrow") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _backBtn;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.text = @"绑定";
    }
    return _titleLabel;
}

- (LoginInputTextFiledView *)accountTextFiled
{
    if (!_accountTextFiled)
    {
        _accountTextFiled = [[LoginInputTextFiledView alloc] init];
        _accountTextFiled.sourceDelegate = self;
        _accountTextFiled.inputTextFiled.placeholder = @"请输入手机号";
        _accountTextFiled.errorTipLabel.text = @"请输入正确手机号";
        _accountTextFiled.inputTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _accountTextFiled;
}

- (LoginInputTextFiledView *)passwordTextFiled
{
    if (!_passwordTextFiled)
    {
        _passwordTextFiled = [[LoginInputTextFiledView alloc] init];
        _passwordTextFiled.sourceDelegate = self;
        _passwordTextFiled.inputTextFiled.placeholder = @"请输入密码";
        _passwordTextFiled.errorTipLabel.text = @"请输入正确手机号";
        _passwordTextFiled.inputTextFiled.secureTextEntry = YES;
    }
    return _passwordTextFiled;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn)
    {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        [_loginBtn setTitle:@"绑定" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = Font_sys_16;
        [_loginBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.cornerRadius = 6;
        _loginBtn.clipsToBounds = YES;
        _loginBtn.enabled = NO;
    }
    return _loginBtn;
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
