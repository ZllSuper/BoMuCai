//
//  PCApplyRefundViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCApplyRefundViewController.h"

#import "PCCancelDelOrderRequest.h"

#import "YMTextView.h"

#define MAXTextNum 500

@interface PCApplyRefundViewController () <UITextViewDelegate>

@property (nonatomic, strong) YMTextView *textView;

@property (nonatomic, strong) UILabel *textNumLabel;

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, copy) NSString *orderId;

@end

@implementation PCApplyRefundViewController

- (instancetype)initWithOrderId:(NSString *)orderId
{
    if (self = [super init])
    {
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"退款";
    
    [self creatSubviews];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)creatSubviews
{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = Color_White;
    [self.view addSubview:backView];

    [backView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView).offset(10);
        make.left.mas_equalTo(backView).offset(10);
        make.right.mas_equalTo(backView).offset(-10);
    }];
    
    [backView addSubview:self.textNumLabel];
    [self.textNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(backView).offset(-5);
        make.top.mas_equalTo(self.textView.mas_bottom);
        make.height.mas_equalTo(@30);
        make.bottom.mas_equalTo(backView);
    }];
    
    [self.view addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom).offset(40);
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(@44);
    }];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@170);
    }];
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


#pragma mark - action

- (void)sureBtnAction
{
    if (self.textView.text.length > 0) {
        [self cancelDelRequest];
    }
    else {
        ToastShowCenter(@"请输入退款原因");
    }
}

#pragma mark - request
- (void)cancelDelRequest
{
    __weak typeof(self) weakSelf = self;
    PCCancelDelOrderRequest *request = [[PCCancelDelOrderRequest alloc] init];
    request.orderId = self.orderId;
    request.userId = KAccountInfo.userId;
    request.remark = self.textView.text;
    ProgressShow(self.view);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            PCApplyRefundResultViewController *vc = [[PCApplyRefundResultViewController alloc] init];
            vc.delegate = weakSelf.delegate;
            [weakSelf.navigationController pushViewController:vc animated:YES];
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


#pragma mark - TextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger lenth = textView.text.length;
    NSInteger num = MAXTextNum - lenth;
    if (num < 0)
    {
        self.textNumLabel.textColor = [UIColor redColor];
//        self.sureBtn.enabled = NO;
    }
    else
    {
        self.textNumLabel.textColor = Color_Text_LightGray;
//        self.sureBtn.enabled = YES;
    }
    self.textNumLabel.text = _StrFormate(@"余%ld",num);
}

#pragma mark - Get
- (YMTextView *)textView
{
    if (!_textView)
    {
        _textView = [[YMTextView alloc] init];
        _textView.font = Font_sys_14;
        _textView.placeholder = @"请输入退款原因";
        _textView.textColor = Color_MainText;
        _textView.delegate = self;
    }
    return _textView;
}

- (UILabel *)textNumLabel
{
    if (!_textNumLabel)
    {
        _textNumLabel = [[UILabel alloc] init];
        _textNumLabel.font = Font_sys_12;
        _textNumLabel.textColor = Color_Text_LightGray;
        _textNumLabel.text = @"余500";
    }
    return _textNumLabel;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn)
    {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_sureBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = Font_sys_14;
        _sureBtn.layer.cornerRadius = 6;
        _sureBtn.layer.masksToBounds = YES;
//        _sureBtn.enabled = NO;
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
    }
    return _sureBtn;
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
