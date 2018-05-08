//
//  BMCLoginViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCLoginViewController.h"

#import "RegistViewController.h"
#import "ForgetViewController.h"
#import "BMCBindViewController.h"

#import "LoginImageTitleControl.h"
#import "LoginInputTextFiledView.h"

#import "LoginRequest.h"

#import "WechatAuthSDK.h"
#import "WXApiManager.h"
#import "QQApiManager.h"

#import "STWXTokenGetRequest.h"
#import "STThirdPartLoginRequest.h"


static NSString *kAuthScope = @"snsapi_userinfo";
static NSString *kAuthOpenID = @"0c806938e2413ce73eef92cc3";
static NSString *kAuthState = @"App";

@interface BMCLoginViewController () <LoginInputTextFiledViewDelegate, WXApiManagerDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIView *midLoginView;

@property (nonatomic, strong) LoginImageTitleControl *wxControl;

@property (nonatomic, strong) LoginImageTitleControl *qqControl;

@property (nonatomic, strong) LoginInputTextFiledView *accountTextFiled;

@property (nonatomic, strong) LoginInputTextFiledView *passwordTextFiled;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *registBtn;

@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, copy) NSString *loginType;

@end

@implementation BMCLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_White;
    
    [self layOutSubView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.midLoginView registerAsDodgeViewForMLInputDodger];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.midLoginView unregisterAsDodgeViewForMLInputDodger];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layOutSubView
{
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.midLoginView];
    [self.view addSubview:self.wxControl];
    [self.view addSubview:self.qqControl];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.size.mas_equalTo(CGSizeMake(40, 44));
        make.top.mas_equalTo(self.view).offset(20);
    }];
    
    [self.midLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backBtn.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    [self.wxControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_centerX).offset(-25);
        make.top.mas_equalTo(self.midLoginView.mas_bottom);
        make.bottom.mas_equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(60, 90));
    }];
    
    [self.qqControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_centerX).offset(25);
        make.top.mas_equalTo(self.midLoginView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(60, 90));
    }];
}

#pragma mark - loginRequest
- (void)loginRequest
{
    __weak typeof(self) weakSelf = self;
    LoginRequest *item = [[LoginRequest alloc] init];
    item.phone = self.accountTextFiled.inputTextFiled.text;
    item.password = self.passwordTextFiled.inputTextFiled.text;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [[AccountInfo shareInstance] resetSourceWithDict:request.response.data];
            [[AccountInfo shareInstance] saveToDisk];

            [[EMClient sharedClient] loginWithUsername:KAccountInfo.easemob password:KAccountInfo.easemobPassword completion:^(NSString *aUsername, EMError *aError) {
                
                if (!aError) {
                    //设置是否自动登录
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    
                    ToastShowCenter(@"登录成功");
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
                }
                else {
                    ToastShowCenter(_StrFormate(@"环信登录失败：%@",aError.errorDescription));
                }
            }];
        }
        else
        {
            ToastShowCenter(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        ToastShowCenter(NetWorkErrorTip);
    }];
}

