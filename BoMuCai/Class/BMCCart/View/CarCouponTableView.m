//
//  CarCouponTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarCouponTableView.h"

@implementation CarCouponTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self creatHeader];
        [self registerNib:[UINib nibWithNibName:[CarCouponCell className] bundle:nil] forCellReuseIdentifier:[CarCouponCell className]];
    }
    return self;
}

- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    
    CarGetUseCouponRequest *request = [[CarGetUseCouponRequest alloc] init];
    request.shopId = self.shopId;
    request.userId = KAccountInfo.userId;
    request.amount = self.amount;
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.soureAry removeAllObjects];
            [weakSelf.soureAry addObjectsFromArray:[ShopCouponModel bxhObjectArrayWithKeyValuesArray:request.response.data]];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.soureAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCouponModel *couponModel = self.soureAry[indexPath.section];
    couponModel.enable = [couponModel.status isEqualToString:@"1"];
    CarCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarCouponCell className]];
    cell.leftIconImageView.hidden = YES;
    cell.weakModel = couponModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShopCouponModel *model = self.soureAry[indexPath.section];
    if (model.enable)
    {
        if (!model.select)
        {
            for (ShopCouponModel *couponModel in self.soureAry)
            {
                couponModel.select = [model isEqual:couponModel];
            }
        }
        else
        {
            model.select = !model.select;
        }
        [self reloadData];
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
