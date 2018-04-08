//
//  PCCollectViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/10.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCCollectViewController.h"
#import "PCCollectSegmentView.h"
#import "PCCollectShopTableView.h"
#import "PCCollectGoodsTableView.h"
#import "BMCWaresDetailViewController.h"
#import "BMCShopViewController.h"

@interface PCCollectViewController () <PCCollectSegmentViewDelegate>

@property (nonatomic, strong) PCCollectSegmentView *segmentView;

@property (nonatomic, strong) PCCollectShopTableView *shopTableView;

@property (nonatomic, strong) PCCollectGoodsTableView *goodsTableView;

@property (nonatomic, assign) BOOL firstLoad;

@end

@implementation PCCollectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    
    self.firstLoad = YES;
    
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.shopTableView];
    [self.view addSubview:self.goodsTableView];
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [self.shopTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentView.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
    
    [self.goodsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentView.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.goodsTableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        BMCWaresModel *waresModel = tableView.soureAry[indexPath.row];
        BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:waresModel.waresId];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.shopTableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        BMCShopViewController *vc = [[BMCShopViewController alloc] initWithShopModel:tableView.soureAry[indexPath.row]];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.goodsTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentViewBtnAction:(PCCollectSegmentView *)segmentView
{
    self.goodsTableView.hidden = !segmentView.goodsBtn.selected;
    self.shopTableView.hidden = segmentView.goodsBtn.selected;
    if (!self.shopTableView.hidden && self.firstLoad)
    {
        self.firstLoad = NO;
        [self.shopTableView.mj_header beginRefreshing];
    }
}

#pragma mark - get
- (PCCollectSegmentView *)segmentView
{
    if (!_segmentView)
    {
        _segmentView = [[PCCollectSegmentView alloc] init];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

- (PCCollectShopTableView *)shopTableView
{
    if (!_shopTableView)
    {
        _shopTableView = [[PCCollectShopTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _shopTableView.hidden = YES;
    }
    return _shopTableView;
}

- (PCCollectGoodsTableView *)goodsTableView
{
    if (!_goodsTableView)
    {
        _goodsTableView = [[PCCollectGoodsTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _goodsTableView;
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
