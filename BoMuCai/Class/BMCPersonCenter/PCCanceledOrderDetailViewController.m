//
//  PCWaitRefundOrderDetailViewController.m
//  BoMuCai
//
//  Created by liangliang.zhu on 2018/3/7.
//  Copyright © 2018年 woshishui. All rights reserved.
//

#import "PCCanceledOrderDetailViewController.h"
#import "BXHAlertViewController.h"
#import "BMCShopViewController.h"
#import "PCOrderCommentViewController.h"
#import "PCLogisticsInfoViewController.h"
#import "PCApplyRefundViewController.h"

#import "PCOrderDetailStatueTimeCell.h"
#import "CarSectionHeaderView.h"
#import "CarOrderInputCell.h"
#import "OrderFooterView.h"
#import "PCOrderDetailPhoneBottomView.h"
#import "PCOrderDetailReasonCell.h"
#import "PCOrderDetailTimeNumCell.h"

#import "PCBackOrderDetailRequest.h"
#import "PCOrderDetailRequest.h"

#import "PCOrderDetailModel.h"
#import "PCOrderDetailStatueCell.h"
#import "PCOrderDetailAddressCell.h"
#import "CarOrderInputFooterView.h"

@interface PCCanceledOrderDetailViewController () <UITableViewDelegate, UITableViewDataSource,CarSectionHeaderViewDelegate,PCApplyRefundResultViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) PCOrderDetailStatueTimeCell *statueCell;

@property (nonatomic, strong) PCOrderDetailStatueCell *statueSecCell;

@property (nonatomic, strong) PCOrderDetailAddressCell *addressCell;

@property (nonatomic, strong) CarSectionHeaderView *sectionHeaderView;

@property (nonatomic, strong) CarOrderInputFooterView *footerView;

@property (nonatomic, strong) PCOrderDetailTimeNumCell *timeNumCell;

@property (nonatomic, strong) PCOrderDetailPhoneBottomView *bottomView;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, strong) PCOrderDetailModel *detailModel;

@end

@implementation PCCanceledOrderDetailViewController

