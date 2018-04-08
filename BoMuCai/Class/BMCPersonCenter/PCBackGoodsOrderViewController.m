//
//  PCBackGoodsOrderViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCBackGoodsOrderViewController.h"
#import "BMCShopViewController.h"
#import "PCRefundOrderDetailViewController.h"

#import "PCBackGoodsTableView.h"

@interface PCBackGoodsOrderViewController () <PCOrderProtcol>

@property (nonatomic, strong) PCBackGoodsTableView *tableView;

@end

@implementation PCBackGoodsOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"退款订单";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        PCBackOrderModel *orderModel = [tableView.soureAry objectAtIndex:indexPath.section];
        PCRefundOrderDetailViewController *vc = [[PCRefundOrderDetailViewController alloc] initWithOrderId:orderModel.oid];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.tableView.mj_header beginRefreshing];
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

#pragma mark - orderDelegate
- (void)tableView:(UITableView *)tableView headerViewAction:(PCOrderHeaderView *)headerView
{
    BMCShopModel *shopModel = [[BMCShopModel alloc] init];
    shopModel.shopId = headerView.orderModel.shopId;
    BMCShopViewController *shopVc = [[BMCShopViewController alloc] initWithShopModel:shopModel];
    [self.navigationController pushViewController:shopVc animated:YES];
}


#pragma mark - get
- (PCBackGoodsTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PCBackGoodsTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.orderDelegate = self;
        
    }
    return _tableView;
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
