//
//  BCMMessageCenterViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BCMMessageCenterViewController.h"

#import "MessageCenterTableView.h"

@interface BCMMessageCenterViewController ()

@property (nonatomic, strong) MessageCenterTableView *tableView;

@end

@implementation BCMMessageCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"消息中心";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        EaseConversationModel *model = tableView.soureAry[indexPath.row];
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:model.conversation.conversationId conversationType:EMConversationTypeChat];
        chatController.title = model.title;
        [weakSelf.navigationController pushViewController:chatController animated:YES];
    }];
    
    if (![[EMClient sharedClient] isLoggedIn])
    {
        BXHWeakObj(self);
        ProgressShow(self.view);
        [[EMClient sharedClient] loginWithUsername:KAccountInfo.easemob password:KAccountInfo.easemobPassword completion:^(NSString *aUsername, EMError *aError) {
            ProgressHidden(selfWeak.view);
            [selfWeak.tableView.mj_header beginRefreshing];
        }];
    }
    else
    {
        [self.tableView.mj_header beginRefreshing];
    }
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

- (void)headerAction
{
    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"test" conversationType:EMConversationTypeChat];
    chatController.title = @"系统消息";
    [self.navigationController pushViewController:chatController animated:YES];
}

#pragma mark - get
- (MessageCenterTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[MessageCenterTableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREENWIDTH, DEF_SCREENHEIGHT - 64) style:UITableViewStyleGrouped];
        [_tableView.headerView addTarget:self action:@selector(headerAction) forControlEvents:UIControlEventTouchUpInside];
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
