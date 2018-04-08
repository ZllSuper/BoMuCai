//
//  BMCWaresCommentViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCWaresCommentViewController.h"
#import "WaresDetailCommentTableView.h"

@interface BMCWaresCommentViewController ()

@property (nonatomic, strong) WaresDetailCommentTableView *tableView;

@end

@implementation BMCWaresCommentViewController

- (instancetype)initWithWaresId:(NSString *)waresId
{
    if (self = [super init])
    {
        self.tableView.waresId = waresId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"全部评价";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (WaresDetailCommentTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[WaresDetailCommentTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
