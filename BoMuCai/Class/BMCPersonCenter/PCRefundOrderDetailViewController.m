//
//  PCRefundOrderDetailViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCRefundOrderDetailViewController.h"
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

#import "PCBackOrderModel.h"
#import "PCOrderDetailStatueCell.h"
#import "PCOrderDetailAddressCell.h"

@interface PCRefundOrderDetailViewController () <UITableViewDelegate, UITableViewDataSource,CarSectionHeaderViewDelegate,PCApplyRefundResultViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) PCOrderDetailStatueTimeCell *statueCell;

@property (nonatomic, strong) PCOrderDetailStatueCell *statueSecCell;

@property (nonatomic, strong) PCOrderDetailAddressCell *addressCell;

@property (nonatomic, strong) CarSectionHeaderView *sectionHeaderView;

@property (nonatomic, strong) OrderFooterView *footerView;

@property (nonatomic, strong) PCOrderDetailTimeNumCell *timeNumCell;

@property (nonatomic, strong) PCOrderDetailPhoneBottomView *bottomView;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, strong) PCBackOrderModel *detailModel;

@end

@implementation PCRefundOrderDetailViewController

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
    
    PCBackOrderDetailRequest *item = [[PCBackOrderDetailRequest alloc] init];
    item.orderId = self.orderId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.detailModel = [PCBackOrderModel bxhObjectWithKeyValues:request.response.data];
            
            NSString *str = [NSString stringWithFormat:@"订单状态：%@",weakSelf.detailModel.rejectedStatusName];
            NSAttributedString *attribute = [str attributStrWithTargetStr:weakSelf.detailModel.rejectedStatusName color:Color_Main_Dark];
            
//            if ([weakSelf.detailModel.rejectedStatus isEqualToString:@"02000001"] || [weakSelf.detailModel.rejectedStatus isEqualToString:@"02000002"])
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
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[weakSelf.detailModel.createDate longLongValue] / 1000];
            weakSelf.timeNumCell.secLabel.text = [NSString stringWithFormat:@"申请时间：%@",[date dateStrWithFormatStr:@"yyyy-MM-dd HH:mm:ss"]];
            date = [NSDate dateWithTimeIntervalSince1970:[weakSelf.detailModel.endDate longLongValue] / 1000];
            weakSelf.timeNumCell.thirLabel.text = [NSString stringWithFormat:@"确认时间：%@",[date dateStrWithFormatStr:@"yyyy-MM-dd HH:mm:ss"]];;
            
            weakSelf.sectionHeaderView.titleLabel.text = weakSelf.detailModel.shopName;
            
            weakSelf.footerView.countLabel.text = [NSString stringWithFormat:@"共计%@件宝贝",weakSelf.detailModel.shopBuyNum];
            
            weakSelf.footerView.totalPriceLabel.text = MoneyDeal([NSString stringWithFormat:@"%ld",[weakSelf.detailModel.amount integerValue] + [weakSelf.detailModel.yunfei integerValue]]);
            weakSelf.footerView.frePriceLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(weakSelf.detailModel.yunfei)];
            
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
    if (StringIsEmpty(self.detailModel.refuseReason))
    {
        return 4;
    }
    else {
        return 5;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return self.detailModel.orderRejectedDtoList.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 40;
    }
    else if (section == 2 || section == 0)
    {
        return 0.1;
    }
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 83;
//        return 124;
    }
    else if (section == 0)
    {
        return 8;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return self.sectionHeaderView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        return self.footerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [PCOrderDetailStatueTimeCell cellHeight];
    }
    else if (indexPath.section == 1)
    {
        return 100;
    }
    else if (indexPath.section == 2)
    {
        return [PCOrderDetailTimeNumCell cellHeight];
    }
    else
    {
        if (indexPath.section == 3)
        {
            return [PCOrderDetailReasonCell cellHeightWithStr:self.detailModel.rejectedRemark];
        }
        else
        {
            return [PCOrderDetailReasonCell cellHeightWithStr:self.detailModel.refuseReason];
        }
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
        PCGoodsModel *goodsModel = self.detailModel.orderRejectedDtoList[indexPath.row];
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
    else if (indexPath.section == 2)
    {
        return self.timeNumCell;
    }
    else
    {
        PCOrderDetailReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:[PCOrderDetailReasonCell className]];
        
        if (indexPath.section == 3)
        {
            cell.titleLabel.text = @"退款原因";
            cell.detailLabel.text = self.detailModel.rejectedRemark;
        }
        else
        {
            cell.titleLabel.text = @"拒绝原因";
            cell.detailLabel.text = self.detailModel.refuseReason;
        }
        
        return cell;
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

//- (PCOrderDetailStatueTimeCell *)statueCell
//{
//    if (!_statueCell)
//    {
//        _statueCell = [PCOrderDetailStatueTimeCell viewFromXIB];
//
//    }
//    return _statueCell;
//}

- (PCOrderDetailStatueCell *)statueSecCell
{
    if (!_statueSecCell)
    {
        _statueSecCell = [PCOrderDetailStatueCell viewFromXIB];

    }
    return _statueSecCell;
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

- (PCOrderDetailAddressCell *)addressCell
{
    if (!_addressCell)
    {
        _addressCell = [[PCOrderDetailAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PCOrderDetailAddressCell className]];
    }
    return _addressCell;
}

- (OrderFooterView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[OrderFooterView alloc] initWithReuseIdentifier:[OrderFooterView className]];
//        _footerView.countLabel.text = @"共计1件宝贝";
//        _footerView.totalPriceLabel.text = @"￥750";
//        _footerView.frePriceLabel.text = @"￥0.00";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
