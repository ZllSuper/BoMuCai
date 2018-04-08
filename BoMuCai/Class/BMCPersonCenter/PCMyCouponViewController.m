//
//  PCMyCouponViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCMyCouponViewController.h"
#import "BXHAlertViewController.h"

#import "PCMyCouponTableView.h"

#import "PCDelCouponRequest.h"

@interface PCMyCouponViewController ()

@property (nonatomic, strong) PCMyCouponTableView *tableView;

@end

@implementation PCMyCouponViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的优惠券";
    
    [self initRightNavigationItemWithTitle:@"删除" target:self action:@selector(rightBtnAction)];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
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
- (void)delCouponList
{
    NSString *couponId = @"";
    for (ShopCouponModel *model in self.tableView.effectCouponList)
    {
        if (model.select)
        {
            if (StringIsEmpty(couponId))
            {
                couponId = model.couponId;
            }
            else
            {
                couponId = [NSString stringWithFormat:@"%@,%@",couponId,model.couponId];
            }
        }
    }
    
    for (ShopCouponModel *model in self.tableView.invalidCouponList)
    {
        if (model.select)
        {
            if (StringIsEmpty(couponId))
            {
                couponId = model.couponId;
            }
            else
            {
                couponId = [NSString stringWithFormat:@"%@,%@",couponId,model.couponId];
            }
        }
    }

    
    BXHWeakObj(self);
    PCDelCouponRequest *request = [[PCDelCouponRequest alloc] init];
    request.userId = KAccountInfo.userId;
    request.couponId = couponId;
    ProgressShow(self.view);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(selfWeak.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            ToastShowCenter(@"删除成功");
            [selfWeak.tableView.mj_header beginRefreshing];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(selfWeak.view);
        ToastShowBottom(NetWorkErrorTip);
    }];
}

#pragma mark - rightBtnAction
- (void)rightBtnAction
{
    BXHAlertViewController *alert = [BXHAlertViewController alertControllerWithTitle:@"" type:BXHAlertMessageType];
    alert.message = @"您确定删除已选择的优惠券？";
    
    __weak typeof(self) weakSelf = self;
    BXHAlertAction *alertAction = [BXHAlertAction actionWithTitle:@"删除" titleColor:Color_Main_Dark handler:^(BXHAlertAction *action) {
        [weakSelf delCouponList];
    }];
    
    BXHAlertAction *alertAction1 = [BXHAlertAction actionWithTitle:@"取消" titleColor:Color_MainText handler:^(BXHAlertAction *action) {
        
    }];
    [alert addAction:alertAction];
    [alert addAction:alertAction1];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - get
- (PCMyCouponTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PCMyCouponTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
