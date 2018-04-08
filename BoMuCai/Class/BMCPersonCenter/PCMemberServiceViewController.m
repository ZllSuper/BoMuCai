//
//  PCMemberServiceViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCMemberServiceViewController.h"

#import "PCNormalQuestionViewController.h"

@interface PCMemberServiceViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PCMemberServiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"会员服务";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MermberServiceCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MermberServiceCell"];
        cell.textLabel.font = Font_sys_14;
        cell.textLabel.textColor = Color_MainText;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = indexPath.row == 0 ? @"联系平台" : @"问题解答";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1)
    {
        PCNormalQuestionViewController *vc = [[PCNormalQuestionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        if ([[EMClient sharedClient] isLoggedIn])
        {
            EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"test" conversationType:EMConversationTypeChat];
            chatController.title = @"系统消息";
            [self.navigationController pushViewController:chatController animated:YES];
        }
    }
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
