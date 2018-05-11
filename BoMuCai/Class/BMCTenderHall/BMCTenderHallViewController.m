//
//  BMCTenderHallViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCTenderHallViewController.h"
#import "TenderHallSortViewController.h"
#import "PopContainerController.h"
#import "BXHWebViewController.h"

#import "TenderHallTableView.h"
#import "TenderHallNavView.h"

@interface BMCTenderHallViewController () <UITextFieldDelegate,TenderHallSortViewControllerDelegate>

@property (nonatomic, strong) TenderHallNavView *navView;

@property (nonatomic, strong) TenderHallTableView *tableView;

@end

@implementation BMCTenderHallViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        TenderHallModel *model = tableView.soureAry[indexPath.row];
        BXHWebViewController *vc = [[BXHWebViewController alloc] initWithWebViewType:BXHWebTenderHallDetail];
        vc.requestId = model.hallId;
        vc.title = @"招标详情";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)siftBtnAction
{
    TenderHallSortViewController *sortVc = [[TenderHallSortViewController alloc] initWithSortModel:self.tableView.sortModel];
    sortVc.delegate = self;
    BaseNaviController *nav = [[BaseNaviController alloc] initWithRootViewController:sortVc];
    PopContainerController *vc = [[PopContainerController alloc] initWithRootViewContorller:nav];
    [MainAppDelegate.mainTabBarController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - sortVCDelegate
- (void)sortVc:(TenderHallSortViewController *)vc sortChoose:(TenderHallSortModel *)sortModel
{
    NSString *showText = @"已选择:";
    
    if (!StringIsEmpty(sortModel.type))
    {
        showText = _StrFormate(@"%@ %@",showText,sortModel.type);
    }
    
    if (!StringIsEmpty(sortModel.statue))
    {
        showText = _StrFormate(@"%@ %@",showText,sortModel.statue);
    }
    
    if (!StringIsEmpty(sortModel.proId))
    {
        showText = _StrFormate(@"%@ %@",showText,sortModel.pro);
    }
    
    if (!StringIsEmpty(sortModel.startTime))
    {
        showText = _StrFormate(@"%@ %@至%@",showText,sortModel.startTime,sortModel.endTime);
    }
    
    self.navView.searchTextFiled.text = sortModel.nameLike;
    
    self.navView.shiftLabel.text = showText;

    [self.tableView.sortModel resetModel:sortModel];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - textFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.tableView.sortModel.nameLike = textField.text;
    [self.tableView.mj_header beginRefreshing];
    return YES;
}

#pragma mark - get
- (TenderHallNavView *)navView
{
    if (!_navView)
    {
        _navView = [[TenderHallNavView alloc] init];
        [_navView.siftBtn addTarget:self action:@selector(siftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _navView.searchTextFiled.returnKeyType = UIReturnKeySearch;
        _navView.searchTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _navView.searchTextFiled.delegate = self;
    }
    return _navView;
}

- (TenderHallTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[TenderHallTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.tableFooterView = [UIView new];
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
