//
//  TenderHallProViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallProViewController.h"
#import "BXHAreaDBManager.h"

@interface TenderHallProViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *proList;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TenderHallProViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"省份";
    

    self.proList = [[BXHAreaDBManager defaultManeger] getProList];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate / datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.proList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressProCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressProCell"];
        cell.textLabel.textColor = Color_MainText;
        cell.textLabel.font = Font_sys_14;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BXHProModel *proModel = self.proList[indexPath.row];
    cell.textLabel.text = proModel.provName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate proVC:self proModel:self.proList[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
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
