//
//  PCMyCouponTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCMyCouponTableView.h"

@implementation PCMyCouponTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self creatHeader];
        [self registerNib:[UINib nibWithNibName:[CarCouponCell className] bundle:nil] forCellReuseIdentifier:[CarCouponCell className]];
        
        self.effectCouponList = [NSMutableArray array];
        self.invalidCouponList = [NSMutableArray array];
        
    }
    return self;
}

#pragma mark - request
- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    PCMyCouponListRequest *request = [[PCMyCouponListRequest alloc] init];
    request.userId = KAccountInfo.userId;
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            if (refresh)
            {
                [weakSelf.effectCouponList removeAllObjects];
                [weakSelf.invalidCouponList removeAllObjects];
            }
            [weakSelf.effectCouponList addObjectsFromArray:[ShopCouponModel bxhObjectArrayWithKeyValuesArray:request.response.data[@"effectCouponList"]]];
            [weakSelf.invalidCouponList addObjectsFromArray:[ShopCouponModel bxhObjectArrayWithKeyValuesArray:request.response.data[@"invalidCouponList"]]];

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

#pragma mark -delegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.effectCouponList.count + self.invalidCouponList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == self.effectCouponList.count)
    {
        return 40;
    }
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3)
    {
        return self.headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarCouponCell className]];
    ShopCouponModel *couponModel = nil;
    if (indexPath.section < self.effectCouponList.count)
    {
        couponModel = self.effectCouponList[indexPath.section];
        couponModel.enable = YES;
    }
    else
    {
        couponModel = self.invalidCouponList[indexPath.section - self.effectCouponList.count];
        couponModel.enable = NO;
    }
    cell.leftIconImageView.hidden = couponModel.enable;
    cell.weakModel = couponModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShopCouponModel *model = nil;
    if (indexPath.section < self.effectCouponList.count)
    {
        model = self.effectCouponList[indexPath.section];
    }
    else
    {
        model = self.invalidCouponList[indexPath.section - self.effectCouponList.count];
    }
    model.select = !model.select;
    [self reloadData];
}
#pragma mark - get
- (PCCouponHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[PCCouponHeaderView alloc] init];
    }
    return _headerView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
