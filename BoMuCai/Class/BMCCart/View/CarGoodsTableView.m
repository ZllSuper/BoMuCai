//
//  CarGoodsTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarGoodsTableView.h"
#import "CarCountCalculateView.h"

@implementation CarGoodsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatHeader];
        
        [self registerNib:[UINib nibWithNibName:[CarGoodsCell className] bundle:nil] forCellReuseIdentifier:[CarGoodsCell className]];
        [self registerClass:[CarSectionHeaderView class] forHeaderFooterViewReuseIdentifier:[CarSectionHeaderView className]];
    }
    return  self;
}

- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    MyCartListRequest *request = [[MyCartListRequest alloc] init];
    request.userId = KAccountInfo.userId;
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            if (refresh)
            {
                [weakSelf.soureAry removeAllObjects];
            }
            
            [weakSelf.soureAry addObjectsFromArray:[CarShopModel bxhObjectArrayWithKeyValuesArray:request.response.data[@"cartDtos"]]];
            weakSelf.refreshCallBack(self,YES);
            [weakSelf reloadData];

        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        [weakSelf endRefresh];
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ToastShowBottom(NetWorkErrorTip);
        [weakSelf endRefresh];
    }];
}

- (void)goodsDelRequest:(NSIndexPath *)indexPath
{
    CarShopModel *shopModel = self.soureAry[indexPath.section];
    CarGoodModel *goodsModel = shopModel.cartMdseDto[indexPath.row];
    
    BXHWeakObj(self);
    BXHBlockObj(shopModel);
    BXHBlockObj(goodsModel);
    CartGoodsDelRequest *request = [[CartGoodsDelRequest alloc] init];
    request.goodsId = goodsModel.waresId;
    ProgressShow(self.superview);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(selfWeak.superview);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [shopModelblock.cartMdseDto removeObject:goodsModelblock];
            if (shopModelblock.cartMdseDto.count <= 0)
            {
                [selfWeak.soureAry removeObject:shopModelblock];
            }
            if (selfWeak.soureAry.count <= 0)
            {
                selfWeak.refreshCallBack(self,YES);
            }
            [selfWeak reloadData];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(selfWeak.superview);
        ToastShowBottom(NetWorkErrorTip);
    }];
}

- (void)goodsNumChangeRequest:(CarGoodsCell *)cell andAmount:(NSString *)amount
{
    CarGoodModel *goodsModel = cell.weakModel;
    BXHWeakObj(self);
    BXHBlockObj(goodsModel);
    BXHBlockObj(amount);
    CartGoodsNumChangeRequest *request = [[CartGoodsNumChangeRequest alloc] init];
    request.goodsId = goodsModel.waresId;
    request.amount = amount;
    ProgressShow(self.superview);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(selfWeak.superview);
        if ([request.response.code isEqualToString:@"0000"])
        {
            goodsModelblock.amount = amountblock;
            [selfWeak.selectDelegate tableViewGoodsNumChange:selfWeak];
            cell.weakModel = goodsModel;
        }
//        else if ([request.response.code isEqualToString:@"0029"])
//        {
//            [selfWeak reloadData];
//        }
        else
        {
            ToastShowBottomAndDuation(request.response.message,3);
            [selfWeak reloadData];
        }
    } failure:^(NSError *error, BXHBaseRequest *request) {
        [selfWeak reloadData];
        ProgressHidden(selfWeak.superview);
        ToastShowBottom(NetWorkErrorTip);
    }];
}

#pragma mark - selctionHeaderDelegate
- (void)headerViewDidSelectAction:(CarSectionHeaderView *)headerView
{
    [self.selectDelegate tableView:self sectionHeaderAction:headerView.weakModel];
}

#pragma mark - cellDelegate
- (void)goodsCellTextFiledCountChange:(CarGoodsCell *)cell
{
    [self goodsNumChangeRequest:cell andAmount:cell.buyCountView.countTextFiled.text];
}

- (void)goodsCellSelect:(CarGoodsCell *)cell
{
    cell.weakModel.select = !cell.weakModel.select;
    cell.selectBtn.selected = cell.weakModel.select;
    
    [self.selectDelegate tableViewGoodsSelect:self];
}

- (void)goodsCellCountReduce:(CarGoodsCell *)cell
{
    NSInteger count = [cell.buyCountView.countTextFiled.text integerValue];
    count --;
    if (count >= 1)
    {
        cell.buyCountView.countTextFiled.text = [NSString stringWithFormat:@"%ld",count];
        //    cell.buyCountView.reduceBtn.enabled = count > 1;
//        cell.buyCountView.addBtn.enabled = YES;
        [self goodsNumChangeRequest:cell andAmount:cell.buyCountView.countTextFiled.text];
    }
    else {
        ToastShowCenter(@"数量超出范围~");
    }
}

- (void)goodsCellCount:(CarGoodsCell *)cell
{
    [CarCountCalculateView showWithCarGoodModel:cell.weakModel completion:^(NSString *count) {
        [self goodsNumChangeRequest:cell andAmount:count];
    }];
}

- (void)goodsCellCountAdd:(CarGoodsCell *)cell
{
    NSInteger count = [cell.buyCountView.countTextFiled.text integerValue];
    count ++;
    if (count <= [cell.weakModel.stock integerValue])
    {
        cell.buyCountView.countTextFiled.text = [NSString stringWithFormat:@"%ld",count];
        //    cell.buyCountView.addBtn.enabled = count < [cell.weakModel.stock integerValue];
        //    cell.buyCountView.reduceBtn.enabled = YES;
        [self goodsNumChangeRequest:cell andAmount:cell.buyCountView.countTextFiled.text];
    }
    else {
        ToastShowCenter(@"数量超出范围~");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.soureAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarShopModel *shopModel = self.soureAry[section];
    return shopModel.cartMdseDto.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CarShopModel *shopModel = self.soureAry[section];
    CarSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[CarSectionHeaderView className]];
    headerView.delegate = self;
    headerView.weakModel = shopModel;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarShopModel *shopModel = self.soureAry[indexPath.section];

    CarGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarGoodsCell className]];
    cell.delegate = self;
    cell.weakModel = shopModel.cartMdseDto[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self goodsDelRequest:indexPath];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
