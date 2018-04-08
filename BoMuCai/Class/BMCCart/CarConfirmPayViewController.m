//
//  CarConfirmPayViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarConfirmPayViewController.h"
#import "BXHAlertViewController.h"
#import "CarPayResultViewController.h"

#import "CarPayCouponCell.h"
#import "CarPayTypeCell.h"
#import "CarPayPriceCell.h"
#import "CarPayTypeHeaderView.h"
#import "CarPayTypeModel.h"
#import "CarPayBtnFooterView.h"

#import "CartPayOrderCreatRequest.h"

#import "BXHPayUtil.h"
#import "BXHWXPayUtil.h"
#import "BXHBankPayManager.h"

#import "UIDevice+BXHCategory.h"

@implementation CarConfrimPayModel



@end

@interface CarConfirmPayViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *payTypeAry;

@property (nonatomic, strong) CarPayTypeHeaderView *headerView;

//@property (nonatomic, strong) CarPayCouponCell *couponCell;

@property (nonatomic, strong) CarPayPriceCell *priceCell;

@property (nonatomic, strong) CarPayBtnFooterView *footerView;

@property (nonatomic, strong) CarConfrimPayModel *payModel;

@property (nonatomic, copy) NSString *payCode;

@end

@implementation CarConfirmPayViewController

- (instancetype)initWithCarConfirmPayModel:(CarConfrimPayModel *)model
{
    if (self = [super init])
    {
        self.payModel = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"确认支付";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CarPayTypeList" ofType:@"plist"];
    self.payTypeAry = [CarPayTypeModel bxhObjectArrayWithKeyValuesArray: [NSArray arrayWithContentsOfFile:path]];
    
    self.priceCell.couponPriceLabel.text = [NSString stringWithFormat:@"-￥%@",MoneyDeal(self.payModel.couponPrice)];
    self.priceCell.frePriceLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(self.payModel.yunfei)];
    if (!StringIsEmpty(self.payModel.realAmount) && [self.payModel.realAmount integerValue] != [self.payModel.amount integerValue])
    {
        self.priceCell.orginalPriceLabel.text = [NSString stringWithFormat:@"（修改前￥%@）",MoneyDeal(self.payModel.amount)];
        self.priceCell.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(self.payModel.realAmount)];
        NSString *payMoney = _StrFormate(@"%lf",[self.payModel.realAmount doubleValue] + [self.payModel.yunfei doubleValue] - [self.payModel.couponPrice doubleValue]);
        self.priceCell.payPriceLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(payMoney)];

    }
    else
    {
        self.priceCell.orginalPriceLabel.text = @"";
        self.priceCell.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(self.payModel.amount)];
        self.priceCell.currentPriceLabel.textColor = Color_MainText;
        NSString *payMoney = _StrFormate(@"%lf",[self.payModel.amount doubleValue] + [self.payModel.yunfei doubleValue] - [self.payModel.couponPrice doubleValue]);
        self.priceCell.payPriceLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(payMoney)];

    }
//    self.priceCell =
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)payBtnAction
{
    if (!StringIsEmpty(self.payModel.realAmount) && [self.payModel.realAmount integerValue] != [self.payModel.amount integerValue])
    {
        BXHAlertViewController *alert = [BXHAlertViewController alertControllerWithTitle:@"" type:BXHAlertMessageType];
        alert.message = @"您购买的宝贝修改了价格";
        
        __weak typeof(self) weakSelf = self;
        BXHAlertAction *alertAction = [BXHAlertAction actionWithTitle:@"继续支付" titleColor:Color_MainText handler:^(BXHAlertAction *action) {
            BXHStrongObj(weakSelf);
            [weakSelfStrong payStart];
        }];
        
        BXHAlertAction *alertAction1 = [BXHAlertAction actionWithTitle:@"取消" titleColor:Color_Main_Dark handler:^(BXHAlertAction *action) {
        }];
        [alert addAction:alertAction];
        [alert addAction:alertAction1];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self payStart];
    }
}

