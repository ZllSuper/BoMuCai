//
//  TenderHallSortViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallSortViewController.h"
#import "PopContainerController.h"
#import "TenderHallProViewController.h"
#import "TenderHallSortTypeViewController.h"
#import "TenderHallStatueViewController.h"
#import "TenderHallTimeViewController.h"

#import "TenderHallSortCell.h"

@interface TenderHallSortViewController () <UITableViewDelegate, UITableViewDataSource, TenderHallTimeViewControllerDelegate,TenderHallSortTypeViewControllerDelegate,TenderHallStatueViewControllerDelegate,TenderHallProViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleList;

@property (nonatomic, strong) TenderHallSortModel *sortModel;

@property (nonatomic, strong) UIButton *clearBtn;

@end

@implementation TenderHallSortViewController

- (instancetype)initWithSortModel:(TenderHallSortModel *)sortModel
{
    if (self = [super init])
    {
        self.sortModel = [sortModel bxhCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"筛选";
        
    [self initLeftNavigationItemWithTitle:@"取消" target:self action:@selector(cancelAction)];
    [self initRightNavigationItemWithTitle:@"确定" target:self action:@selector(confirmAction)];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"TenderHallSortList" ofType:@"plist"];
    self.titleList = [NSArray arrayWithContentsOfFile:path];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.clearBtn];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view);
    }];
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.view).offset(-10);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)cancelAction
{
    [self.navigationController.containerController dismissAnimate];
}

- (void)confirmAction
{
    [self.delegate sortVc:self sortChoose:self.sortModel];
    [self.navigationController.containerController dismissAnimate];
}

- (void)clearSortAction
{
    [self.sortModel clear];
    [self.delegate sortVc:self sortChoose:self.sortModel];
    [self.navigationController.containerController dismissAnimate];
}

#pragma mark - VcDelegate
- (void)timeChoose:(TenderHallTimeViewController *)viewController startTime:(NSString *)startTime endTime:(NSString *)endTime
{
    self.sortModel.startTime = startTime;
    self.sortModel.endTime = endTime;
    [self.tableView reloadData];
}

- (void)typeVC:(TenderHallSortTypeViewController *)vc typeModel:(TenderSortTypeModel *)model
{
    self.sortModel.type = model.name;
    self.sortModel.typeId = model.typeId;
    [self.tableView reloadData];
}

- (void)statueVC:(TenderHallStatueViewController *)vc statueChoose:(NSDictionary *)statue
{
    self.sortModel.statue = statue[@"title"];
    self.sortModel.statueId = statue[@"code"];
    [self.tableView reloadData];
}

- (void)proVC:(TenderHallProViewController *)vc proModel:(BXHProModel *)proModel
{
    self.sortModel.proId = proModel.provId;
    self.sortModel.pro = proModel.provName;
    [self.tableView reloadData];
}

#pragma mark - tableViewDelegate / datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TenderHallSortCell *cell = [tableView dequeueReusableCellWithIdentifier:[TenderHallSortCell className]];
   
    cell.titleLabel.text = self.titleList[indexPath.row];
    if (indexPath.row == 0)
    {
        if(!StringIsEmpty(self.sortModel.type))
        {
            cell.rightLabel.text = self.sortModel.type;
        }
    }
    else if (indexPath.row == 1)
    {
        if(!StringIsEmpty(self.sortModel.statue))
        {
            cell.rightLabel.text = self.sortModel.statue;
        }
    }
    else if (indexPath.row == 2)
    {
        if(!StringIsEmpty(self.sortModel.pro))
        {
            cell.rightLabel.text = self.sortModel.pro;
        }
    }
    else
    {
        if(!StringIsEmpty(self.sortModel.startTime))
        {
            cell.rightLabel.text = [NSString stringWithFormat:@"%@至%@",self.sortModel.startTime,self.sortModel.endTime];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if (indexPath.row == 0)
    {
        TenderHallSortTypeViewController *vc = [[TenderHallSortTypeViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        TenderHallStatueViewController *vc = [[TenderHallStatueViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        TenderHallProViewController *vc = [[TenderHallProViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        TenderHallTimeViewController *vc = [[TenderHallTimeViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
        [_tableView registerClass:[TenderHallSortCell class] forCellReuseIdentifier:[TenderHallSortCell className]];
    }
    return _tableView;
}

- (UIButton *)clearBtn
{
    if (!_clearBtn)
    {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.layer.cornerRadius = 4;
        _clearBtn.layer.masksToBounds = YES;
        _clearBtn.layer.borderColor = Color_Main_Dark.CGColor;
        _clearBtn.layer.borderWidth = 1;
        [_clearBtn setTitle:@"清除筛选" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearSortAction) forControlEvents:UIControlEventTouchUpInside];
        _clearBtn.titleLabel.font = Font_sys_14;
    }
    return _clearBtn;
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
