//
//  ForgetViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ForgetViewController.h"

#import "ForgetPasswordViewController.h"

#import "RegistInputTextFiled.h"
#import "BXHAuthBtn.h"

#import "VerifyCodeRequest.h"

@interface ForgetViewController () <RegistInputTextFiledDelegate>

@property (nonatomic, strong) RegistInputTextFiled *phoneTextFiled;

@property (nonatomic, strong) RegistInputTextFiled *codeTextFiled;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) BXHAuthBtn *authBtn;

@end

@implementation ForgetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"忘记密码";
    
    [self.navigationController.navigationBar setBackgroundImage:ImageWithColor(Color_White) forBarMetrics:UIBarMetricsDefault];
    
    [self layoutSubviews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)layoutSubviews
{
    [self.view addSubview:self.phoneTextFiled];
    [self.view addSubview:self.codeTextFiled];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.nextBtn];
    
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(10);
        make.height.mas_equalTo(@50);
    }];
    
    [self.codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.phoneTextFiled.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.top.mas_equalTo(self.codeTextFiled.mas_bottom);
        make.height.mas_equalTo(@20);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(@40);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(60);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma makr - request
- (void)requestVerifyCode
{
    __weak typeof(self) weakSelf = self;
    VerifyCodeRequest *item = [[VerifyCodeRequest alloc] init];
    item.phone = self.phoneTextFiled.inputTextFiled.text;
    item.type = @"1";
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.authBtn startVerify:60];
            ToastShowCenter(@"验证码发送成功");
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
- (void)authBtnAction
{
    [self.view endEditing:YES];
    if (![TSRegularExpressionUtil validateMobile:self.phoneTextFiled.inputTextFiled.text])
    {
        ToastShowCenter(@"手机号格式错误");
        return;
    }
    [self requestVerifyCode];
}

- (void)nextBtnAction
{
    if (![TSRegularExpressionUtil validateMobile:self.phoneTextFiled.inputTextFiled.text])
    {
        ToastShowCenter(@"请输入正确手机号");
        return;
    }
    
    if(self.codeTextFiled.inputTextFiled.text.length != 6)
    {
        ToastShowCenter(@"验证码错误");
        return;
    }

    ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc] initWithPhone:self.phoneTextFiled.inputTextFiled.text code:self.codeTextFiled.inputTextFiled.text];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - textFiledDelegate
- (void)textFiledDidEndEditing:(RegistInputTextFiled *)textFiled
{
//    if (!StringIsEmpty(self.phoneTextFiled.inputTextFiled.text) && !StringIsEmpty(self.codeTextFiled.inputTextFiled.text))
//    {
//        self.nextBtn.enabled = YES;
//    }
//    else
//    {
//        self.nextBtn.enabled = NO;
//    }
}

#pragma mark - get
- (RegistInputTextFiled *)phoneTextFiled
{
    if (!_phoneTextFiled)
    {
        _phoneTextFiled = [[RegistInputTextFiled alloc] init];
        _phoneTextFiled.inputTextFiled.placeholder = @"请输入手机号";
        _phoneTextFiled.delegate = self;
    }
    return _phoneTextFiled;
}

- (RegistInputTextFiled *)codeTextFiled
{
    if (!_codeTextFiled)
    {
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = Color_Gray_Line;
        [rightView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rightView);
            make.top.mas_equalTo(rightView).offset(10);
            make.bottom.mas_equalTo(rightView).offset(-10);
            make.width.mas_equalTo(@1);
        }];
        
        [rightView addSubview:self.authBtn];
        [self.authBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(rightView).insets(UIEdgeInsetsMake(0, 1, 0, 0));
        }];
        
        _codeTextFiled = [[RegistInputTextFiled alloc] init];
        _codeTextFiled.inputTextFiled.placeholder = @"请输入验证码";
        _codeTextFiled.lineView.hidden = YES;
        _codeTextFiled.inputTextFiled.rightView = rightView;
        _codeTextFiled.inputTextFiled.rightViewMode = UITextFieldViewModeAlways;
        _codeTextFiled.delegate = self;
    }
    return _codeTextFiled;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = Font_sys_12;
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.text = @"(请在60秒内完成验证，超时请点击重新发送)";
    }
    return _tipLabel;
}

- (UIButton *)nextBtn
{
    if (!_nextBtn)
    {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_nextBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = Font_sys_16;
        _nextBtn.layer.cornerRadius = 6;
        _nextBtn.clipsToBounds = YES;
        [_nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        _nextBtn.enabled = NO;
    }
    return _nextBtn;
}

- (BXHAuthBtn *)authBtn
{
    if (!_authBtn)
    {
        _authBtn = [BXHAuthBtn buttonWithType:UIButtonTypeCustom];
        [_authBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        [_authBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _authBtn.titleLabel.font = Font_sys_14;
        [_authBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        [_authBtn addTarget:self action:@selector(authBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authBtn;
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
