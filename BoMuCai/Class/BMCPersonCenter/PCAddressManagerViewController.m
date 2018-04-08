//
//  PCAddressManagerViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAddressManagerViewController.h"
#import "PCAddressAddViewController.h"

#import "PCAddressManagerTableView.h"

@interface PCAddressManagerViewController () <PCAddressManagerTableViewProtocol>

@property (nonatomic, strong) PCAddressManagerTableView *tableView;

@property (nonatomic, strong) UIButton *bottomBtn;

@end

@implementation PCAddressManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"地址管理";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomBtn];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        if (weakSelf.delegate)
        {
            [weakSelf.delegate addressManager:weakSelf addressModel:tableView.soureAry[indexPath.section]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)bottomBtnAction
{
    __weak typeof(self) weakSelf = self;
    PCAddressAddViewController *vc = [[PCAddressAddViewController alloc] initWithCompelet:^(PCAddressModel *addressModel) {
        [weakSelf.tableView.soureAry insertObject:addressModel atIndex:0];
        [weakSelf.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma tableView protocol
- (void)tableVIew:(PCAddressManagerTableView *)tableView editCell:(PCAddressManagerCell *)cell
{
    __weak typeof(self) weakSelf = self;
    PCAddressAddViewController *vc = [[PCAddressAddViewController alloc] initWithEditAddressModel:cell.weakModel addressCompelet:^(PCAddressModel *addressMode) {
        [weakSelf.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - get
 - (PCAddressManagerTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PCAddressManagerTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.protocol = self;
    }
    return _tableView;
}

- (UIButton *)bottomBtn
{
    if (!_bottomBtn)
    {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setTitle:@"新建地址" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_bottomBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = Font_sys_14;
        [_bottomBtn addTarget:self action:@selector(bottomBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
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
