//
//  PCAllOrderViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAllOrderViewController.h"
#import "BMCShopViewController.h"
#import "BXHAlertViewController.h"
#import "PCApplyRefundViewController.h"
#import "CarConfirmPayViewController.h"
#import "PCOrderCommentViewController.h"
#import "PCLogisticsInfoViewController.h"
#import "PCCompleteOrderDetailViewController.h"
#import "PCWaitPayOrderDetailViewController.h"
#import "PCWaitSendOrderDetailViewController.h"
#import "PCWaitReceiveOrderDetailViewController.h"
#import "PCRefundOrderDetailViewController.h"
#import "PCWaitRefundOrderDetailViewController.h"
#import "PCAllOrderTableView.h"
#import "PCCanceledOrderDetailViewController.h"

#import "PCCancelDelOrderRequest.h"
#import "PCRemindSendRequest.h"
#import "PCKConfirmRevRequest.h"

@interface PCAllOrderViewController () <PCOrderProtcol,PCApplyRefundResultViewControllerDelegate>

@property (nonatomic, strong) PCAllOrderTableView *tableView;

@end

@implementation PCAllOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"全部订单";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
//        01500001  待付款
//        01500002  待发货
//        01500003  待收货
//        01500004  已完成
//        01500005  已取消
//        01500006  已失效
//        01500007  待退款
//        01500008  已退货

        PCOrderModel *orderModel = tableView.soureAry[indexPath.section];
        if ([orderModel.orderStatus isEqualToString:@"01500001"])
        {
            PCWaitPayOrderDetailViewController *vc = [[PCWaitPayOrderDetailViewController alloc] initWithOrderId:orderModel.oid];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([orderModel.orderStatus isEqualToString:@"01500002"])
        {
            PCWaitSendOrderDetailViewController *vc = [[PCWaitSendOrderDetailViewController alloc] initWithOrderId:orderModel.oid];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([orderModel.orderStatus isEqualToString:@"01500003"])
        {
            PCWaitReceiveOrderDetailViewController *vc = [[PCWaitReceiveOrderDetailViewController alloc] initWithOrderId:orderModel.oid];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([orderModel.orderStatus isEqualToString:@"01500007"])
        {
            PCWaitRefundOrderDetailViewController *vc = [[PCWaitRefundOrderDetailViewController alloc] initWithOrderId:orderModel.oid];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([orderModel.orderStatus isEqualToString:@"01500004"])
        {
            PCCompleteOrderDetailViewController *vc = [[PCCompleteOrderDetailViewController alloc] initWithOrderId:orderModel.oid];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        else if ([orderModel.orderStatus isEqualToString:@"01500005"])
        {
            PCCanceledOrderDetailViewController *vc = [[PCCanceledOrderDetailViewController alloc] initWithOrderId:orderModel.oid];
            [self.navigationController pushViewController:vc animated:YES];
        }
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

- (void)remindSendRequest:(PCOrderModel *)orderModel
{
    __weak typeof(self) weakSelf = self;
    PCRemindSendRequest *request = [[PCRemindSendRequest alloc] init];
    request.orderId = orderModel.oid;
    request.remark = @"";
    ProgressShow(self.view);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            ToastShowBottom(@"提醒已发送");
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

#pragma mark - orderDelegate
- (void)tableView:(UITableView *)tableView headerViewAction:(PCOrderHeaderView *)headerView
{
    BMCShopModel *model = [[BMCShopModel alloc] init];
    model.shopId = headerView.orderModel.shopId;
    BMCShopViewController *shopVc = [[BMCShopViewController alloc] initWithShopModel:model];
    [self.navigationController pushViewController:shopVc animated:YES];
}

- (void)tableView:(UITableView *)tableView phoneCallBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    NSLog(@"商家电话：%@", headerView.orderModel.shopPhone);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",headerView.orderModel.shopPhone]]];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18031883945"]];
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
                [(PCAllOrderTableView *)tableView requestViewSource:YES];
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

- (void)tableView:(UITableView *)tableView cancelOrderBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    BXHWeakObj(self);
    BXHBlockObj(headerView);
    BXHAlertViewController *alert = [BXHAlertViewController alertControllerWithTitle:@"删除订单" type:BXHAlertMessageType];
    alert.message = @"是否删除这条订单？";
    [alert addAction:[BXHAlertAction actionWithTitle:@"是" titleColor:Color_Main_Dark handler:^(BXHAlertAction *action) {
        [selfWeak cancelDelRequest:headerViewblock.orderModel];
    }]];
    [alert addAction:[BXHAlertAction actionWithTitle:@"否" titleColor:Color_Text_Gray handler:^(BXHAlertAction *action) {
        
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView commentBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    PCOrderCommentViewController *vc = [[PCOrderCommentViewController alloc] initWithOrderId:headerView.orderModel.oid];
//    vc.orderModel = headerView.orderModel;
    vc.iconImageUrl = [(PCGoodsModel *)headerView.orderModel.orderMdseDtoList.firstObject image];
    [self.navigationController pushViewController:vc animated:YES];
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

- (void)tableView:(UITableView *)tableView remindBtnAction:(PCWaitPaySectionFooterView *)headerView
{
    [self remindSendRequest:headerView.orderModel];
}


#pragma mark - get
- (PCAllOrderTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PCAllOrderTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
