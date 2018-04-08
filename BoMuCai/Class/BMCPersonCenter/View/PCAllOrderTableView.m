//
//  PCAllOrderTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAllOrderTableView.h"

@implementation PCAllOrderTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatHeader];
//        [self creatFooter];
        
        [self registerNib:[UINib nibWithNibName:[CarOrderInputCell className] bundle:nil] forCellReuseIdentifier:[CarOrderInputCell className]];
        [self registerClass:[PCOrderHeaderView class] forHeaderFooterViewReuseIdentifier:[PCOrderHeaderView className]];
        [self registerClass:[PCWaitPaySectionFooterView class] forHeaderFooterViewReuseIdentifier:[PCWaitPaySectionFooterView className]];

        if (@available(iOS 11, *)) {
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (void)headerViewDidSelectAction:(PCOrderHeaderView *)headerView
{
    [self.orderDelegate tableView:self headerViewAction:headerView];
}

- (void)footerViewPhoneBtnAction:(PCWaitPaySectionFooterView *)footerView
{
    [self.orderDelegate tableView:self phoneCallBtnAction:footerView];
}

- (void)footerViewCancelBtnAction:(PCWaitPaySectionFooterView *)footerView
{
    if([footerView.orderModel.orderStatus isEqualToString:@"01500001"])
    {
        [self.orderDelegate tableView:self cancelOrderBtnAction:footerView];
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500002"])
    {
        [self.orderDelegate tableView:self backGoodsBtnAction:footerView];
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500003"])
    {
        [self.orderDelegate tableView:self lookFreBtnAction:footerView];
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500003"])
    {
        [self.orderDelegate tableView:self cancelOrderBtnAction:footerView];
    }
}

- (void)footerViewRemindBtnAction:(PCWaitPaySectionFooterView *)footerView
{
    if([footerView.orderModel.orderStatus isEqualToString:@"01500001"])
    {
        [self.orderDelegate tableView:self payBtnAction:footerView];
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500002"])
    {
        [self.orderDelegate tableView:self remindBtnAction:footerView];
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500003"])
    {
        [self.orderDelegate tableView:self confirmReceiveBtnAction:footerView];
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500003"])
    {
        [self.orderDelegate tableView:self commentBtnAction:footerView];
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500004"])
    {
        [self.orderDelegate tableView:self commentBtnAction:footerView];
    }
}

- (void)footerViewThirdBtnAction:(PCWaitPaySectionFooterView *)footerView
{
    if([footerView.orderModel.orderStatus isEqualToString:@"01500001"])
    {
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500002"])
    {
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500003"])
    {
        [self.orderDelegate tableView:self backGoodsBtnAction:footerView];
    }
    else if ([footerView.orderModel.orderStatus isEqualToString:@"01500003"])
    {
    }
}

#pragma mark - request
- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    PCOrderListGetRequest *request = [[PCOrderListGetRequest alloc] init];
    request.requestType = @"";
    request.userId = KAccountInfo.userId;
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            if (refresh)
            {
                [weakSelf.soureAry removeAllObjects];
            }
            
            weakSelf.soureAry = [PCOrderModel bxhObjectArrayWithKeyValuesArray:request.response.data];
            [weakSelf reloadData];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        [weakSelf endRefresh];
    } failure:^(NSError *error, BXHBaseRequest *request) {
        [weakSelf endRefresh];
        ToastShowBottom(NetWorkErrorTip);
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.soureAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PCOrderModel *orderModel = self.soureAry[section];
    return orderModel.orderMdseDtoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section != 3)
//    {
//        return 133;
//    }
    return 133;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PCOrderModel *orderModel = self.soureAry[section];
    PCOrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[PCOrderHeaderView className]];
    headerView.titleLabel.text = orderModel.shopName;
    headerView.delegate = self;
    headerView.statueLabel.text = orderModel.orderStatusName;
    headerView.orderModel = orderModel;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    PCOrderModel *orderModel = self.soureAry[section];

    //        01500001  待付款
    //        01500002  待发货
    //        01500003  待收货
    //        01500004  已完成
    //        01500005  已取消
    //        01500006  已失效
    //        01500007  待退款
    //        01500008  已退货

    PCWaitPaySectionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[PCWaitPaySectionFooterView className]];
    footerView.frePriceLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(orderModel.yunfei)];
    footerView.frePriceSecLabel.text = [NSString stringWithFormat:@"(包含运费￥%@)",MoneyDeal(orderModel.yunfei)];
    footerView.totalPriceLabel.text = MoneyDeal([NSString stringWithFormat:@"%ld",[orderModel.realAmount integerValue] + [orderModel.yunfei integerValue] - [orderModel.couponPrice integerValue]]);
    footerView.countLabel.text = [NSString stringWithFormat:@"共计%@件宝贝",orderModel.shopBuyNum];
    footerView.delegate = self;
    footerView.orderModel = orderModel;
    if ([orderModel.orderStatus isEqualToString:@"01500001"])
    {
        [footerView.remindBtn setTitle:@"付款" forState:UIControlStateNormal];
        [footerView.cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        footerView.thirdBtn.hidden = YES;
        footerView.remindBtn.hidden = NO;
        footerView.cancelOrderBtn.hidden = NO;
    }
    else if ([orderModel.orderStatus isEqualToString:@"01500002"])
    {
        [footerView.remindBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
        [footerView.cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        footerView.thirdBtn.hidden = YES;
        footerView.remindBtn.hidden = NO;
        footerView.cancelOrderBtn.hidden = NO;
    }
    else if ([orderModel.orderStatus isEqualToString:@"01500003"])
    {
        footerView.remindBtn.hidden = NO;
        footerView.cancelOrderBtn.hidden = NO;
        footerView.thirdBtn.hidden = NO;
        [footerView.remindBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [footerView.cancelOrderBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [footerView.thirdBtn setTitle:@"退款" forState:UIControlStateNormal];

    }
    else if ([orderModel.orderStatus isEqualToString:@"01500004"])
    {
        footerView.thirdBtn.hidden = YES;
        footerView.cancelOrderBtn.hidden = YES;
        footerView.remindBtn.hidden = NO;
        [footerView.remindBtn setTitle:@"评价" forState:UIControlStateNormal];
    }
    else
    {
        footerView.thirdBtn.hidden = YES;
        footerView.cancelOrderBtn.hidden = YES;
        footerView.remindBtn.hidden = YES;
    }

    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCOrderModel *orderModel = self.soureAry[indexPath.section];
    PCGoodsModel *goodsModel = orderModel.orderMdseDtoList[indexPath.row];
    CarOrderInputCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarOrderInputCell className]];
    cell.nameLabel.text = goodsModel.name;
    [cell.iconImageView sd_setImageWithURL:[NSURL encodeURLWithString:goodsModel.image] placeholderImage:ImagePlaceHolder];
    cell.moneyLabel.text = _StrFormate(@"￥%@",MoneyDeal(goodsModel.unitPrice));
    cell.numLabel.text = _StrFormate(@"编号：%@",goodsModel.goodsId);
    cell.sizeLabel.text = _StrFormate(@"型号：%@",goodsModel.propertyValueName);
    //    self.sizeLabel.hidden = [weakModel.stock integerValue] > 0;
    cell.countLabel.text = [NSString stringWithFormat:@"x%@",goodsModel.buyNum];

    // Configure the cell...
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
