//
//  BMCWaresDetailViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCWaresDetailViewController.h"
#import "WaresPopContainerController.h"
#import "BMCWaresTypeSelectViewController.h"
#import "BMCWaresCommentViewController.h"
#import "BMCShopViewController.h"
#import "BMCCartViewController.h"
#import "BXHAlertViewController.h"
#import "CarOrderInputViewController.h"

#import "WaresDetailBottomView.h"
#import "WaresDetailNavBar.h"
#import "WaresDetailTableView.h"
#import "SYPhotoBrowser.h"

#import "BMCDelCollectRequest.h"
#import "BMCCollectRequest.h"
#import "CartAddProductRequest.h"
#import "CarShopModel.h"
#import "CarGoodModel.h"
#import "BMShareView.h"
#import "WXApiManager.h"

@interface BMCWaresDetailViewController () <WaresDetailTableViewProtcol,WaresPopContainerControllerProtcol,BMCWaresTypeSelectViewControllerDelegate>

@property (nonatomic, strong) WaresDetailNavBar *navBar;

@property (nonatomic, strong) WaresDetailTableView *tableView;

@property (nonatomic, strong) WaresDetailBottomView *bottomView;

@property (nonatomic, assign) NSInteger addedCount;

@end

@implementation BMCWaresDetailViewController

