//
//  PCWaitPayTabelView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCWaitPayTabelView.h"

@implementation PCWaitPayTabelView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatHeader];
//        [self creatFooter];
        
        [self registerNib:[UINib nibWithNibName:[CarOrderInputCell className] bundle:nil] forCellReuseIdentifier:[CarOrderInputCell className]];
        [self registerClass:[PCOrderHeaderView class] forHeaderFooterViewReuseIdentifier:[PCOrderHeaderView className]];
        [self registerClass:[PCWaitPaySectionFooterView class] forHeaderFooterViewReuseIdentifier:[PCWaitPaySectionFooterView className]];
    }
    return self;
}

#pragma mark - request
- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    PCOrderListGetRequest *request = [[PCOrderListGetRequest alloc] init];
    request.requestType = Request_WaitPayType;
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

#pragma mark - delegate
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
    [self.orderDelegate tableView:self cancelOrderBtnAction:footerView];
}

- (void)footerViewRemindBtnAction:(PCWaitPaySectionFooterView *)footerView
{
    [self.orderDelegate tableView:self payBtnAction:footerView];
}

- (void)footerViewThirdBtnAction:(PCWaitPaySectionFooterView *)footerView
{

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.soureAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PCOrderModel *orderModel = self.soureAry[section];
    return orderModel.orderMdseDtoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 133;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PCOrderModel *orderModel = self.soureAry[section];
    PCOrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[PCOrderHeaderView className]];
    headerView.delegate = self;
    headerView.titleLabel.text = orderModel.shopName;
    headerView.statueLabel.text = @"待付款";
    headerView.orderModel = orderModel;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    PCOrderModel *orderModel = self.soureAry[section];
    PCWaitPaySectionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[PCWaitPaySectionFooterView className]];
    footerView.frePriceLabel.text = MoneyDeal(orderModel.yunfei);
    footerView.countLabel.text = _StrFormate(@"共计%@件宝贝",orderModel.shopBuyNum);
    footerView.totalPriceLabel.text = MoneyDeal([NSString stringWithFormat:@"%ld",[orderModel.realAmount integerValue] + [orderModel.yunfei integerValue] - [orderModel.couponPrice integerValue]]);
    footerView.frePriceSecLabel.text = _StrFormate(@"(包含运费￥%@)",MoneyDeal(orderModel.yunfei));
    footerView.delegate = self;
    [footerView.remindBtn setTitle:@"付款" forState:UIControlStateNormal];
    [footerView.cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    footerView.thirdBtn.hidden = YES;
    footerView.orderModel = orderModel;
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
