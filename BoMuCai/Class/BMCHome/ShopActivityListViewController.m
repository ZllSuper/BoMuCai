//
//  ShopActivityListViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopActivityListViewController.h"
#import "ActivityDetailViewController.h"
#import "ShopActivityListTableView.h"

@interface ShopActivityListViewController () <ShopActivityListTableViewDelegate>

@property (nonatomic, strong) ShopActivityListTableView *tableView;

@end

@implementation ShopActivityListViewController

- (instancetype)initWithShopModel:(BMCShopModel *)shopModel
{
    if (self = [super init])
    {
        self.tableView.shopId = shopModel.shopId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"店铺活动";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
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

#pragma mark - tableViewItemAction
- (void)tableView:(ShopActivityListTableView *)tableView cellItemAction:(BMCActivityModel *)model
{
    ActivityDetailViewController *vc = [[ActivityDetailViewController alloc] initWithActivityModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - get
- (ShopActivityListTableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[ShopActivityListTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.itemActionDelegate = self;
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
