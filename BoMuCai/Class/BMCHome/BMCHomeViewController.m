//
//  BMCHomeViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCHomeViewController.h"
#import "BCMMessageCenterViewController.h"
#import "SearchViewController.h"
#import "SearchWaresViewController.h"
#import "SearchShopViewController.h"
#import "ActivityDetailViewController.h"
#import "BMCWaresViewController.h"
#import "BXHWebViewController.h"
#import "BMCWaresDetailViewController.h"

#import "BMCTypeModel.h"
#import "HomeTableView.h"

#import "TurnRoundRequest.h"
#import "HomeActivityRequest.h"
#import "StartLoadRequest.h"


@interface BMCHomeViewController () <UITextFieldDelegate,HomeTableViewDelegate, SearchViewControllerDelegate>

@property (nonatomic, strong) UITextField *searchTextFiled;

@property (nonatomic, strong) HomeTableView *tableView;

@property (nonatomic, strong) BXHRequestContainer *container;

@property (nonatomic, assign) BOOL loadImage;

@end

@implementation BMCHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadImage = NO;
    
    self.navigationItem.titleView = self.searchTextFiled;
    
    [self initRightNavigationItemWithCustomButton:^(UIButton *btn) {
        [btn setImage:ImageWithName(@"HomeMessageIcon") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 0, 40, 40);
        
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewRefreshCallBack:^(BaseTableView *tableView, BOOL success) {
        [weakSelf requestHomeSource:success];
    }];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:ImageWithColor(Color_Main_Dark) forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:ImageWithColor(Color_White) forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - requestHomeSource
- (void)requestRefresh
{
    [self requestHomeSource:YES];
}

- (void)requestStartLoadImage
{
    self.loadImage = YES;
    StartLoadRequest *request = [[StartLoadRequest alloc] init];
    
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        
        NSString *url = @"";
        if (request.response.data && [request.response.data isKindOfClass:[NSArray class]] && [request.response.data count] > 0) {
            NSDictionary *sourceDict = request.response.data[0];
            if (sourceDict) {
                if (DEF_SCREENHEIGHT == 480)
                { //4，4S
                    url = sourceDict[@"imageF"];
                }
                else if (DEF_SCREENHEIGHT == 568)
                { //5, 5C, 5S, iPod
                    url = sourceDict[@"imageE"];
                }
                else if (DEF_SCREENHEIGHT == 667)
                { //6, 6S
                    url = sourceDict[@"imageC"];
                }
                else if (DEF_SCREENHEIGHT == 736)
                { // 6Plus, 6SPlus
                    url = sourceDict[@"imageA"];
                }
                else {
                    url = sourceDict.allValues[0];
                }
                
                if (url)
                {
                    [EMSDWebImageManager.sharedManager downloadImageWithURL:[NSURL encodeURLWithString:url] options:0 progress:nil completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        if (error == nil) {
                            [[NSUserDefaults standardUserDefaults] setURL:imageURL forKey:ImageStartLoadUrl];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                        }
                    }];
                }
            }
        }
    } failure:^(NSError *error, BXHBaseRequest *request) {
        
    }];
}