- (void)thirdPartLoginReuqest:(NSString *)onlyId
{
    STThirdPartLoginRequest *request = [[STThirdPartLoginRequest alloc] init];
    request.openId = onlyId;
    request.thirdType = self.loginType;
    BXHWeakObj(self);
    BXHBlockObj(onlyId);
    [request requestWithSuccess:^(BXHBaseRequest *request) {
        ProgressHidden(selfWeak.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [[AccountInfo shareInstance] resetSourceWithDict:request.response.data];
            [[AccountInfo shareInstance] saveToDisk];
            
            [[EMClient sharedClient] loginWithUsername:KAccountInfo.easemob password:KAccountInfo.easemobPassword completion:^(NSString *aUsername, EMError *aError) {
                
                if (!aError) {
                    //设置是否自动登录
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    
                    ToastShowCenter(@"登录成功");
                    [selfWeak.navigationController dismissViewControllerAnimated:YES completion:nil];
                }
                else {
                    ToastShowCenter(_StrFormate(@"环信登录失败：%@",aError.errorDescription));
                }
            }];
        }
        else if ([request.response.code isEqualToString:@"0031"] || [request.response.code isEqualToString:@"0030"])
        {
            BMCBindViewController *vc = [[BMCBindViewController alloc] init];
            vc.openId = onlyIdblock;
            vc.thirdType = selfWeak.loginType;
            [selfWeak.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            ProgressHidden(selfWeak.view);
            ToastShowCenter(request.response.message);
        }
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(selfWeak.view);
        ToastShowCenter(NetWorkErrorTip);
    }];
}

#pragma makr - action
- (void)backBtnAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginBtnAction
{
    [self.view endEditing:YES];
    
    if (StringIsEmpty(self.accountTextFiled.inputTextFiled.text) || [TSRegularExpressionUtil validateMobile:self.accountTextFiled.inputTextFiled.text] == NO)
    {
        ToastShowCenter(@"请输入正确手机号");
        return;
    }
    
    if (StringIsEmpty(self.passwordTextFiled.inputTextFiled.text) || [TSRegularExpressionUtil validatePassword:self.passwordTextFiled.inputTextFiled.text] == NO) {
        ToastShowCenter(@"请输入6～16位数字和字母密码");
        return;
    }
    
    [self loginRequest];
}

- (void)registBtnAction
{
    RegistViewController *vc = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forgetBtnAction
{
    ForgetViewController *vc = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)wxLoginAction
{
    [self.view endEditing:YES];
    self.loginType = @"WEIXIN";
    [WXApiManager sharedManager].delegate = self;
    [[WXApiManager sharedManager] sendAuthScope:kAuthScope state:kAuthState openId:kAuthOpenID fromViewContoller:self];
}

- (void)qqLoginAction
{
    [self.view endEditing:YES];
    self.loginType = @"QQ";
    BXHWeakObj(self);
    [[QQApiManager shareInstance] qqStartLoginWithCallBack:^(BOOL success, NSString *message, NSString *userId, NSString *nickName, NSString *headerImage) {
        if (success)
        {
            ProgressShow(selfWeak.view);
            [selfWeak thirdPartLoginReuqest:userId];
        }
        else
        {
            ToastShowCenter(message);
        }
    }];
}

#pragma mark - wxDelegate
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response
{
    if (StringIsEmpty(response.code))
    {
        ToastShowCenter(@"微信登录失败");
        return;
    }
    
    STWXTokenGetRequest *request = [[STWXTokenGetRequest alloc] init];
    request.code = response.code;
    request.appid = @"wx5c1124364bed58d5";
    request.secret = @"b9cf6d4fe46869f46af43764fd266e95";
    request.grant_type = @"authorization_code";
    BXHWeakObj(self);
    ProgressShow(self.view);
    [request requestWithSuccess:^(BXHBaseRequest *request) {
        NSString *openid = request.response.responseObject[@"unionid"];
        BXHStrongObj(selfWeak);
        [selfWeakStrong thirdPartLoginReuqest:openid];
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(selfWeak.view);
        ToastShowCenter(NetWorkErrorTip);
    }];
}

#pragma mark - textFiledDelegate
- (BOOL)inputTextFiledErrorWithEndEditing:(LoginInputTextFiledView *)textFiled
{
    return YES;
    
    BOOL returnBool = YES;
    
    if ([textFiled isEqual:self.accountTextFiled])
    {
        returnBool = [TSRegularExpressionUtil validateMobile:textFiled.inputTextFiled.text];
    }
    else if ([textFiled isEqual:self.passwordTextFiled]) {
        returnBool = [TSRegularExpressionUtil validatePassword:textFiled.inputTextFiled.text];
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

#pragma mark - get
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

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = ImageWithName(@"LoginIcon");
    }
    return _iconImageView;
}

- (LoginInputTextFiledView *)accountTextFiled
{
    if (!_accountTextFiled)
    {
        _accountTextFiled = [[LoginInputTextFiledView alloc] init];
        _accountTextFiled.sourceDelegate = self;
        _accountTextFiled.inputTextFiled.placeholder = @"请输入手机号";
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
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = Font_sys_16;
        [_loginBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.cornerRadius = 6;
        _loginBtn.clipsToBounds = YES;
//        _loginBtn.enabled = NO;
    }
    return _loginBtn;
}

- (UIButton *)registBtn
{
    if (!_registBtn)
    {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        _registBtn.titleLabel.font = Font_sys_14;
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_registBtn addTarget:self action:@selector(registBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}

- (UIButton *)forgetBtn
{
    if (!_forgetBtn)
    {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetBtn.titleLabel.font = Font_sys_14;
        [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_forgetBtn addTarget:self action:@selector(forgetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}

- (LoginImageTitleControl *)wxControl
{
    if (!_wxControl)
    {
        _wxControl = [[LoginImageTitleControl alloc] init];
        _wxControl.titleLabel.text = @"微信登录";
        _wxControl.imageView.image = ImageWithName(@"WXLoginIcon");
        [_wxControl addTarget:self action:@selector(wxLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxControl;
}

- (LoginImageTitleControl *)qqControl
{
    if (!_qqControl)
    {
        _qqControl = [[LoginImageTitleControl alloc] init];
        _qqControl.titleLabel.text = @"QQ登录";
        _qqControl.imageView.image = ImageWithName(@"QQLoginIcon");
        [_qqControl addTarget:self action:@selector(qqLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqControl;
}


- (UIView *)midLoginView
{
    if (!_midLoginView)
    {
        _midLoginView = [[UIView alloc] init];
        
        [_midLoginView addSubview:self.iconImageView];
        [_midLoginView addSubview:self.accountTextFiled];
        [_midLoginView addSubview:self.passwordTextFiled];
        [_midLoginView addSubview:self.loginBtn];
        [_midLoginView addSubview:self.registBtn];
        [_midLoginView addSubview:self.forgetBtn];
        
        UIView *marginView1 = [self marginView]; //20
        [_midLoginView addSubview:marginView1];
        [marginView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_midLoginView);
        }];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_midLoginView);
            make.top.mas_equalTo(marginView1.mas_bottom);
            make.width.mas_equalTo(self.iconImageView.mas_height).multipliedBy(0.734);
        }];
        
        UIView *marginView2 = [self marginView]; //60
        [_midLoginView addSubview:marginView2];
        [marginView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconImageView.mas_bottom);
            make.height.mas_equalTo(marginView1).multipliedBy(3.0);
        }];

        [self.accountTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_midLoginView).offset(16);
            make.right.mas_equalTo(_midLoginView).offset(-16);
            make.height.mas_equalTo(@30);
            make.top.mas_equalTo(marginView2.mas_bottom);
        }];
        
        [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.accountTextFiled);
            make.right.mas_equalTo(self.accountTextFiled);
            make.top.mas_equalTo(self.accountTextFiled.mas_bottom).offset(30);
            make.height.mas_equalTo(@30);
        }];
        
        UIView *marginView3 = [self marginView]; //50
        [_midLoginView addSubview:marginView3];
        [marginView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwordTextFiled.mas_bottom);
            make.height.mas_equalTo(marginView1).multipliedBy(2.5);
        }];
        
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_midLoginView).offset(16);
            make.right.mas_equalTo(_midLoginView).offset(-16);
            make.top.mas_equalTo(marginView3.mas_bottom);
            make.height.mas_equalTo(@45);
        }];
        
        [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.loginBtn);
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(5);
        }];
        
        [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.loginBtn);
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(5);
        }];
        
        UIView *marginView4 = [self marginView]; //30
        [_midLoginView addSubview:marginView4];
        [marginView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.registBtn.mas_bottom);
            make.bottom.mas_equalTo(_midLoginView);
            make.height.mas_equalTo(marginView1).multipliedBy(1.5);
        }];
        
    }
    return _midLoginView;
}

- (UIView *)marginView
{
    UIView *marginView = [[UIView alloc] init];
    marginView.backgroundColor = Color_Clear;
    return marginView;
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
