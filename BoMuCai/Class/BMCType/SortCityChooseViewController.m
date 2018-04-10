//
//  SortCityChooseViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "SortCityChooseViewController.h"
#import "PopContainerController.h"
#import "BXHAreaDBManager.h"

@interface SortCityChooseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) BXHProModel *proModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) BXHCityModel *selectMode;

@end

@implementation SortCityChooseViewController

- (instancetype)initWithAreaProModel:(BXHProModel *)proModel
{
    if (self = [super init])
    {
        self.proModel = proModel;
        self.title = self.proModel.provName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initRightNavigationItemWithTitle:@"确定" target:self action:@selector(rightAction)];
    
    self.proModel.cityList = (NSMutableArray *)[[BXHAreaDBManager defaultManeger] getCityListWithProId:self.proModel.provId];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    

    // Do any additional setup after loading the view.
}

#pragma mark - rigthAction
- (void)rightAction
{
    if(self.selectMode && self.selectMode.cityId.length > 0)
    {
        [self.delegate chooseVc:self chooseCityModel:self.selectMode];
        [self.navigationController.containerController dismissAnimate];
    }
    else {
        ToastShowCenter(@"请选择城市");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate / datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.proModel.cityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCityCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressCityCell"];
        cell.textLabel.textColor = Color_MainText;
        cell.textLabel.font = Font_sys_14;
    }
    
    BXHCityModel *cityModel = self.proModel.cityList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (self.selectMode)
    {
        if ([self.selectMode.cityId isEqualToString:cityModel.cityId])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    cell.textLabel.text = cityModel.cityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectMode = self.proModel.cityList[indexPath.row];
    [self.tableView reloadData];
    
    
}

#pragma mark = get
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