- (void)payStart
{
    
    CartPayOrderCreatRequest *request = [[CartPayOrderCreatRequest alloc] init];
    request.orderId = self.payModel.orderId;
    request.payType = self.payCode;
    if ([self.payCode isEqualToString:@"01700002"])
    {
        request.spbillCreateIp = [UIDevice currentDevice].ipAddressCell;
    }
    ProgressShow(self.view);
    BXHWeakObj(self);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(selfWeak.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            if ([selfWeak.payCode isEqualToString:@"01700001"])
            {
                [selfWeak alipayActionWithSignStr:request.response.data];
            }
            else if ([selfWeak.payCode isEqualToString:@"01700002"])
            {
                [selfWeak wxpayWithPayModel:[BCPayModel bxhObjectWithKeyValues:request.response.data]];
            }
            else if ([selfWeak.payCode isEqualToString:@"01700003"])
            {
                [selfWeak bankCardPayActionWithTn:request.response.data];
            }
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(selfWeak.view);
        ToastShowBottom(NetWorkErrorTip);
    }];

    
}

- (void)wxpayWithPayModel:(BCPayModel *)payModel
{
    BXHWeakObj(self);
    [[BXHWXPayUtil shareInstance] startPayWithPayModel:payModel withCallBack:^(BOOL sucdess, NSString *message) {
        CarPayResultViewController *vc = [[CarPayResultViewController alloc] initWithResultSuccess:sucdess];
        [selfWeak.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)alipayActionWithSignStr:(NSString *)signStr
{
    BXHWeakObj(self);
    [[BXHPayUtil shareInstance] payWithSignOrderString:signStr complete:^(NSDictionary *resultDic) {
        BXHPayResultUtil *result = [[BXHPayResultUtil alloc] initWithAliPayResult:resultDic];
        CarPayResultViewController *vc = [[CarPayResultViewController alloc] initWithResultSuccess:result.success];
        [selfWeak.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)bankCardPayActionWithTn:(NSString *)tn
{
    BXHWeakObj(self);
    [[BXHBankPayManager defaultManager] startPayWithTn:tn formViewController:self andComplete:^(NSString *code, NSDictionary *data) {
        if([code isEqualToString:@"success"])
        {
            CarPayResultViewController *vc = [[CarPayResultViewController alloc] initWithResultSuccess:YES];
            [selfWeak.navigationController pushViewController:vc animated:YES];
        }
        else if([code isEqualToString:@"fail"])
        {
            CarPayResultViewController *vc = [[CarPayResultViewController alloc] initWithResultSuccess:NO];
            [selfWeak.navigationController pushViewController:vc animated:YES];
        }
        else if([code isEqualToString:@"cancel"])
        {
            CarPayResultViewController *vc = [[CarPayResultViewController alloc] initWithResultSuccess:NO];
            [selfWeak.navigationController pushViewController:vc animated:YES];
        }

    }];
}

#pragma mark - delegate / dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return self.payTypeAry.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 8;
    }
    else
    {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 8;
    }
    else
    {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 128;
    }
    else
    {
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return self.headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return self.priceCell;
    }
    else
    {
        CarPayTypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:[CarPayTypeCell className]];
        if(!typeCell)
        {
            typeCell = [CarPayTypeCell ct_cellWithTableViewFromXIB:tableView indentifier:[CarPayTypeCell className]];
        }
        typeCell.weakModel = self.payTypeAry[indexPath.row];
        return typeCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1)
    {
        self.footerView.payBtn.enabled = YES;
        for (int i = 0; i < self.payTypeAry.count; i ++)
        {
            CarPayTypeModel *model = self.payTypeAry[i];
            model.select = i == indexPath.row ? @1 : @0;
            if (i == indexPath.row)
            {
                self.payCode = model.code;
            }
        }
        NSIndexSet *sectionSet = [NSIndexSet indexSetWithIndex:1];
        [tableView reloadSections:sectionSet withRowAnimation:UITableViewRowAnimationNone];
    }
}


#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREENWIDTH, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}


- (CarPayTypeHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[CarPayTypeHeaderView alloc] init];
    }
    return _headerView;
}

- (CarPayPriceCell *)priceCell
{
    if(!_priceCell)
    {
        _priceCell = [CarPayPriceCell viewFromXIB];
    }
    return _priceCell;
}

//- (CarPayCouponCell *)couponCell
//{
//    if (!_couponCell)
//    {
//        _couponCell = [[CarPayCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CarPayCouponCell className]];
//    }
//    return _couponCell;
//}

- (CarPayBtnFooterView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[CarPayBtnFooterView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREENWIDTH, 120)];
        _footerView.payBtn.enabled = NO;
        [_footerView.payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
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
