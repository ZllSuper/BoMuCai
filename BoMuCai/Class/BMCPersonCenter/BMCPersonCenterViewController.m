//
//  BMCPersonCenterViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCPersonCenterViewController.h"
#import "PCWaitPayOrederViewController.h"
#import "PCWaitReceiveViewController.h"
#import "PCWaitSendOrderViewController.h"
#import "PCBackGoodsOrderViewController.h"
#import "PCAllOrderViewController.h"
#import "PCAccountInfoViewController.h"
#import "BCMMessageCenterViewController.h"
#import "PCCollectViewController.h"
#import "PCFeedBackViewController.h"
#import "PCMemberServiceViewController.h"
#import "PCBrowsingHistoryViewController.h"
#import "PCMyCouponViewController.h"
#import "BXHWebViewController.h"
#import "PCAboutViewController.h"

#import "PersonCenterHeaderView.h"
#import "PersonCenterCell.h"

#import "BXHRefreshHeader.h"

#import "PCGetUserInfoRequest.h"
#import "BMShareView.h"
#import "WXApiManager.h"

@interface BMCPersonCenterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PersonCenterHeaderView *headerView;

@property (nonatomic, strong) NSArray *sourceList;

@property (nonatomic, strong) UIButton *logOutBtn;

@end

@implementation BMCPersonCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PersonCenterList" ofType:@"plist"];
    self.sourceList = [NSArray arrayWithContentsOfFile:path];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logOutBtn];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
    }];
    
    [self.logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(15);
        make.bottom.mas_equalTo(self.view).offset(-15);
    }];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    BXHWeakObj(self);
    [self.headerView.iconNameView.headerImageView sd_setImageWithURL:[NSURL encodeURLWithString:KAccountInfo.photo] placeholderImage:ImagePlaceHolder completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
        selfWeak.headerView.iconNameView.backImageView.image = image;
    }];
    self.headerView.iconNameView.nameLabel.text = KAccountInfo.nickName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
- (void)requestUserInfo
{
    __weak typeof(self) weakSelf = self;
    PCGetUserInfoRequest *item = [[PCGetUserInfoRequest alloc] init];
    item.userId = KAccountInfo.userId;
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        [weakSelf.tableView.mj_header endRefreshing];
        if ([request.response.code isEqualToString:@"0000"])
        {
            KAccountInfo.point = request.response.data[@"point"];
            KAccountInfo.level = request.response.data[@"level"];
            KAccountInfo.maxIntegral = request.response.data[@"maxIntegral"];
            KAccountInfo.levelScling = request.response.data[@"levelScling"];
            
            weakSelf.headerView.iconNameView.progressView.progress = [KAccountInfo.levelScling floatValue] / 100.0;
            weakSelf.headerView.iconNameView.levelLabel.text = KAccountInfo.level;
            weakSelf.headerView.iconNameView.progressLabel.text = [NSString stringWithFormat:@"%@/%@",KAccountInfo.point,KAccountInfo.maxIntegral];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        [weakSelf.tableView.mj_header endRefreshing];
        ToastShowBottom(NetWorkErrorTip);
    }];
}

#pragma mark - action
- (void)refreshAction
{
    [self requestUserInfo];
}

- (void)accountInfoAction
{
    PCAccountInfoViewController *vc = [[PCAccountInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)waitPayBtnAction
{
    PCWaitPayOrederViewController *vc = [[PCWaitPayOrederViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)waitSendBtnAction
{
    PCWaitSendOrderViewController *vc = [[PCWaitSendOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)waitReceiveBtnAction
{
    PCWaitReceiveViewController *vc = [[PCWaitReceiveViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backGoodsBtnAction
{
    PCBackGoodsOrderViewController *vc = [[PCBackGoodsOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)allBtnAction
{
    PCAllOrderViewController *vc = [[PCAllOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)logOutAction
{
    ProgressShow(self.view);
    BXHWeakObj(self);
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
        ProgressHidden(selfWeak.view);
        if (aError)
        {
            ToastShowBottom(@"退出登录失败");
        }
        else
        {
            [MainAppDelegate.mainTabBarController setSelectControllerAtIndex:0];
            [[AccountInfo shareInstance] logout];
            ToastShowBottom(@"退出登录成功");
        }
     }];
}

#pragma mark -tableDelegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[PersonCenterCell className]];
    NSDictionary *dict = self.sourceList[indexPath.row];
    cell.titleLabel.text = dict[@"title"];
    cell.iconImageView.image = ImageWithName(dict[@"imageIcon"]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        BCMMessageCenterViewController *vc = [[BCMMessageCenterViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        PCCollectViewController *vc = [[PCCollectViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        PCMemberServiceViewController *vc = [[PCMemberServiceViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        PCAboutViewController *vc = [[PCAboutViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 4)
    {
        PCFeedBackViewController *vc = [[PCFeedBackViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 5)
    {
        PCBrowsingHistoryViewController *vc = [[PCBrowsingHistoryViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 6)
    {
        PCMyCouponViewController *vc = [[PCMyCouponViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        BMShareView *sheet = [[BMShareView alloc] initWithCompletionBlock:^(BMShareType shareType) {
            NSLog(@"选择了分享平台：%d", (int)shareType);
            
            if (shareType == BMShareTypeWXSession) {
                [[WXApiManager sharedManager] sendMessage:@"佰材网APP下载" description:nil thumbImage:ImageWithName(@"分享图标") webUrl:@"http://www.100csc.com/appdownload.html" type:0];
            }
            else if (shareType == BMShareTypeWXTimeline) {
                [[WXApiManager sharedManager] sendMessage:@"佰材网APP下载" description:nil thumbImage:ImageWithName(@"分享图标") webUrl:@"http://www.100csc.com/appdownload.html" type:1];
            }
        }];
        [sheet show];
    }
}

#pragma mark - get
- (PersonCenterHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[PersonCenterHeaderView alloc] initWithFrame:CGRectZero];
        [_headerView.iconNameView.accountInfoBtn addTarget:self action:@selector(accountInfoAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.statueView.waitPayBtn addTarget:self action:@selector(waitPayBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.statueView.waitSendBtn addTarget:self action:@selector(waitSendBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.statueView.waitReceiveBtn addTarget:self action:@selector(waitReceiveBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.statueView.backGoodsBtn addTarget:self action:@selector(backGoodsBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.statueView.allBtn addTarget:self action:@selector(allBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREENWIDTH, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerNib:[UINib nibWithNibName:[PersonCenterCell className] bundle:nil] forCellReuseIdentifier:[PersonCenterCell className]];
        
        _tableView.mj_header = [BXHRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
        
        if (@available(iOS 11, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (UIButton *)logOutBtn
{
    if (!_logOutBtn)
    {
        _logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logOutBtn.layer.cornerRadius = 4;
        _logOutBtn.layer.masksToBounds = YES;
        _logOutBtn.layer.borderColor = Color_Main_Dark.CGColor;
        _logOutBtn.layer.borderWidth = 1;
        [_logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logOutBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        [_logOutBtn addTarget:self action:@selector(logOutAction) forControlEvents:UIControlEventTouchUpInside];
        _logOutBtn.titleLabel.font = Font_sys_14;
    }
    return _logOutBtn;
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
