//
//  BMCWaresViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCWaresViewController.h"
#import "PopContainerController.h"
#import "SortProChooseViewController.h"
#import "BMCWaresDetailViewController.h"

#import "ScreenView.h"
#import "WaresListTableView.h"

@interface BMCWaresViewController () <ScreenViewDelegate, SortProChooseViewControllerDelegate>

@property (nonatomic, strong) ScreenView *screenView;

@property (nonatomic, strong) WaresListTableView *tabelView;

@end

@implementation BMCWaresViewController


- (instancetype)initWithModel:(BMCTypeModel *)typeModel
{
    if (self = [super init])
    {
        self.title = typeModel.name;
        self.tabelView.type = typeModel.typeId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initRightNavigationItemWithTitle:@"清除筛选" target:self action:@selector(rightBarButtonItemAction)];

    [self.view addSubview:self.screenView];
    [self.view addSubview:self.tabelView];
    
    [self.screenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.screenView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tabelView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        BMCWaresModel *waresModel = tableView.soureAry[indexPath.row];
        BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:waresModel.waresId];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];

    [self.tabelView.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
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

#pragma mark - screenViewDelegate
- (void)screenView:(ScreenView *)screenView screenItemAction:(ScreenViewItem *)item index:(NSInteger)index
{
    if (item.type == ScreenViewItemTouch)
    {
        SortProChooseViewController *sortVc = [[SortProChooseViewController alloc] init];
        sortVc.delegate = self;
        BaseNaviController *nav = [[BaseNaviController alloc] initWithRootViewController:sortVc];
        PopContainerController *vc = [[PopContainerController alloc] initWithRootViewContorller:nav];
        [MainAppDelegate.mainTabBarController presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        if (index == 0)
        {
            self.tabelView.sortAccording = @"buyNum DESC,starLevel DESC,unitPrice ASC";
        }
        else if (index == 1)
        {
            self.tabelView.sortAccording = @"buyNum DESC";
        }
        else if (index == 2)
        {
            self.tabelView.sortAccording = (item.itemState == ScreenViewItemStatueSelectAsc) ? @"unitPrice ASC" : @"unitPrice DESC";
        }
        else
        {
            self.tabelView.sortAccording = @"starLevel DESC";
        }
        [self.tabelView requestViewSource:YES];
    }
}

#pragma makr - chooseAddressDelegate
- (void)chooseVc:(SortProChooseViewController *)vc chooseCityModel:(BXHCityModel *)cityModel
{
    self.tabelView.city = cityModel.cityId;
    [self.tabelView requestViewSource:YES];
}

#pragma mark - get

- (ScreenView *)screenView
{
    if (!_screenView)
    {
        
        ScreenViewItem *item1 = [[ScreenViewItem alloc] initWithTitle:@"综合"];
        item1.type = ScreenViewItemNormal;
        
        ScreenViewItem *item2 = [[ScreenViewItem alloc] initWithTitle:@"销量"];
        item2.type = ScreenViewItemNormal;
        
        ScreenViewItem *item3 = [[ScreenViewItem alloc] initWithTitle:@"价格"];
        item3.type = ScreenViewItemSort;
        [item3 setImage:ImageWithName(@"WareSortNormal") withState:ScreenViewItemStatueNormal];
        [item3 setImage:ImageWithName(@"WareSortDsc") withState:ScreenViewItemStatueSelectDsc];
        [item3 setImage:ImageWithName(@"WareSortAsc") withState:ScreenViewItemStatueSelectAsc];
        
        
        ScreenViewItem *item4 = [[ScreenViewItem alloc] initWithTitle:@"评分"];
        item4.type = ScreenViewItemNormal;
        
        ScreenViewItem *item5 = [[ScreenViewItem alloc] initWithTitle:@"筛选"];
        item5.type = ScreenViewItemTouch;
        
        
        _screenView = [[ScreenView alloc] initWithScreenItems:@[item1,item2,item3,item4,item5]];
        _screenView.delegate = self;
        [_screenView selectItemAtIndex:0];
    }
    return _screenView;
}

- (WaresListTableView *)tabelView
{
    if (!_tabelView)
    {
        _tabelView = [[WaresListTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tabelView.searchName = @"";
        _tabelView.city = @"";
        _tabelView.sortAccording = @"buyNum DESC,starLevel DESC,unitPrice ASC";    }
    return _tabelView;
}

#pragma mark Actions
- (void)rightBarButtonItemAction
{
    self.tabelView.city = @"";
    [self.tabelView requestViewSource:YES];
}

@end