- (instancetype)initWithOrderId:(NSString *)orderId
{
    if ([self init])
    {
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订单详情";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
    
    [self orderDetailRequest];
    // Do any additional setup after loading the view.
}

#pragma mark - request
- (void)orderDetailRequest
{
    __weak typeof(self) weakSelf = self;
    
    PCOrderDetailRequest *item = [[PCOrderDetailRequest alloc] init];
    item.orderId = self.orderId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.detailModel = [PCOrderDetailModel bxhObjectWithKeyValues:request.response.data];
            
            NSString *str = [NSString stringWithFormat:@"订单状态：%@",weakSelf.detailModel.orderStatusName];
            NSAttributedString *attribute = [str attributStrWithTargetStr:weakSelf.detailModel.orderStatusName color:Color_Main_Dark];
            
            //            if ([weakSelf.detailModel.orderStatus isEqualToString:@"02000001"] || [weakSelf.detailModel.orderStatus isEqualToString:@"02000002"])
            //            {
            //                _statueCell.statueLabel.attributedText = attribute;
            //                [weakSelf.statueCell startCountDown:[weakSelf.detailModel.endDate longLongValue] / 1000 - [[NSDate date] timeIntervalSince1970] andTimeDownCallBack:^{
            //                    //                weakSelf.bottomView.hidden = YES;
            //                }];
            //            }
            //            else
            //            {
            _statueSecCell.statueLabel.attributedText = attribute;
            //            }
            
            
            weakSelf.timeNumCell.oneLabel.text = [NSString stringWithFormat:@"退款编号：%@",weakSelf.detailModel.oid];
            //            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[weakSelf.detailModel.updateDate longLongValue] / 1000];
            weakSelf.timeNumCell.secLabel.text = [NSString stringWithFormat:@"申请时间：%@",@""];
            //            date = [NSDate dateWithTimeIntervalSince1970:[weakSelf.detailModel.endDate longLongValue] / 1000];
            weakSelf.timeNumCell.thirLabel.text = [NSString stringWithFormat:@"确认时间：%@",@""];
            
            weakSelf.sectionHeaderView.titleLabel.text = weakSelf.detailModel.shopName;
            
            weakSelf.footerView.couponView.couponLabel.text = StringIsEmpty(weakSelf.detailModel.couponPrice) ? @"-¥ 0.00" : [NSString stringWithFormat:@"-¥ %@", weakSelf.detailModel.couponPrice];
            weakSelf.footerView.couponView.showCoupon = !StringIsEmpty(weakSelf.detailModel.couponName);
            weakSelf.footerView.countLabel.text = [NSString stringWithFormat:@"共计%@件宝贝",weakSelf.detailModel.shopBuyNum];
            weakSelf.footerView.totalPriceLabel.text = MoneyDeal([NSString stringWithFormat:@"%ld",[weakSelf.detailModel.realAmount integerValue] + [weakSelf.detailModel.yunfei integerValue] - [weakSelf.detailModel.couponPrice integerValue]]);
            weakSelf.footerView.frePriceLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(weakSelf.detailModel.yunfei)];
            
            weakSelf.addressCell.nameLabel.text = weakSelf.detailModel.orderDto.name;
            weakSelf.addressCell.phoneLabel.text = weakSelf.detailModel.orderDto.phone;
            weakSelf.addressCell.detailAddressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",weakSelf.detailModel.orderDto.province,weakSelf.detailModel.orderDto.city,weakSelf.detailModel.orderDto.area,weakSelf.detailModel.orderDto.address];
            
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - bottomViewDelegate


- (void)headerViewDidSelectAction:(CarSectionHeaderView *)headerView
{
    BMCShopModel *shopModel = [[BMCShopModel alloc] init];
    shopModel.shopId = self.detailModel.shopId;
    BMCShopViewController *shopVc = [[BMCShopViewController alloc] initWithShopModel:shopModel];
    [self.navigationController pushViewController:shopVc animated:YES];
}

#pragma mark - tableViewDelegate / DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return self.detailModel.orderMdseDtoList.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 40;
    }
    else if (section == 3 || section == 0)
    {
        return 0.1;
    }
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        //        return 83;
        return 124;
    }
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2)
    {
        return self.sectionHeaderView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        return self.footerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [PCOrderDetailStatueCell cellHeight];
    }
    else if (indexPath.section == 1)
    {
        return [PCOrderDetailAddressCell cellHeight];
    }
    else if (indexPath.section == 2)
    {
        return 100;
    }
    else
    {
        return [PCOrderDetailTimeNumCell cellHeight];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return self.statueSecCell;
    }
    else if (indexPath.section == 1)
    {
        return self.addressCell;
    }
    else if (indexPath.section == 2)
    {
        PCGoodsModel *goodsModel = self.detailModel.orderMdseDtoList[indexPath.row];
        CarOrderInputCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarOrderInputCell className]];
        cell.nameLabel.text = goodsModel.name;
        [cell.iconImageView sd_setImageWithURL:[NSURL encodeURLWithString:goodsModel.image] placeholderImage:ImagePlaceHolder];
        cell.moneyLabel.text = _StrFormate(@"￥%@",MoneyDeal(goodsModel.unitPrice));
        cell.numLabel.text = _StrFormate(@"编号：%@",goodsModel.goodsId);
        cell.sizeLabel.text = _StrFormate(@"型号：%@",goodsModel.propertyValueName);
        //    self.sizeLabel.hidden = [weakModel.stock integerValue] > 0;
        cell.countLabel.text = [NSString stringWithFormat:@"x%@",goodsModel.buyNum];
        
        return cell;
    }
    else
    {
        return self.timeNumCell;
    }
}

#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:[CarOrderInputCell className] bundle:nil] forCellReuseIdentifier:[CarOrderInputCell className]];
        [_tableView registerNib:[UINib nibWithNibName:[PCOrderDetailReasonCell className] bundle:nil] forCellReuseIdentifier:[PCOrderDetailReasonCell className]];
    }
    return _tableView;
}

- (PCOrderDetailStatueCell *)statueSecCell
{
    if (!_statueSecCell)
    {
        _statueSecCell = [PCOrderDetailStatueCell viewFromXIB];
        NSString *str = @"订单状态：已取消";
        _statueSecCell.statueLabel.attributedText = [str attributStrWithTargetStr:@"已取消" color:Color_Main_Dark];    }
    return _statueSecCell;
}

- (CarSectionHeaderView *)sectionHeaderView
{
    if (!_sectionHeaderView)
    {
        _sectionHeaderView = [[CarSectionHeaderView alloc] initWithReuseIdentifier:[CarSectionHeaderView className]];
        _sectionHeaderView.delegate = self;
        //        _sectionHeaderView.titleLabel.text = @"衡水建材";
    }
    return _sectionHeaderView;
}

- (PCOrderDetailAddressCell *)addressCell
{
    if (!_addressCell)
    {
        _addressCell = [[PCOrderDetailAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PCOrderDetailAddressCell className]];
    }
    return _addressCell;
}

- (CarOrderInputFooterView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[CarOrderInputFooterView alloc] initWithReuseIdentifier:[CarOrderInputFooterView className]];
    }
    return _footerView;
}

- (PCOrderDetailTimeNumCell *)timeNumCell
{
    if (!_timeNumCell)
    {
        _timeNumCell = [PCOrderDetailTimeNumCell viewFromXIB];
    }
    return _timeNumCell;
}

- (PCOrderDetailPhoneBottomView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[PCOrderDetailPhoneBottomView alloc] init];
    }
    return _bottomView;
}

@end

