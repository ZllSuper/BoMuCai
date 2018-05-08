//
//  CarOrderInputViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarOrderInputViewController.h"
#import "BMCShopViewController.h"
#import "CarConfirmPayViewController.h"
#import "PCAddressManagerViewController.h"
#import "CarCouponChooseViewController.h"

#import "CarOrderInputFooterView.h"
#import "CarSectionHeaderView.h"
#import "CarOrderInputAddressView.h"
#import "CarOrderInputCell.h"
#import "CarOrderInputBottomView.h"

#import "CartGetDefaultAddressRequest.h"
#import "CartOrderSubmitRequest.h"

#import "BMCWaresDetailViewController.h"


@interface CarOrderInputViewController () <UITableViewDelegate, UITableViewDataSource, CarSectionHeaderViewDelegate,PCAddressManagerViewControllerDelegate,CarOrderInputFooterViewProtcol,CarCouponChooseViewControllerDelegate>

@property (nonatomic, strong) CarOrderInputAddressView *addressView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CarOrderInputBottomView *bottomView;

@property (nonatomic, strong) CartPayModel *payModel;

@end

@implementation CarOrderInputViewController

- (void)dealloc
{
    self.payModel = nil;
}

- (instancetype)initWithPayModel:(CartPayModel *)model
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
    self.title = @"填写订单";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
    
    [self requestDefaultAddress];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
- (void)requestDefaultAddress
{
    __weak typeof(self) weakSelf = self;
    CartGetDefaultAddressRequest *item = [[CartGetDefaultAddressRequest alloc] init];
    item.userId = KAccountInfo.userId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.addressView reloadAddressWithModel:[PCAddressModel bxhObjectWithKeyValues:request.response.data]];
            [weakSelf.tableView reloadData];
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

