//
//  PCAccountTextEditViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAccountTextEditViewController.h"
#import "PCEditUserInfoRequest.h"

@interface PCAccountTextEditViewController ()

@property (nonatomic, strong) UITextField *textFiled;

@property (nonatomic, copy) NSString *propertyName;

@property (nonatomic, weak) PCAccountModel *weakModel;

@property (nonatomic, copy) ValidEnterText valid;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation PCAccountTextEditViewController

- (instancetype)initWithTitle:(NSString *)title accountModel:(PCAccountModel *)model propertyName:(NSString *)properTyName
{
    if (self = [super init])
    {
        self.title = title;
        self.weakModel = model;
        self.propertyName = properTyName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initRightNavigationItemWithTitle:@"确定" target:self action:@selector(rightBtnAction)];
    
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = Color_White;
    [self.view addSubview:self.backView];
    [self.view addSubview:self.tipLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(8);
        make.height.mas_equalTo(44);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.top.mas_equalTo(self.backView.mas_bottom).offset(5);
    }];
    
    [self.backView addSubview:self.textFiled];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(self.backView);
        make.left.mas_equalTo(self.backView).offset(16);
        make.right.mas_equalTo(self.backView).offset(-16);
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textFiled becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)validEnterText:(ValidEnterText)valid
{
    self.valid = valid;
}

#pragma mark - request
- (void)updateUserInfoRequest
{
    __weak typeof(self) weakSelf = self;
    PCEditUserInfoRequest *infoRequest = [[PCEditUserInfoRequest alloc] init];
    infoRequest.userId = KAccountInfo.userId;
    [infoRequest setValue:self.textFiled.text forKey:self.propertyName];
    ProgressShow(self.view);
    [infoRequest requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.weakModel setValue:weakSelf.textFiled.text forKey:self.propertyName];
            [weakSelf.delegate accountInfoEditSuccess:weakSelf];
            [weakSelf.navigationController popViewControllerAnimated:weakSelf];

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
- (void)rightBtnAction
{
    [self.view endEditing:YES];
    if (self.valid)
    {
        BOOL success = self.valid(self.textFiled.text);
        if (!success)
        {
            [UIView shakeViewHorizontal:self.backView];
            self.tipLabel.hidden = NO;
            return;
        }
    }
    
    [self updateUserInfoRequest];
}

#pragma mark - set / get
- (UITextField *)textFiled
{
    if (!_textFiled)
    {
        _textFiled = [[UITextField alloc] init];
        _textFiled.clearButtonMode = UITextFieldViewModeAlways;
        _textFiled.font = Font_sys_14;
        _textFiled.textColor = Color_MainText;
        _textFiled.text = CheckString([self.weakModel valueForKey:self.propertyName]);
    }
    return _textFiled;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.text = @"请输入正确的格式";
        _tipLabel.font = Font_sys_12;
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
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
