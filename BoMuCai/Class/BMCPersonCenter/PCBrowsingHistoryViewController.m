//
//  PCBrowsingHistoryViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCBrowsingHistoryViewController.h"
#import "BMCWaresDetailViewController.h"

#import "PCBrowsingHistoryTableView.h"

@interface PCBrowsingHistoryViewController ()

@property (nonatomic, strong) PCBrowsingHistoryTableView *tableView;

@end

@implementation PCBrowsingHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"浏览记录";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        BMCWaresModel *model = tableView.soureAry[indexPath.row];
        BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:model.waresId];
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

#pragma mark - get
- (PCBrowsingHistoryTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PCBrowsingHistoryTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