- (void)orderSubmit
{
    if (!self.addressView.addressModel)
    {
        ToastShowBottom(@"请选择收货地址");
        return;
    }
    NSString *couponStr = @"";
    NSString *propertyStr = @"";
    
    for (CarShopModel *shopModel in self.payModel.shopModels)
    {
        if (couponStr.length == 0)
        {
            couponStr = shopModel.couponModel.couponId;
        }
        else
        {
            couponStr = [NSString stringWithFormat:@"%@,%@",couponStr,shopModel.couponModel.couponId];
        }
        
        for (CarGoodModel *goodModel in shopModel.cartMdseDto)
        {
            if (propertyStr.length == 0)
            {
                propertyStr = [NSString stringWithFormat:@"%@|%@",goodModel.mdsePropertyId,goodModel.amount];
            }
            else
            {
                propertyStr = [NSString stringWithFormat:@"%@,%@|%@",propertyStr,goodModel.mdsePropertyId,goodModel.amount];
            }
        }
    }


    __weak typeof(self) weakSelf = self;
    CartOrderSubmitRequest *item = [[CartOrderSubmitRequest alloc] init];
    item.couponStr = couponStr;
    item.addresId = self.addressView.addressModel.addressId;
    item.propertyStr = propertyStr;
    item.userId = KAccountInfo.userId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            CarConfrimPayModel *payModel = [CarConfrimPayModel bxhObjectWithKeyValues:request.response.data];
            CarConfirmPayViewController *vc = [[CarConfirmPayViewController alloc] initWithCarConfirmPayModel:payModel];
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

#pragma mark - action
- (void)payBtnAction
{
    [self orderSubmit];
}

- (void)addressManagerAction
{
    PCAddressManagerViewController *vc = [[PCAddressManagerViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark sectionHeaderDelegate
- (void)headerViewDidSelectAction:(CarSectionHeaderView *)headerView
{
    BMCShopModel *shopModel = [[BMCShopModel alloc] init];
    shopModel.shopId = headerView.weakModel.shopId;
    BMCShopViewController *vc = [[BMCShopViewController alloc] initWithShopModel:shopModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addressManager:(PCAddressManagerViewController *)vc addressModel:(PCAddressModel *)addressModel
{
    self.payModel.addressModel = [addressModel copy];
    [self.addressView reloadAddressWithModel:[addressModel copy]];
    self.tableView.tableHeaderView = self.addressView;
    [self.tableView reloadData];
}

#pragma mark - footerViewDelegate
- (void)footerViewCouponAction:(CarOrderInputFooterView *)footerView
{
    CarCouponChooseViewController *vc = [[CarCouponChooseViewController alloc] initWithShopModel:footerView.shopModel];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - couponDelegate
- (void)couponChooseViewController:(CarCouponChooseViewController *)vc couponModel:(ShopCouponModel *)chooseModel
{
    vc.shopModel.couponModel = chooseModel;
    
//    NSInteger payMoney = self.payModel.payMoney.integerValue;
//    for (CarShopModel *shopModel in self.payModel.shopModels) {
//        if (shopModel.couponModel) {
//            payMoney = payMoney-shopModel.couponModel.denomination.integerValue;
//        }
//    }
//    self.payModel.payMoney = _StrFormate(@"%ld",payMoney);

    [self checkHaveSelect];
    
    _bottomView.moneyLabel.text = _StrFormate(@"￥%@",MoneyDeal(self.payModel.payMoney));
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.payModel.shopModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarShopModel *shopModel = self.payModel.shopModels[section];
    return shopModel.cartMdseDto.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 124;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CarShopModel *shopModel = self.payModel.shopModels[section];
    CarSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[CarSectionHeaderView className]];
    headerView.weakModel = shopModel;
    headerView.delegate = self;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CarShopModel *shopModel = self.payModel.shopModels[section];
    CarOrderInputFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[CarOrderInputFooterView className]];
    footerView.actionProtcol = self;
    footerView.shopModel = shopModel;
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarOrderInputCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarOrderInputCell className]];
    CarShopModel *shopModel = self.payModel.shopModels[indexPath.section];
    cell.weakModel = shopModel.cartMdseDto[indexPath.row];
    // Configure the cell...
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarShopModel *shopModel = self.payModel.shopModels[indexPath.section];
    CarGoodModel *goodsModel = shopModel.cartMdseDto[indexPath.row];
    BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:goodsModel.mdsePropertyId];
    [self.navigationController pushViewController:vc animated:YES];
}
 
#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREENWIDTH, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:[CarOrderInputCell className] bundle:nil] forCellReuseIdentifier:[CarOrderInputCell className]];
        [_tableView registerClass:[CarSectionHeaderView class] forHeaderFooterViewReuseIdentifier:[CarSectionHeaderView className]];
        [_tableView registerClass:[CarOrderInputFooterView class] forHeaderFooterViewReuseIdentifier:[CarOrderInputFooterView className]];
        _tableView.tableHeaderView = self.addressView;
        
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
        }
    }
    return _tableView;
}

- (CarOrderInputAddressView *)addressView
{
    if (!_addressView)
    {
        _addressView = [[CarOrderInputAddressView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREENWIDTH, 40)];
        [_addressView reloadAddressWithModel:nil];
        [_addressView addTarget:self action:@selector(addressManagerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressView;
}

- (CarOrderInputBottomView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[CarOrderInputBottomView alloc] init];
        [_bottomView.payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _bottomView.countLabel.text = _StrFormate(@"共%ld件",self.payModel.buyNum);
        _bottomView.moneyLabel.text = _StrFormate(@"￥%@",MoneyDeal(self.payModel.payMoney));
    }
    return _bottomView;
}

#pragma mark-计算总价
- (void)checkHaveSelect
{
    NSInteger payMoney = 0;
    for (CarShopModel *shopModel in self.payModel.shopModels)
    {
        NSLog(@"--->店铺 总价:%ld ==== 运费:%ld ====  合计:%ld",shopModel.totalPrice, shopModel.totalYunFei, (shopModel.totalPrice+shopModel.totalYunFei));
        payMoney += (shopModel.totalYunFei + shopModel.totalPrice)-shopModel.couponModel.denomination.integerValue;
    }
    NSLog(@"---> 总合计:%ld <---", payMoney);
    self.payModel.payMoney = _StrFormate(@"%ld",payMoney);
}

@end
