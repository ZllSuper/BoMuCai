//
//  PCBackGoodsTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCBackGoodsTableView.h"

@implementation PCBackGoodsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatHeader];
//        [self creatFooter];
        
        [self registerNib:[UINib nibWithNibName:[CarOrderInputCell className] bundle:nil] forCellReuseIdentifier:[CarOrderInputCell className]];
        [self registerClass:[PCOrderHeaderView class] forHeaderFooterViewReuseIdentifier:[PCOrderHeaderView className]];
        [self registerClass:[OrderFooterView class] forHeaderFooterViewReuseIdentifier:[OrderFooterView className]];
    }
    return self;
}

#pragma mark - request
- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    PCBackOrderListRequest *request = [[PCBackOrderListRequest alloc] init];
    request.userId = KAccountInfo.userId;
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            if (refresh)
            {
                [weakSelf.soureAry removeAllObjects];
            }
            
            weakSelf.soureAry = [PCBackOrderModel bxhObjectArrayWithKeyValuesArray:request.response.data];
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

- (void)headerViewDidSelectAction:(PCOrderHeaderView *)headerView
{
    [self.orderDelegate tableView:self headerViewAction:headerView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.soureAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PCBackOrderModel *orederModel = self.soureAry[section];
    return orederModel.orderRejectedDtoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 83;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PCBackOrderModel *orderModel = self.soureAry[section];
    PCOrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[PCOrderHeaderView className]];
    headerView.delegate = self;
    headerView.titleLabel.text = orderModel.shopName;
    headerView.orderModel = orderModel;
    headerView.statueLabel.text = orderModel.rejectedStatusName;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    OrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[OrderFooterView className]];
    PCBackOrderModel *orderModel = self.soureAry[section];
    footerView.frePriceLabel.text = MoneyDeal(orderModel.yunfei);
    footerView.countLabel.text = _StrFormate(@"共计%@件宝贝",orderModel.shopBuyNum);
    footerView.totalPriceLabel.text = MoneyDeal(orderModel.amount);

//    footerView.frePriceLabel.text = @"￥0.00";
//    footerView.countLabel.text = @"共计2件宝贝";
//    footerView.totalPriceLabel.text = @"￥750.00";
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCBackOrderModel *orderModel = self.soureAry[indexPath.section];
    PCGoodsModel *goodsModel = orderModel.orderRejectedDtoList[indexPath.row];
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
