//
//  PCWaitReceiveOrderDetailViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCWaitReceiveOrderDetailViewController.h"
#import "BXHAlertViewController.h"
#import "BMCShopViewController.h"
#import "PCLogisticsInfoViewController.h"
#import "PCApplyRefundViewController.h"

#import "PCOrderDetailStatueTimeCell.h"
#import "CarSectionHeaderView.h"
#import "CarOrderInputCell.h"
#import "CarOrderInputFooterView.h"
#import "PCOrderDetailBtnBottomView.h"
#import "PCOrderDetailAddressCell.h"
#import "PCOrderDetailTimeNumCell.h"

#import "PCOrderDetailRequest.h"
#import "PCCancelDelOrderRequest.h"
#import "PCOrderDetailModel.h"
#import "PCKConfirmRevRequest.h"
#import "PCOrderCommentViewController.h"
#import "PCOrderDetailStatueCell.h"
#import "PCGoodsModel.h"

@interface PCWaitReceiveOrderDetailViewController () <UITableViewDelegate, UITableViewDataSource,CarSectionHeaderViewDelegate,PCOrderDetailBtnBottomViewDelegate,PCApplyRefundResultViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PCOrderDetailStatueTimeCell *statueCell;

@property (nonatomic, strong) PCOrderDetailAddressCell *addressCell;

@property (nonatomic, strong) CarSectionHeaderView *sectionHeaderView;

@property (nonatomic, strong) CarOrderInputFooterView *footerView;

@property (nonatomic, strong) PCOrderDetailTimeNumCell *timeNumCell;

@property (nonatomic, strong) PCOrderDetailBtnBottomView *bottomView;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, strong) PCOrderDetailModel *detailModel;

@property (nonatomic, assign) BOOL commitRev;

@property (nonatomic, assign) BOOL timeEnd;
@property (nonatomic, strong) PCOrderDetailStatueCell *secStatueCell;

@end

@implementation PCWaitReceiveOrderDetailViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)timeDownAction
{
    self.timeEnd = YES;
//    self.bottomView.hidden = YES;
    [self.tableView reloadData];
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
            weakSelf.detailModel.oid = weakSelf.orderId;
            
            [weakSelf.statueCell startCountDown:[weakSelf.detailModel.endDate longLongValue] / 1000 - [[NSDate date] timeIntervalSince1970] andTimeDownCallBack:^{
                [weakSelf timeDownAction];
            }];
            
            weakSelf.timeNumCell.oneLabel.text = [NSString stringWithFormat:@"订单编号：%@",weakSelf.orderId];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[weakSelf.detailModel.updateDate longLongValue] / 1000];
            weakSelf.timeNumCell.secLabel.text = [NSString stringWithFormat:@"下单时间：%@",[date dateStrWithFormatStr:@"yyyy-MM-dd HH:mm:ss"]];
            date = [NSDate dateWithTimeIntervalSince1970:[weakSelf.detailModel.endDate longLongValue] / 1000];;
            weakSelf.timeNumCell.thirLabel.text = [NSString stringWithFormat:@"结束时间：%@",[date dateStrWithFormatStr:@"yyyy-MM-dd HH:mm:ss"]];;
            
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

