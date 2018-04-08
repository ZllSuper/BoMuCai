//
//  PCOrderCommentViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderCommentViewController.h"

#import "PCCommentStartView.h"
#import "YMTextView.h"

#import "PCOrderCommentRequest.h"


#define MAXTextNum 500

@interface PCOrderCommentViewController ()<UITextViewDelegate>

@property (nonatomic, strong) YMTextView *textView;

@property (nonatomic, strong) UILabel *textNumLabel;

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) PCCommentStartView *starView;

@property (nonatomic, copy) NSString *orderId;

@end

@implementation PCOrderCommentViewController

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
    
    self.title = @"评价订单";
    
    [self creatSubviews];
    // Do any additional setup after loading the view.
    
    [self.starView.iconImageView sd_setImageWithURL:[NSURL encodeURLWithString:self.iconImageUrl] placeholderImage:ImagePlaceHolder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)creatSubviews
{
    [self.view addSubview:self.starView];
    
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
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
        make.top.mas_equalTo(self.starView.mas_bottom).offset(8);
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
    [self.view endEditing:YES];
    
    if (StringIsEmpty(self.textView.text))
    {
        ToastShowBottom(@"请输入评价");
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    PCOrderCommentRequest *item = [[PCOrderCommentRequest alloc] init];
    item.userId = KAccountInfo.userId;
//    item.mdseId = self.orderModel.oid;
    item.mdseId = self.orderId;
    item.starLevel = [NSString stringWithFormat:@"%d",(int)(self.starView.rateView.scorePercent * 5)];
    item.introduce = self.textView.text;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.navigationController popViewControllerAnimated:YES];
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
        self.sureBtn.enabled = NO;
    }
    else
    {
        self.textNumLabel.textColor = Color_Text_LightGray;
        self.sureBtn.enabled = YES;
    }
    self.textNumLabel.text = _StrFormate(@"还可以输入%ld个字",num);
}

#pragma mark - Get
- (PCCommentStartView *)starView
{
    if (!_starView)
    {
        _starView = [[PCCommentStartView alloc] init];
    }
    return _starView;
}

- (YMTextView *)textView
{
    if (!_textView)
    {
        _textView = [[YMTextView alloc] init];
        _textView.font = Font_sys_14;
        _textView.placeholder = @"您对宝贝有什么评价~写出来吧~";
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
        _textNumLabel.text = @"还可以输入500个字";
    }
    return _textNumLabel;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn)
    {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = Font_sys_14;
        _sureBtn.layer.cornerRadius = 6;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.enabled = NO;
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
