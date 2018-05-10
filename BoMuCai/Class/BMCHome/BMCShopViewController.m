//
//  BMCShopViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCShopViewController.h"
#import "PopContainerController.h"
#import "ShopTypeViewController.h"
#import "ShopActivityListViewController.h"
#import "BMCWaresDetailViewController.h"

#import "ShopWaresCollectionView.h"
#import "ShopNavBar.h"

#import "BMCCollectRequest.h"
#import "ShopCouponTakeRequest.h"
#import "BMCDelCollectRequest.h"

@interface BMCShopViewController () <ShopWaresCollectionViewProtcol>

@property (nonatomic, strong) ShopWaresCollectionView *collectionView;

@property (nonatomic, strong) ShopNavBar *navBar;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIButton *activityBtn;

@property (nonatomic, strong) UIButton *contactBtn;

@end

@implementation BMCShopViewController

- (void)dealloc
{
    self.navBar = nil;
}

- (instancetype)initWithShopModel:(BMCShopModel *)shopModel
{
    if (self = [super init])
    {
        self.collectionView.shopId = shopModel.shopId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.typeBtn];
    [self.view addSubview:self.activityBtn];
    [self.view addSubview:self.contactBtn];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view);
        make.height.mas_equalTo(@45);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [self.activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@45);
        make.left.mas_equalTo(self.typeBtn.mas_right).offset(1);
        make.top.mas_equalTo(self.typeBtn);
        make.width.mas_equalTo(self.typeBtn);
    }];
    
    [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.activityBtn.mas_right).offset(1);
        make.top.mas_equalTo(self.activityBtn);
        make.right.mas_equalTo(self.view);
        make.width.mas_equalTo(self.activityBtn);
        make.height.mas_equalTo(@45);
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    
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

#pragma mark - request
- (void)collectRequest
{
    //关注/取消关注
    __weak typeof(self) weakSelf = self;
    BMCCollectRequest *item = [[BMCCollectRequest alloc] init];
    item.collectId = self.collectionView.shopId;
    item.type = @"2";
    item.collectStu = @"01900003";
    item.userId = KAccountInfo.userId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.navBar.rightBtn setTitle:@"取消关注" forState:UIControlStateNormal];
            ToastShowBottom(@"关注成功");
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
    item.unCollectId = self.collectionView.shopId;
    item.type = @"2";
    item.collectStu = @"01900003";
    item.userId = KAccountInfo.userId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.navBar.rightBtn setTitle:@"关注" forState:UIControlStateNormal];
            ToastShowBottom(@"取消关注成功");
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

- (void)takeCouponRequest:(ShopCouponBtn *)sender
{
    __weak typeof(self) weakSelf = self;
    ShopCouponTakeRequest *item = [[ShopCouponTakeRequest alloc] init];
    item.shopId = self.collectionView.shopId;
    item.userId = KAccountInfo.userId;
    item.couponId = sender.weakModel.couponId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            ToastShowBottom(@"优惠券领取成功");
            sender.enabled = NO;
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

#pragma mark - collectionProtcol
- (void)shopWaresCollectionView:(ShopWaresCollectionView *)collectionView actionAtIndex:(NSInteger)index
{
    BMCWaresModel *model = collectionView.waresAry[index];
    BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:model.waresId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shopWaresCollectionView:(ShopWaresCollectionView *)collectionView collectStatue:(NSString *)collectStatus
{
    if ([collectStatus boolValue])
    {
        [self.navBar.rightBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    }
    else
    {
        [self.navBar.rightBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
}

- (void)collectionView:(ShopWaresCollectionView *)collectionView couponBtnAction:(ShopCouponBtn *)sender
{
    if ([self checkIsLogin])
    {
        [self takeCouponRequest:sender];
    }
}

#pragma mark - action
- (void)leftBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rigthBtnAction
{
    if ([self checkIsLogin])
    {
        NSString *title = [self.navBar.rightBtn titleForState:UIControlStateNormal];
        if ([title isEqualToString:@"关注"])
        {
            [self collectRequest];
        }
        else
        {
            [self delCollectRequest];
        }
    }
}

- (void)typeBtnAction
{
    __weak typeof(self) weakSelf = self;
    ShopTypeViewController *vc = [[ShopTypeViewController alloc] initWithShopType:ShopTypeLevelOne andShopId:self.collectionView.shopId andShopChooseCallBack:^(BMCTypeModel *model) {
        weakSelf.collectionView.type = model.typeId;
        [weakSelf.collectionView.mj_header beginRefreshing];
    }];
    
    BaseNaviController *nav = [[BaseNaviController alloc] initWithRootViewController:vc];
    
    PopContainerController *containerVc = [[PopContainerController alloc] initWithRootViewContorller:nav];
    [self presentViewController:containerVc animated:YES completion:nil];
}

- (void)activityBtnAction
{
    ShopActivityListViewController *vc = [[ShopActivityListViewController alloc] initWithShopModel:self.collectionView.headerView.shopModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)contactBtnAction
{
    if ([self checkIsLogin])
    {
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:self.collectionView.headerView.shopModel.easemob conversationType:EMConversationTypeChat];
        chatController.title = self.collectionView.headerView.shopModel.name;
        [self.navigationController pushViewController:chatController animated:YES];
    }
}

#pragma mark - get
- (ShopWaresCollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[ShopWaresCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.protcol = self;
        
        if (@available(iOS 11, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

- (ShopNavBar *)navBar
{
    if (!_navBar)
    {
        _navBar = [[ShopNavBar alloc] initWithScrollView:self.collectionView];
        [_navBar.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_navBar.rightBtn addTarget:self action:@selector(rigthBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBar;
}

- (UIButton *)typeBtn
{
    if (!_typeBtn)
    {
        _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeBtn setImage:ImageWithName(@"ShopBottomType") forState:UIControlStateNormal];
        [_typeBtn setTitle:@"分类查找" forState:UIControlStateNormal];
        [_typeBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        [_typeBtn addTarget:self action:@selector(typeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _typeBtn.backgroundColor = Color_White;
        _typeBtn.titleLabel.font = Font_sys_14;
    }
    return _typeBtn;
}

- (UIButton *)activityBtn
{
    if (!_activityBtn)
    {
        _activityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_activityBtn setImage:ImageWithName(@"ShopBottomActivity") forState:UIControlStateNormal];
        [_activityBtn setTitle:@"店铺活动" forState:UIControlStateNormal];
        [_activityBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        [_activityBtn addTarget:self action:@selector(activityBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _activityBtn.backgroundColor = Color_White;
        _activityBtn.titleLabel.font = Font_sys_14;
    }
    return _activityBtn;
}

- (UIButton *)contactBtn
{
    if (!_contactBtn)
    {
        _contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contactBtn setImage:ImageWithName(@"ShopBottomContact") forState:UIControlStateNormal];
        [_contactBtn setTitle:@"联系卖家" forState:UIControlStateNormal];
        [_contactBtn addTarget:self action:@selector(contactBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_contactBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        _contactBtn.backgroundColor = Color_White;
        _contactBtn.titleLabel.font = Font_sys_14;
    }
    return _contactBtn;
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