- (void)requestHomeSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    TurnRoundRequest *turnRoundRequest = [[TurnRoundRequest alloc] init];
    HomeActivityRequest *activityRequest = [[HomeActivityRequest alloc] init];
    activityRequest.curPage = [NSString stringWithFormat:@"%d",self.tableView.page];
    activityRequest.pageSize = @"10";
    activityRequest.type = @"1";
    
    self.container = [[BXHRequestContainer alloc] init];
    
    if (!refresh)
    {
        self.container.requestAry = @[activityRequest];
    }
    else
    {
        self.container.requestAry = @[turnRoundRequest,activityRequest];
    }
    
    ProgressShow(self.view);
    [self.container chainRequestWithSuccess:^BOOL( BXHBaseRequest *request, BOOL end) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            if([request isKindOfClass:[TurnRoundRequest class]])
            {
                [weakSelf turnRoundRequestDeal:request.response];
            }
            else if ([request isKindOfClass:[HomeActivityRequest class]])
            {
                [weakSelf homeActivityRequestDeal:request.response refresh:refresh];
            }
            if (end)
            {
                if (!weakSelf.loadImage)
                {
                    [weakSelf requestStartLoadImage];
                }
                ProgressHidden(weakSelf.view);
                [weakSelf.tableView endRefresh];
            }
            return YES;
        }
        else
        {
            ProgressHidden(weakSelf.view);
            ToastShowBottom(request.response.message);
            [weakSelf.tableView endRefresh];
            return NO;
        }

    } failure:^BOOL(NSError *error, BXHBaseRequest *request, BOOL end) {
        ProgressHidden(weakSelf.view);
        ToastShowBottom(NetWorkErrorTip);
        [weakSelf.tableView endRefresh];
        return NO;
    }];
}

- (void)turnRoundRequestDeal:(BXHResponse *)response
{
    self.tableView.topAdCell.adModelList = [HomeAdModel bxhObjectArrayWithKeyValuesArray:response.data[@"turnRoundImageDtoList"]];
    self.tableView.midAdCell.adModelList = [HomeAdModel bxhObjectArrayWithKeyValuesArray:response.data[@"advertDtoList"]];
    self.tableView.typeCell.typeAry = [BMCTypeModel bxhObjectArrayWithKeyValuesArray:response.data[@"mdseTypeDtoList"]];
}

- (void)homeActivityRequestDeal:(BXHResponse *)response refresh:(BOOL)refresh
{
    if (refresh)
    {
        [self.tableView.soureAry removeAllObjects];
    }
    [self.tableView.soureAry addObjectsFromArray:[BMCActivityModel bxhObjectArrayWithKeyValuesArray:response.data]];
    [self.tableView reloadData];
}

