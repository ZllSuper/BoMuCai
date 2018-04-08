//
//  PCLogisticsInfoViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCLogisticsInfoViewController.h"
#import "PCLogisticsCell.h"

#import "PCOrderDetailRequest.h"
#import "PCOrderDetailModel.h"

@interface PCLogisticsInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PCOrderDetailModel *detailModel;

@property (nonatomic, copy) NSString *orderId;

@end

@implementation PCLogisticsInfoViewController

- (instancetype)initWithOrderId:(NSString *)orderId
{
    if (self = [super init])
    {
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"物流信息";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
    
    [self orderDetailRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
- (void)orderDetailRequest
{
    __weak typeof(self) weakSelf = self;
    PCOrderDetailRequest *item = [[PCOrderDetailRequest alloc] init];
    item.orderId = self.orderId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.detailModel = [PCOrderDetailModel bxhObjectWithKeyValues:request.response.data];
            [weakSelf.tableView reloadData];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        ToastShowBottom(NetWorkErrorTip);
    }];
}


#pragma mark - tableViewdelegate / datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:[PCLogisticsCell className]];
    if (!cell)
    {
        cell = [[PCLogisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PCLogisticsCell className]];
    }
    
    if (indexPath.row == 0)
    {
        cell.titleLabel.text = @"物流公司";
        cell.rightLabel.text = self.detailModel.expressCompanyName;
    }
    else if (indexPath.row == 1)
    {
        cell.titleLabel.text = @"运单号";
        cell.rightLabel.text = self.detailModel.expressId;
    }
    else
    {
        cell.titleLabel.text = @"联系电话";
        cell.rightLabel.text = self.detailModel.expressPhone;
    }
    
    return cell;
}

#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
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