#pragma mark - bottomViewDelegate
- (void)bottomView:(PCOrderDetailBtnBottomView *)bottomView btnActionAtIndex:(NSInteger)index
{
    //        01500001  待付款
    //        01500002  待发货
    //        01500003  待收货
    //        01500004  已完成
    //        01500005  已取消
    //        01500006  已失效
    //        01500007  待退款
    //        01500008  已退货
    
    if (self.commitRev == NO) {
        if(index == 0)
        {
            __weak typeof(self) weakSelf = self;
            //删除订单
            BXHAlertViewController *alert = [BXHAlertViewController alertControllerWithTitle:@"取消订单" type:BXHAlertMessageType];
            alert.message = @"是否对当前订单退款？";
            [alert addAction:[BXHAlertAction actionWithTitle:@"是" titleColor:Color_Main_Dark handler:^(BXHAlertAction *action) {
                PCApplyRefundViewController *vc = [[PCApplyRefundViewController alloc] initWithOrderId:weakSelf.orderId];
                vc.delegate = weakSelf;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }]];
            [alert addAction:[BXHAlertAction actionWithTitle:@"否" titleColor:Color_Text_Gray handler:^(BXHAlertAction *action) {
                
            }]];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        }
        else if (index == 1)
        {
            PCLogisticsInfoViewController *vc = [[PCLogisticsInfoViewController alloc] initWithOrderId:self.orderId];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            __weak typeof(self) weakSelf = self;
            BXHAlertViewController *alert = [BXHAlertViewController alertControllerWithTitle:@"确认收货" type:BXHAlertMessageType];
            alert.message = @"是否确认收货？";
            [alert addAction:[BXHAlertAction actionWithTitle:@"是" titleColor:Color_Main_Dark handler:^(BXHAlertAction *action) {
                
                PCKConfirmRevRequest *request = [[PCKConfirmRevRequest alloc] init];
                request.orderId = self.orderId;
                ProgressShow(self.view);
                [request requestWithSuccess:^( BXHBaseRequest *request) {
                    ProgressHidden(weakSelf.view);
                    if ([request.response.code isEqualToString:@"0000"])
                    {
                        weakSelf.commitRev = YES;
                        NSString *str = @"订单状态：交易完成";
                        weakSelf.statueCell.statueLabel.attributedText = [str attributStrWithTargetStr:@"交易完成" color:Color_Main_Dark];
                        weakSelf.statueCell.timeLabel.hidden = YES;
                        
                        weakSelf.bottomView = [[PCOrderDetailBtnBottomView alloc] initWithTitles:@[@"评价"]];
                        [weakSelf.view addSubview:weakSelf.bottomView];
                        weakSelf.bottomView.delegate = self;
                        
                        [weakSelf.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.and.right.and.bottom.mas_equalTo(self.view);
                            make.height.mas_equalTo(44);
                            make.top.mas_equalTo(self.tableView.mas_bottom);
                        }];
                        
                        [weakSelf orderDetailRequest];
                        ToastShowBottom(@"确认成功");
                    }
                    else
                    {
                        ToastShowBottom(request.response.message);
                    }
                } failure:^(NSError *error, BXHBaseRequest *request) {
                    ProgressHidden(weakSelf.view);
                    ToastShowBottom(NetWorkErrorTip);
                }];
            }]];
            [alert addAction:[BXHAlertAction actionWithTitle:@"否" titleColor:Color_Text_Gray handler:^(BXHAlertAction *action) {
                
            }]];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
            
        }
    }
    else {
        PCOrderCommentViewController *vc = [[PCOrderCommentViewController alloc] initWithOrderId:self.detailModel.oid];
//        vc.orderModel = bottomView.or;
        vc.iconImageUrl = [(PCGoodsModel *)self.detailModel.orderMdseDtoList.firstObject image];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

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
        if (self.timeEnd)
        {
            return [PCOrderDetailStatueCell cellHeight];
        }
        else
        {
            return [PCOrderDetailStatueTimeCell cellHeight];
        }
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
        if (self.timeEnd)
        {
            return self.secStatueCell;
        }
        else
        {
            return self.statueCell;
        }
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
    }
    return _tableView;
}

- (PCOrderDetailStatueTimeCell *)statueCell
{
    if (!_statueCell)
    {
        _statueCell = [PCOrderDetailStatueTimeCell viewFromXIB];
        NSString *str = @"订单状态：待收货";
        _statueCell.statueLabel.attributedText = [str attributStrWithTargetStr:@"待收货" color:Color_Main_Dark];
    }
    return _statueCell;
}

- (PCOrderDetailStatueCell *)secStatueCell
{
    if (!_secStatueCell)
    {
        _secStatueCell = [PCOrderDetailStatueCell viewFromXIB];
        NSString *str = @"订单状态：待收货";
        _secStatueCell.statueLabel.attributedText = [str attributStrWithTargetStr:@"待收货" color:Color_Main_Dark];
    }
    return _secStatueCell;
}

- (PCOrderDetailAddressCell *)addressCell
{
    if (!_addressCell)
    {
        _addressCell = [[PCOrderDetailAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PCOrderDetailAddressCell className]];

    }
    return _addressCell;
}

- (CarSectionHeaderView *)sectionHeaderView
{
    if (!_sectionHeaderView)
    {
        _sectionHeaderView = [[CarSectionHeaderView alloc] initWithReuseIdentifier:[CarSectionHeaderView className]];
        _sectionHeaderView.delegate = self;
    }
    return _sectionHeaderView;
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

- (PCOrderDetailBtnBottomView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[PCOrderDetailBtnBottomView alloc] initWithTitles:@[@"取消订单",@"查看物流",@"确认收货"]];
        _bottomView.delegate = self;
    }
    return _bottomView;
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
