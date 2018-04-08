//
//  PCApplyRefundResultViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCApplyRefundResultViewController.h"

@interface PCApplyRefundResultViewController ()

@property (nonatomic, strong) UIImageView *imageIcon;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *bottomBtn;

@property (nonatomic, strong) UILabel *subTipLabel;

@end

@implementation PCApplyRefundResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageIcon.image = ImageWithName(@"PCRefundResult");
    self.tipLabel.text = @"申请成功！";
    self.subTipLabel.text = @"请等待卖家确认，卖家确\n认退款后，您的货款将原路退回";
    [self.bottomBtn setTitle:@"返回" forState:UIControlStateNormal];

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
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [(BaseNaviController *)self.navigationController setPopPanEnable:NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [(BaseNaviController *)self.navigationController setPopPanEnable:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)bottomBtnAction
{
    [self popToViewController:[self.delegate class]];
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
        _subTipLabel.numberOfLines = 2;
        _subTipLabel.textAlignment = NSTextAlignmentCenter;
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
