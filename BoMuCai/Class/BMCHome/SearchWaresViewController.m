//
//  SearchWaresViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "SearchWaresViewController.h"
#import "PopContainerController.h"
#import "SortProChooseViewController.h"
#import "BMCWaresDetailViewController.h"

#import "ScreenView.h"
#import "SearchNavBar.h"
#import "WaresListTableView.h"

#import "SearchModel.h"

@interface SearchWaresViewController ()<SearchNavBarDelegate, ScreenViewDelegate,SortProChooseViewControllerDelegate>

@property (nonatomic, strong) SearchNavBar *navBar;

@property (nonatomic, strong) ScreenView *screenView;

@property (nonatomic, strong) WaresListTableView *tabelView;

@end

@implementation SearchWaresViewController

- (instancetype)initWithSearchText:(NSString *)searchText
{
    if (self = [super init])
    {
        self.navBar.searchTextField.text = searchText;
        self.tabelView.searchName = searchText;
        self.tabelView.city = @"";
        self.tabelView.sortAccording = @"buyNum DESC,starLevel DESC,unitPrice ASC";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.screenView];
    [self.view addSubview:self.tabelView];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    [self.screenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    [self.tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.screenView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [self.tabelView requestViewSource:YES];
    
    __weak typeof(self) weakSelf = self;
    [self.tabelView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        BMCWaresModel *waresModel = tableView.soureAry[indexPath.section];
        BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:waresModel.waresId];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
// any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)cancelBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

#pragma mark - sortDelegate
- (void)chooseVc:(SortProChooseViewController *)vc chooseCityModel:(BXHCityModel *)cityModel
{
    self.tabelView.city = cityModel.cityId;
    [self.tabelView requestViewSource:YES];
}

#pragma mark - searchDelegate
- (void)navbarSearchAction:(SearchNavBar *)navbar
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"HistorySearch"];
    NSMutableArray *historyAry = nil;
    if (StringIsEmpty(str))
    {
        historyAry = [NSMutableArray array];
    }
    else
    {
        historyAry = [NSMutableArray arrayWithArray:[str jsonObject]];
    }
    SearchModel *newModel = [[SearchModel alloc] init];
    newModel.name = navbar.searchTextField.text;
    newModel.searchId = @"";
    [historyAry addObject:newModel];
    
    NSString *jsonStr = [[SearchModel bxhKeyValuesArrayWithObjectAry:historyAry] jsonString];
    [[NSUserDefaults standardUserDefaults] setObject:jsonStr forKey:@"HistorySearch"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    [self.navBar.searchTextField resignFirstResponder];
    self.tabelView.searchName = self.navBar.searchTextField.text;
    [self.tabelView requestViewSource:YES];
}

#pragma mark - get
- (SearchNavBar *)navBar
{
    if (!_navBar)
    {
        _navBar = [[SearchNavBar alloc] init];
        _navBar.delegate = self;
        [_navBar setType:@"商品"];
        _navBar.typeBtn.userInteractionEnabled = NO;
        [_navBar.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBar;
}

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
    }
    return _tabelView;
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
