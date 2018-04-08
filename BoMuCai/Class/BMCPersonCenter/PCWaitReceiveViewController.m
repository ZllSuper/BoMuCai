//
//  PCWaitReceiveViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCWaitReceiveViewController.h"
#import "BMCShopViewController.h"
#import "BXHAlertViewController.h"
#import "PCApplyRefundViewController.h"
#import "PCLogisticsInfoViewController.h"
#import "PCWaitReceiveOrderDetailViewController.h"

#import "PCWaitReceiveTableView.h"
#import "PCKConfirmRevRequest.h"

@interface PCWaitReceiveViewController () <PCOrderProtcol,PCApplyRefundResultViewControllerDelegate>

@property (nonatomic, strong) PCWaitReceiveTableView *tableView;

@end

@implementation PCWaitReceiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"待收货";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        PCOrderModel *orderModel = tableView.soureAry[indexPath.section];
        PCWaitReceiveOrderDetailViewController *vc = [[PCWaitReceiveOrderDetailViewController alloc] initWithOrderId:orderModel.oid];
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

- (void)tableView:(UITableView *)tableView phoneCallBtnAction:(PCWaitPaySectionFooterView *)headerView
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",headerView.orderModel.shopPhone]]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18031883945"]];
}

- (void)tableView:(UITableView *)tableView backGoodsBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    
    __weak typeof(self) weakSelf = self;
    BXHBlockObj(headerView);
    //删除订单
    BXHAlertViewController *alert = [BXHAlertViewController alertControllerWithTitle:@"退款" type:BXHAlertMessageType];
    alert.message = @"是否对当前订单退款？";
    [alert addAction:[BXHAlertAction actionWithTitle:@"是" titleColor:Color_Main_Dark handler:^(BXHAlertAction *action) {
        PCApplyRefundViewController *vc = [[PCApplyRefundViewController alloc] initWithOrderId:headerViewblock.orderModel.oid];
        vc.delegate = weakSelf;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    [alert addAction:[BXHAlertAction actionWithTitle:@"否" titleColor:Color_Text_Gray handler:^(BXHAlertAction *action) {
        
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView lookFreBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    PCLogisticsInfoViewController *vc = [[PCLogisticsInfoViewController alloc] initWithOrderId:headerView.orderModel.oid];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView confirmReceiveBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    BXHAlertViewController *alert = [BXHAlertViewController alertControllerWithTitle:@"确认收货" type:BXHAlertMessageType];
    alert.message = @"是否确认收货？";
    [alert addAction:[BXHAlertAction actionWithTitle:@"是" titleColor:Color_Main_Dark handler:^(BXHAlertAction *action) {
        
        __weak typeof(self) weakSelf = self;
        PCKConfirmRevRequest *request = [[PCKConfirmRevRequest alloc] init];
        request.orderId = headerView.orderModel.oid;
        ProgressShow(self.view);
        [request requestWithSuccess:^( BXHBaseRequest *request) {
            ProgressHidden(weakSelf.view);
            if ([request.response.code isEqualToString:@"0000"])
            {
                [(PCWaitReceiveTableView *)tableView requestViewSource:YES];
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

#pragma mark - get
- (PCWaitReceiveTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PCWaitReceiveTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
