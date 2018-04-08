//
//  RegistPasswordViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "RegistPasswordViewController.h"

#import "ProtcolViewController.h"

#import "RegistInputTextFiled.h"

#import "RegistRequest.h"

@interface RegistPasswordViewController () <RegistInputTextFiledDelegate>

@property (nonatomic, strong) RegistInputTextFiled *passwordTextFiled;

@property (nonatomic, strong) RegistInputTextFiled *confirmPasswordTextFiled;

@property (nonatomic, strong) UIButton *radioBtn;

@property (nonatomic, strong) UIButton *protcolBtn;

@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *code;

@end

@implementation RegistPasswordViewController

- (instancetype)initWithPhone:(NSString *)phone code:(NSString *)code
{
    if (self = [super init])
    {
        self.phone = phone;
        self.code = code;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"输入密码";
    
    [self layoutSubViews];
    // Do any additional setup after loading the view.
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

- (void)layoutSubViews
{
    [self.view addSubview:self.passwordTextFiled];
    [self.view addSubview:self.confirmPasswordTextFiled];
    [self.view addSubview:self.radioBtn];
    [self.view addSubview:self.protcolBtn];
    [self.view addSubview:self.submitBtn];
    
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(10);
        make.height.mas_equalTo(@50);
    }];
    
    [self.confirmPasswordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passwordTextFiled);
        make.right.mas_equalTo(self.passwordTextFiled);
        make.height.mas_equalTo(@50);
        make.top.mas_equalTo(self.passwordTextFiled.mas_bottom);
    }];
    
    [self.radioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(self.view).offset(16);
        make.top.mas_equalTo(self.confirmPasswordTextFiled.mas_bottom).offset(5);
    }];
    
    [self.protcolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.radioBtn);
        make.left.mas_equalTo(self.radioBtn.mas_right).offset(5);
        make.height.mas_equalTo(@30);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(@40);
        make.top.mas_equalTo(self.radioBtn.mas_bottom).offset(50);
    }];
}

- (void)registRequest
{
    __weak typeof(self) weakSelf = self;
    RegistRequest *request = [[RegistRequest alloc] init];
    request.password = self.passwordTextFiled.inputTextFiled.text;
    request.verificationCode = self.code;
    request.phone = self.phone;
    ProgressShow(self.view);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [[EMClient sharedClient] loginWithUsername:KAccountInfo.easemob password:KAccountInfo.easemobPassword completion:^(NSString *aUsername, EMError *aError) {
                
                if (!aError) {
                    //设置是否自动登录
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    
                    ToastShowBottom(@"注册成功");
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }
                else {
                    ToastShowBottom(_StrFormate(@"环信登录失败：%@",aError.errorDescription));
                }
            }];
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
- (void)radioBtnAction
{
    self.radioBtn.selected = !self.radioBtn.selected;
    if (!StringIsEmpty(self.passwordTextFiled.inputTextFiled.text) && !StringIsEmpty(self.confirmPasswordTextFiled.inputTextFiled.text) && self.radioBtn.selected)
    {
        self.submitBtn.enabled = YES;
    }
    else
    {
        self.submitBtn.enabled = NO;
    }

}

- (void)protcolBtnAction
{
    ProtcolViewController *vc = [[ProtcolViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)submitBtnAction
{
    
    [self.view endEditing:YES];
    if (![self.passwordTextFiled.inputTextFiled.text isEqualToString:self.confirmPasswordTextFiled.inputTextFiled.text])
    {
        ToastShowBottom(@"两次输入的密码不一样");
        return;
    }
    
    if (![TSRegularExpressionUtil validatePassword:self.passwordTextFiled.inputTextFiled.text])
    {
        ToastShowBottom(@"密码格式不正确");
        return;
    }

    if(!self.radioBtn.selected)
    {
        ToastShowBottom(@"请阅读并同意用户协议和法律声明");
        return;
    }
    
    [self registRequest];
}

#pragma mark - textFiledDelegate
- (void)textFiledDidEndEditing:(RegistInputTextFiled *)textFiled
{
    if (!StringIsEmpty(self.passwordTextFiled.inputTextFiled.text) && !StringIsEmpty(self.confirmPasswordTextFiled.inputTextFiled.text) && self.radioBtn.selected)
    {
        self.submitBtn.enabled = YES;
    }
    else
    {
        self.submitBtn.enabled = NO;
    }
}

#pragma mark - get
- (RegistInputTextFiled *)passwordTextFiled
{
    if (!_passwordTextFiled)
    {
        _passwordTextFiled = [[RegistInputTextFiled alloc] init];
        _passwordTextFiled.inputTextFiled.placeholder = @"密码  (6~16数字和字母组成)";
        _passwordTextFiled.inputTextFiled.secureTextEntry = YES;
        _passwordTextFiled.delegate = self;
    }
    return _passwordTextFiled;
}

- (RegistInputTextFiled *)confirmPasswordTextFiled
{
    if (!_confirmPasswordTextFiled)
    {
        _confirmPasswordTextFiled = [[RegistInputTextFiled alloc] init];
        _confirmPasswordTextFiled.inputTextFiled.placeholder = @"确认密码  (需要同密码一致)";
        _confirmPasswordTextFiled.lineView.hidden = YES;
        _confirmPasswordTextFiled.inputTextFiled.secureTextEntry = YES;
        _confirmPasswordTextFiled.delegate = self;
    }
    return _confirmPasswordTextFiled;
}

- (UIButton *)radioBtn
{
    if (!_radioBtn)
    {
        _radioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_radioBtn addTarget:self action:@selector(radioBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_radioBtn setImage:ImageWithName(@"RadioNormal") forState:UIControlStateNormal];
        [_radioBtn setImage:ImageWithName(@"RadioSel") forState:UIControlStateSelected];
    }
    return _radioBtn;
}

- (UIButton *)protcolBtn
{
    if (!_protcolBtn)
    {
        _protcolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protcolBtn addTarget:self action:@selector(protcolBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_protcolBtn setTitle:@"同意《用户协议》和《法律声明》" forState:UIControlStateNormal];
        _protcolBtn.titleLabel.font = Font_sys_12;
        [_protcolBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _protcolBtn;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn)
    {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = Font_sys_16;
        _submitBtn.layer.cornerRadius = 6;
        _submitBtn.clipsToBounds = YES;
        [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.enabled = NO;
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