#pragma mark - Action
- (void)messageAction
{
    if ([self checkIsLogin])
    {
        BCMMessageCenterViewController *vc = [[BCMMessageCenterViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - searchVCDelegate
- (void)searchController:(SearchViewController *)searchController searchText:(NSString *)searchText type:(NSString *)type
{
    if ([type isEqualToString:@"商品"])
    {
        SearchWaresViewController *vc = [[SearchWaresViewController alloc] initWithSearchText:searchText];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([type isEqualToString:@"店铺"])
    {
        SearchShopViewController *vc = [[SearchShopViewController alloc] initWithSearchText:searchText];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - textFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{    
    if (!self.presentedViewController)
    {
        SearchViewController *vc = [[SearchViewController alloc] init];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }

    return NO;
}

#pragma mark - tableViewActionDelegate
- (void)tableView:(HomeTableView *)tableView typeCellAction:(NSInteger)index
{
    switch (index)
    {
        case 0:
        {
            BMCWaresViewController *vc = [[BMCWaresViewController alloc] initWithModel:self.tableView.typeCell.typeAry[index]];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            BMCWaresViewController *vc = [[BMCWaresViewController alloc] initWithModel:self.tableView.typeCell.typeAry[index]];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            BMCWaresViewController *vc = [[BMCWaresViewController alloc] initWithModel:self.tableView.typeCell.typeAry[index]];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
        {
            [MainAppDelegate.mainTabBarController setSelectControllerAtIndex:1];
        }
            break;
    }
}

- (void)tableView:(HomeTableView *)tableView activityAction:(HomeActivityCell *)cell itemModel:(BMCActivityModel *)model
{
    ActivityDetailViewController *vc = [[ActivityDetailViewController alloc] initWithActivityModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(HomeTableView *)tableView topAdCellActionIndex:(NSInteger)index
{
    if (index < tableView.topAdCell.adModelList.count)
    {
//    链接类型  0:商品 1:活动 2:外部链接 3:富文本
        HomeAdModel *adModel = tableView.topAdCell.adModelList[index];
        switch ([adModel.linkType integerValue])
         {
            case 0:
             {
                 NSString *detailID = [[[adModel.linkUrl componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."][0];
                 BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:detailID];
                 [self.navigationController pushViewController:vc animated:YES];
             }
                break;
             case 1:
             {
                 NSArray *tmps = [adModel.linkUrl componentsSeparatedByString:@"/"];
                 NSString *activityId = tmps[tmps.count-2];
                 
                 BMCActivityModel *model = [[BMCActivityModel alloc] init];
                 model.activityId = activityId;
                 model.activityImageApp = adModel.image;
                 ActivityDetailViewController *vc = [[ActivityDetailViewController alloc] initWithActivityModel:model];
                 [self.navigationController pushViewController:vc animated:YES];
             }
                 break;
             case 2:
             {
                 BXHWebViewController *vc = [[BXHWebViewController alloc] initWithUrl:[NSURL encodeURLWithString:adModel.linkUrl]];
                 vc.title = @"广告详情";
                 [self.navigationController pushViewController:vc animated:YES];

             }
                 break;
             case 3:
             {
                 BXHWebViewController *vc = [[BXHWebViewController alloc] initWithHtml:adModel.remarks];
                 vc.title = @"广告详情";
                 [self.navigationController pushViewController:vc animated:YES];

             }
                 break;
  
            default:
                break;
        }

    }
}

- (void)tableView:(HomeTableView *)tableView midAdCellActionIndex:(NSInteger)index
{
    if (index < tableView.midAdCell.adModelList.count)
    {
        //    链接类型  0:商品 1:活动 2:外部链接 3:富文本
        HomeAdModel *adModel = tableView.midAdCell.adModelList[index];
        switch ([adModel.linkType integerValue])
        {
            case 0:
            {
                NSString *detailID = [[[adModel.linkUrl componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."][0];
                BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:detailID];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                NSArray *tmps = [adModel.linkUrl componentsSeparatedByString:@"/"];
                NSString *activityId = tmps[tmps.count-2];
                
                BMCActivityModel *model = [[BMCActivityModel alloc] init];
                model.activityId = activityId;
                model.activityImageApp = adModel.image;
                ActivityDetailViewController *vc = [[ActivityDetailViewController alloc] initWithActivityModel:model];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                BXHWebViewController *vc = [[BXHWebViewController alloc] initWithUrl:[NSURL encodeURLWithString:adModel.linkUrl]];
                vc.title = @"广告详情";
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 3:
            {
                BXHWebViewController *vc = [[BXHWebViewController alloc] initWithHtml:adModel.remarks];
                vc.title = @"广告详情";
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
                
            default:
                break;
        }
        
    }

}

#pragma mark - get
- (UITextField *)searchTextFiled
{
    if (!_searchTextFiled)
    {
        NSString *placeHolder = @"输入要寻找的宝贝";
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:placeHolder];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:Color_White range:NSMakeRange(0, placeHolder.length)];
        [attributeStr addAttribute:NSFontAttributeName value:Font_sys_14 range:NSMakeRange(0, placeHolder.length)];
        
        UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        leftView.frame = CGRectMake(0, 0, 30, 30);
        leftView.userInteractionEnabled = NO;
        [leftView setImage:ImageWithName(@"HomeSearchIcon") forState:UIControlStateNormal];
        _searchTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREENWIDTH - 90, 30)];
        [_searchTextFiled setBackground:ImageWithResizableImage(@"HomeSearchBack", UIEdgeInsetsMake(5, 10, 5, 10))];
        _searchTextFiled.leftView = leftView;
        _searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
        _searchTextFiled.font = Font_sys_14;
        _searchTextFiled.textColor = Color_White;
        _searchTextFiled.attributedPlaceholder = attributeStr;
        _searchTextFiled.delegate = self;
    }
    return _searchTextFiled;
}

- (HomeTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[HomeTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.actionDelegate = self;
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
