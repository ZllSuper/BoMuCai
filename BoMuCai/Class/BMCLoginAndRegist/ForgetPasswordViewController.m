//
//  ForgetPasswordViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ForgetPasswordViewController.h"

#import "RegistInputTextFiled.h"

#import "ForgetPasswordRequest.h"

@interface ForgetPasswordViewController ()<RegistInputTextFiledDelegate>

@property (nonatomic, strong) RegistInputTextFiled *passwordTextFiled;

@property (nonatomic, strong) RegistInputTextFiled *confirmPasswordTextFiled;

@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *code;

@end

@implementation ForgetPasswordViewController

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

    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(@40);
        make.top.mas_equalTo(self.confirmPasswordTextFiled.mas_bottom).offset(60);
    }];
}

#pragma mark - request
- (void)forgetPasswordRequest
{
    __weak typeof(self) weakSelf = self;
    ForgetPasswordRequest *item = [[ForgetPasswordRequest alloc] init];
    item.phone = self.phone;
    item.password = self.passwordTextFiled.inputTextFiled.text;
    item.verificationCode = self.code;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            ToastShowCenter(@"修改成功");
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            
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

#pragma mark - action

- (void)submitBtnAction
{
    [self.view endEditing:YES];
    if (![self.passwordTextFiled.inputTextFiled.text isEqualToString:self.confirmPasswordTextFiled.inputTextFiled.text])
    {
        ToastShowCenter(@"两次密码输入不一致");
        return;
    }
    
    if (![TSRegularExpressionUtil validatePassword:self.passwordTextFiled.inputTextFiled.text])
    {
        ToastShowCenter(@"请输入6～16位数字和字母密码");
        return;
    }
    [self forgetPasswordRequest];
}

#pragma mark - textFiledDelegate
- (void)textFiledDidEndEditing:(RegistInputTextFiled *)textFiled
{
//    if (!StringIsEmpty(self.passwordTextFiled.inputTextFiled.text) && !StringIsEmpty(self.confirmPasswordTextFiled.inputTextFiled.text))
//    {
//        self.submitBtn.enabled = YES;
//    }
//    else
//    {
//        self.submitBtn.enabled = NO;
//    }
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
//        _submitBtn.enabled = NO;
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