- (instancetype)initWithWaresDetailId:(NSString *)detailId
{
    if (self = [super init])
    {
        self.tableView.detailId = detailId;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.addedCount = 0;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.bottomView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(8);
    }];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        
        if (indexPath.section == 1)
        {
            BMCShopModel *shopModel = [[BMCShopModel alloc] init];
            shopModel.shopId = weakSelf.tableView.detailModel.shopId;
            BMCShopViewController *vc = [[BMCShopViewController alloc] initWithShopModel:shopModel];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.section == 2)
        {
            BMCWaresTypeSelectViewController *vc = [[BMCWaresTypeSelectViewController alloc] initWithWaresDetailModel:weakSelf.tableView.detailModel];
            vc.view.backgroundColor = Color_White;
            vc.delegate = weakSelf;
            WaresPopContainerController *container = [[WaresPopContainerController alloc] initWithRootViewController:vc];
            container.protcol = weakSelf;
            [container showFromViewController:weakSelf];
        }
       
    }];
    
    [self.tableView tableViewRefreshCallBack:^(BaseTableView *tableView, BOOL success) {
        weakSelf.navBar.collectBtn.selected = !([weakSelf.tableView.detailModel.collection integerValue] == 0);
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - popContainerProtcol
- (void)containerController:(WaresPopContainerController *)containerController willDismissViewController:(UIViewController *)controller
{
    [self.tableView reloadData];
}

#pragma mark - selectControllerDelegate
- (void)selectViewControllerAddToCart:(BMCWaresTypeSelectViewController *)viewController
{
    [viewController.containerController hiddenWithAnimate];
    [self addToCarAction];
}

- (void)selectViewControllerBuyNow:(BMCWaresTypeSelectViewController *)viewController
{
    [viewController.containerController hiddenWithAnimate];
    [self startPayAction];
}

#pragma mark - tableViewProtcol
- (void)tableView:(WaresDetailTableView *)tableView itemAction:(WaresDetailItem *)item
{
    BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:item.weakModel.waresId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(WaresDetailTableView *)tableView AdViewActionIndex:(NSInteger)index
{
//    SYPhotoBrowser *photoBrowser = [[SYPhotoBrowser alloc] initWithImageSourceArray:@[ImageWithName(@"PlaceHoldImage"),ImageWithName(@"PlaceHoldImage"),ImageWithName(@"PlaceHoldImage"),ImageWithName(@"PlaceHoldImage")] delegate:self];
//    photoBrowser.initialPageIndex = index;
//    [self presentViewController:photoBrowser animated:YES completion:nil];
}

#pragma mark - action
- (void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)collectBtnAction
{
    if ([self checkIsLogin])
    {
        if (self.navBar.collectBtn.selected)
        {
            [self delCollectRequest];
        }
        else
        {
            [self collectRequest];
        }
    }
}

- (void)shareBtnAction
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

- (void)moreCommentAction
{
    BMCWaresCommentViewController *vc = [[BMCWaresCommentViewController alloc] initWithWaresId:self.tableView.detailId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)carBtnAction
{
    if ([self checkIsLogin])
    {
        BMCCartViewController *vc = [[BMCCartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)contactBtnAction
{
    if ([self checkIsLogin])
    {
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:self.tableView.detailModel.easemobId conversationType:EMConversationTypeChat];
        chatController.title = self.tableView.detailModel.shopName;
        [self.navigationController pushViewController:chatController animated:YES];
    }
}

- (void)addToCarAction
{
    if (![self checkIsLogin])
    {
        return;
    }
    
    if ([self.tableView.detailModel.morenfenlei rangeOfString:EMPTY_SEL].location != NSNotFound)
    {
        ToastShowBottom(@"请选择型号");
        return;
    }
    
    [self carAddProductRequest];
}

- (void)startPayAction
{
    if (![self checkIsLogin])
    {
        return;
    }
    
    if ([self.tableView.detailModel.morenfenlei rangeOfString:EMPTY_SEL].location != NSNotFound)
    {
        ToastShowBottom(@"请选择型号");
        return;
    }
    
    NSMutableArray *typeDtos = [NSMutableArray array];
    NSArray *typeIds = [self.tableView.detailModel.morenfenlei componentsSeparatedByString:@","];
    for (NSString *typeId in typeIds)
    {
        NSInteger index = [typeIds indexOfObject:typeId];
        WaresTypeSectionModel * typeModel = self.tableView.detailModel.mdseTypePropertyDtos[index];
        for (WaresTypeModel * subModel in typeModel.models)
        {
            if ([typeId isEqualToString:subModel.typeId])
            {
                subModel.statue = WaresTypeSelect;
                [typeDtos addObject:@{@"type" : typeModel.name,@"value" : subModel.name}];
            }
        }
    }
    
    CarGoodModel *goodModel = [[CarGoodModel alloc] init];
    goodModel.waresId = self.tableView.detailId;
    goodModel.mdseName = self.tableView.detailModel.mdseName;
    goodModel.mdsePropertyId = self.tableView.detailModel.mdseId;
    goodModel.image = self.tableView.detailModel.mdseImageDto.count > 0 ? [self.tableView.detailModel.mdseImageDto firstObject][@"url"]: @"";
    goodModel.unitPrice = self.tableView.detailModel.price;
    goodModel.typeDtos = typeDtos;
    goodModel.amount = self.tableView.detailModel.buyCount;
    
    CarShopModel *shopModel = [[CarShopModel alloc] init];
    shopModel.shopId = self.tableView.detailModel.shopId;
    shopModel.shopName = self.tableView.detailModel.shopName;
    shopModel.totalYunFei = [self.tableView.detailModel.yunfei integerValue] * [self.tableView.detailModel.buyCount integerValue];
    shopModel.totalPrice = [self.tableView.detailModel.price integerValue] * [self.tableView.detailModel.buyCount integerValue];
    shopModel.buyNum = [self.tableView.detailModel.buyCount integerValue];
    shopModel.cartMdseDto = [NSMutableArray arrayWithObjects:goodModel, nil];

    CartPayModel *payModel = [[CartPayModel alloc] init];
    payModel.buyNum = [self.tableView.detailModel.buyCount integerValue];
    payModel.payMoney = [NSString stringWithFormat:@"%ld",shopModel.totalYunFei + shopModel.totalPrice];
    payModel.shopModels = [NSMutableArray arrayWithObjects:shopModel, nil];
    CarOrderInputViewController *vc = [[CarOrderInputViewController alloc] initWithPayModel:payModel];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - request
- (void)collectRequest
{
    //关注/取消关注
    __weak typeof(self) weakSelf = self;
    BMCCollectRequest *item = [[BMCCollectRequest alloc] init];
    item.collectId = self.tableView.detailId;
    item.type = @"0";
    item.collectStu = @"01900001";
    item.userId = KAccountInfo.userId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.navBar.collectBtn.selected = YES;

            ToastShowBottom(@"收藏成功");
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

- (void)delCollectRequest
{
    __weak typeof(self) weakSelf = self;
    BMCDelCollectRequest *item = [[BMCDelCollectRequest alloc] init];
    item.unCollectId = self.tableView.detailId;
    item.type = @"0";
    item.collectStu = @"01900001";
    item.userId = KAccountInfo.userId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.navBar.collectBtn.selected = NO;
            ToastShowBottom(@"取消收藏成功");
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

- (void)carAddProductRequest
{
    __weak typeof(self) weakSelf = self;
    CartAddProductRequest *item = [[CartAddProductRequest alloc] init];
    item.mdsePropertyId = self.tableView.detailModel.mdseId;
    item.userId = KAccountInfo.userId;
    item.amount = self.tableView.detailModel.buyCount;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.addedCount += [weakSelf.tableView.detailModel.buyCount integerValue];
            weakSelf.bottomView.badgeView.badgeText = _StrFormate(@"%ld",weakSelf.addedCount);
            ToastShowBottom(@"添加成功");
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



#pragma mark - get 
- (WaresDetailNavBar *)navBar
{
    if (!_navBar)
    {
        _navBar = [[WaresDetailNavBar alloc] initWithScrollView:self.tableView];
        [_navBar.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_navBar.collectBtn addTarget:self action:@selector(collectBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_navBar.shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBar;
}

- (WaresDetailTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[WaresDetailTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.protcol = self;
        [_tableView.moreFooterView.moreBtn addTarget:self action:@selector(moreCommentAction) forControlEvents:UIControlEventTouchUpInside];
        
        if (@available(iOS 11, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (WaresDetailBottomView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[WaresDetailBottomView alloc] init];
        [_bottomView.carBtn addTarget:self action:@selector(carBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.contactBtn addTarget:self action:@selector(contactBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.addCarBtn addTarget:self action:@selector(addToCarAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.buyBtn addTarget:self action:@selector(startPayAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

@end
