//
//  PCFeedBackViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCFeedBackViewController.h"
#import "PCFeedBackSelView.h"
#import "PCFeedbackGoodsNumView.h"
#import "PCFeedBackTextView.h"
#import "PCFeedBackRequest.h"

@interface PCFeedBackViewController ()

@property (nonatomic, strong) PCFeedBackSelView *selView;

@property (nonatomic, strong) PCFeedbackGoodsNumView *numView;

@property (nonatomic, strong) PCFeedBackTextView *textView;

@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation PCFeedBackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    [self creatSubViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.contentScrollView registerAsDodgeViewForMLInputDodger];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.contentScrollView unregisterAsDodgeViewForMLInputDodger];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatSubViews
{
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [self.contentScrollView addSubview:self.selView];
    [self.contentScrollView addSubview:self.numView];
    [self.contentScrollView addSubview:self.textView];
    [self.contentScrollView addSubview:self.submitBtn];
    [self.contentScrollView addSubview:self.tipLabel];
    [self.contentScrollView addSubview:self.phoneBtn];
    
    [self.selView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentScrollView).offset(8);
        make.left.and.right.mas_equalTo(self.contentScrollView);
        make.width.mas_equalTo(DEF_SCREENWIDTH);
        make.height.mas_equalTo(85);
    }];
    
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.contentScrollView);
        make.top.mas_equalTo(self.selView.mas_bottom).offset(8);
        make.height.mas_equalTo(44);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.contentScrollView);
        make.top.mas_equalTo(self.numView.mas_bottom).offset(8);
        make.height.mas_equalTo(120);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentScrollView).offset(16);
        make.right.mas_equalTo(self.contentScrollView).offset(-16);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(30);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentScrollView);
        make.top.mas_equalTo(self.submitBtn.mas_bottom).offset(30);
    }];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentScrollView);
        make.top.mas_equalTo(self.tipLabel.mas_bottom);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(150);
        make.bottom.mas_equalTo(self.contentScrollView).offset(-20);
    }];
    
    [self.phoneBtn addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - request
- (void)requestFeedBack
{
    __weak typeof(self) weakSelf = self;
    PCFeedBackRequest *item = [[PCFeedBackRequest alloc] init];
    item.userId = KAccountInfo.userId;
    item.qDescription = self.textView.textView.text;
    item.mdseId = self.numView.goodsNumTextFiled.text;
    if (self.selView.complaintBtn.selected)
    {
        item.flag = @"0";
    }
    else if (self.selView.experienceBtn.selected)
    {
        item.flag = @"1";
    }
    else
    {
        item.flag = @"";
    }
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

#pragma mark - action
- (void)submitAction
{
    [self requestFeedBack];
}

#pragma mark - get
- (PCFeedBackSelView *)selView
{
    if (!_selView)
    {
        _selView = [PCFeedBackSelView viewFromXIB];
    }
    return _selView;
}

- (PCFeedbackGoodsNumView *)numView
{
    if (!_numView)
    {
        _numView = [[PCFeedbackGoodsNumView alloc] init];
    }
    return _numView;
}

- (PCFeedBackTextView *)textView
{
    if (!_textView)
    {
        _textView = [[PCFeedBackTextView alloc] init];
    }
    return _textView;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn)
    {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:Color_White forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 6;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.titleLabel.font = Font_sys_14;
        [_submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = Color_Text_Gray;
        _tipLabel.font = Font_sys_14;
        _tipLabel.text = @"您也可以拨打电话联系我们";
    }
    return _tipLabel;
}

- (UIButton *)phoneBtn
{
    if (!_phoneBtn)
    {
        NSString *tipStr = @"180-3188-3945";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tipStr];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [str addAttribute:NSFontAttributeName value:Font_sys_14 range:strRange];
        [str addAttribute:NSForegroundColorAttributeName value:Color_Main_Dark range:strRange];
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _phoneBtn;
}

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView)
    {
        _contentScrollView = [[UIScrollView alloc] init];
    }
    return _contentScrollView;
}

- (void)phoneButtonAction
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18031883945"]];
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
