//
//  CarCouponChooseViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarCouponChooseViewController.h"
#import "CarCouponTableView.h"

@interface CarCouponChooseViewController ()

@property (nonatomic, strong) CarCouponTableView *tableView;

@end

@implementation CarCouponChooseViewController
- (instancetype)initWithShopModel:(CarShopModel *)shopModel
{
    if (self = [super init])
    {
        _shopModel = shopModel;
        NSString *price = _StrFormate(@"%ld",(long)shopModel.totalPrice);
        self.tableView.shopId = shopModel.shopId;
        self.tableView.amount = price;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"使用优惠券";
    
    [self initRightNavigationItemWithTitle:@"确定" target:self action:@selector(confirmAction)];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)confirmAction
{
    ShopCouponModel *selModel = nil;
    for (ShopCouponModel *model in self.tableView.soureAry)
    {
        if (model.select)
        {
            selModel = model;
            break;
        }
    }
    
    if (selModel) {
        [self.delegate couponChooseViewController:self couponModel:selModel];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        ToastShowCenter(@"请选择优惠券");
    }
}

#pragma mark - get
- (CarCouponTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CarCouponTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
