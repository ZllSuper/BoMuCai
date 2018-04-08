//
//  CarPayResultViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarPayResultViewController.h"

@interface CarPayResultViewController ()

@property (nonatomic, assign) BOOL success;

@property (nonatomic, strong) UIImageView *imageIcon;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UILabel *subTipLabel;

@property (nonatomic, strong) UIButton *bottomBtn;

@end

@implementation CarPayResultViewController

- (instancetype)initWithResultSuccess:(BOOL)success
{
    if (self = [super init])
    {
        self.success = success;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"支付状态";
    
    if(self.success)
    {
        self.imageIcon.image = ImageWithName(@"PaySuccessIcon");
        self.tipLabel.text = @"订单支付成功";
        self.subTipLabel.text = @"您的订单支付成功，我们会尽快安排发货";
        [self.bottomBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {
        self.imageIcon.image = ImageWithName(@"PayFailIcon");
        self.tipLabel.text = @"订单支付失败";
        self.subTipLabel.text = @"请查看网路环境及支付环境是否异常";
        [self.bottomBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [self initRightNavigationItemWithTitle:@"完成" target:self action:@selector(rightBtnAction)];
    }
    
    [self.view addSubview:self.imageIcon];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.subTipLabel];
    [self.view addSubview:self.bottomBtn];
    
    [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_centerY).offset(-50);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageIcon.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.subTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.subTipLabel.mas_bottom).offset(50);
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(BaseNaviController *)self.navigationController setPopPanEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [(BaseNaviController *)self.navigationController setPopPanEnable:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)bottomBtnAction
{
    if (self.success)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightBtnAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - get
- (UIImageView *)imageIcon
{
    if (!_imageIcon)
    {
        _imageIcon = [[UIImageView alloc] init];
    }
    return _imageIcon;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = Font_sys_14;
        _tipLabel.textColor = Color_MainText;
    }
    return _tipLabel;
}

- (UILabel *)subTipLabel
{
    if (!_subTipLabel)
    {
        _subTipLabel = [[UILabel alloc] init];
        _subTipLabel.font = Font_sys_12;
        _subTipLabel.textColor = Color_Text_Gray;
    }
    return _subTipLabel;
}

- (UIButton *)bottomBtn
{
    if (!_bottomBtn)
    {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.layer.cornerRadius = 4;
        _bottomBtn.layer.masksToBounds = YES;
        [_bottomBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_bottomBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = Font_sys_14;
        [_bottomBtn addTarget:self action:@selector(bottomBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
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
