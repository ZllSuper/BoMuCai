//
//  SearchShopViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "SearchShopViewController.h"
#import "BMCShopViewController.h"

#import "SearchNavBar.h"
#import "SearchShopTableView.h"

#import "SearchModel.h"



@interface SearchShopViewController () <SearchNavBarDelegate>

@property (nonatomic, strong) SearchNavBar *navBar;

@property (nonatomic, strong) SearchShopTableView *tableView;

@end

@implementation SearchShopViewController

- (instancetype)initWithSearchText:(NSString *)searchText
{
    if (self = [super init])
    {
        self.navBar.searchTextField.text = searchText;
        self.tableView.searchName = searchText;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.tableView];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navBar.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        BMCShopViewController *vc = [[BMCShopViewController alloc] initWithShopModel:tableView.soureAry[indexPath.item]];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.tableView requestViewSource:YES];
    // Do any additional setup after loading the view.
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
    self.tableView.searchName = self.navBar.searchTextField.text;
    [self.tableView requestViewSource:YES];

}

#pragma mark - get
- (SearchNavBar *)navBar
{
    if (!_navBar)
    {
        _navBar = [[SearchNavBar alloc] init];
        _navBar.delegate = self;
        [_navBar setType:@"店铺"];
        _navBar.typeBtn.userInteractionEnabled = NO;
        [_navBar.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBar;
}

- (SearchShopTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[SearchShopTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
