//
//  PCWaitPayOrederViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCWaitPayOrederViewController.h"
#import "BMCShopViewController.h"
#import "CarConfirmPayViewController.h"
#import "BXHAlertViewController.h"
#import "PCWaitPayOrderDetailViewController.h"

#import "PCWaitPayTabelView.h"
#import "PCCancelDelOrderRequest.h"

@interface PCWaitPayOrederViewController () <PCOrderProtcol, PCWaitPayOrderDetailViewControllerProtcol>

@property (nonatomic, strong) PCWaitPayTabelView *tableView;

@end

@implementation PCWaitPayOrederViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"待付款";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        PCOrderModel *orderModel = tableView.soureAry[indexPath.section];
        PCWaitPayOrderDetailViewController *vc = [[PCWaitPayOrderDetailViewController alloc] initWithOrderId:orderModel.oid];
        vc.protcol = weakSelf;
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

#pragma mark - request

- (void)cancelDelRequest:(PCOrderModel *)orderModel
{
    __weak typeof(self) weakSelf = self;
    BXHBlockObj(orderModel);
    PCCancelDelOrderRequest *request = [[PCCancelDelOrderRequest alloc] init];
    request.orderId = orderModel.oid;
    request.userId = KAccountInfo.userId;
    request.remark = @"";
    ProgressShow(self.view);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            NSInteger section = [weakSelf.tableView.soureAry indexOfObject:orderModelblock];
            [weakSelf.tableView.soureAry removeObjectAtIndex:section];
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

#pragma mark - PCWaitPayOrderDetailViewControllerProtcol
- (void)waitPayDetailControllerDelOrder:(PCWaitPayOrderDetailViewController *)viewController
{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - delgate
- (void)tableView:(UITableView *)tableView headerViewAction:(PCOrderHeaderView *)headerView
{
    BMCShopModel *shopModel = [[BMCShopModel alloc] init];
    shopModel.shopId = headerView.orderModel.shopId;
    BMCShopViewController *shopVc = [[BMCShopViewController alloc] initWithShopModel:shopModel];
    [self.navigationController pushViewController:shopVc animated:YES];
}

- (void)tableView:(UITableView *)tableView payBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    CarConfrimPayModel *payModel = [[CarConfrimPayModel alloc] init];
    payModel.amount = headerView.orderModel.amount;
    payModel.realAmount = headerView.orderModel.realAmount;
    payModel.yunfei = headerView.orderModel.yunfei;
    payModel.orderId = headerView.orderModel.orderId;
    payModel.couponPrice = headerView.orderModel.couponPrice;
    CarConfirmPayViewController *vc = [[CarConfirmPayViewController alloc] initWithCarConfirmPayModel:payModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView cancelOrderBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    BXHWeakObj(self);
    BXHBlockObj(headerView);
    BXHAlertViewController *alert = [BXHAlertViewController alertControllerWithTitle:@"取消订单" type:BXHAlertMessageType];
    alert.message = @"确定要取消该订单吗？";
    [alert addAction:[BXHAlertAction actionWithTitle:@"确定" titleColor:Color_Main_Dark handler:^(BXHAlertAction *action) {
        [selfWeak cancelDelRequest:headerViewblock.orderModel];
    }]];
    [alert addAction:[BXHAlertAction actionWithTitle:@"取消" titleColor:Color_Text_Gray handler:^(BXHAlertAction *action) {
        
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView phoneCallBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    NSLog(@"商家电话：%@", headerView.orderModel.shopPhone);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",headerView.orderModel.shopPhone]]];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18031883945"]];
}

#pragma mark - get
- (PCWaitPayTabelView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PCWaitPayTabelView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
