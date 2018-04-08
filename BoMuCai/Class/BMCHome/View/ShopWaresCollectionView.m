//
//  ShopWaresCollectionView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopWaresCollectionView.h"

@implementation ShopWaresCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)layout;
    [flowLayout setSectionInset:UIEdgeInsetsMake(1, 0, 0, 0)];
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout])
    {
        self.type = @"";
        
        self.waresAry = [NSMutableArray array];
        
        self.backgroundColor = Color_Gray_Line;
        
        self.dataSource = self;
        self.delegate = self;
        
        [self creatHeader];
        [self creatFooter];
        
        [self registerNib:[UINib nibWithNibName:[ActivityListCell className] bundle:nil] forCellWithReuseIdentifier:[ActivityListCell className]];
        [self registerClass:[ShopDetailHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[ShopDetailHeaderView className]];
    }
    return self;
}

- (void)creatFooter
{
    self.mj_footer = [BXHRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
}

- (void)creatHeader
{
    self.mj_header = [BXHRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
}

#pragma mark - private

- (void)headerRefreshAction
{
    self.page = 1;
    [self requestViewSource:YES];
}

- (void)footerRefreshAction
{
    self.page ++;
    [self requestViewSource:NO];
}

- (void)requestViewSource:(BOOL)refresh
{
    
    __weak typeof(self) weakSelf = self;
    ShopDetailRequest *detailRequest = [[ShopDetailRequest alloc] init];
    detailRequest.shopId = self.shopId;
    detailRequest.userId = KAccountInfo.userId;
    GoodsSearchRequest *goodsRequest = [[GoodsSearchRequest alloc] init];
    goodsRequest.type = self.type;
    goodsRequest.pageSize = @"10";
    goodsRequest.curPage = [NSString stringWithFormat:@"%ld",self.page];
    goodsRequest.sortAccording = @"buyNum DESC,starLevel DESC,unitPrice ASC";
    goodsRequest.shopId = self.shopId;
    self.container = [[BXHRequestContainer alloc] init];
    
    if (!refresh)
    {
        self.container.requestAry = @[goodsRequest];
    }
    else
    {
        self.container.requestAry = @[detailRequest,goodsRequest];
    }
    
    [self.container chainRequestWithSuccess:^BOOL( BXHBaseRequest *request, BOOL end) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            if([request isKindOfClass:[ShopDetailRequest class]])
            {
                [weakSelf dealWithDetailRequest:request.response];
            }
            else if ([request isKindOfClass:[GoodsSearchRequest class]])
            {
                [weakSelf dealWithGoodsRequest:request.response refresh:refresh];
            }
            if (end)
            {
                [weakSelf endRefresh];
            }
            return YES;
        }
        else
        {
            ToastShowBottom(request.response.message);
            [weakSelf endRefresh];
            return NO;
        }
        
    } failure:^BOOL(NSError *error, BXHBaseRequest *request, BOOL end) {
        ToastShowBottom(NetWorkErrorTip);
        [weakSelf endRefresh];
        return NO;
    }];
}

- (void)dealWithDetailRequest:(BXHResponse *)response
{
   self.headerView.shopModel = [BMCShopModel bxhObjectWithKeyValues:response.data[@"shopDto"]];
   self.headerView.couponAry = [ShopCouponModel bxhObjectArrayWithKeyValuesArray:response.data[@"couponDtoList"]];
    [self.protcol shopWaresCollectionView:self collectStatue:response.data[@"collectStatus"]];
}

- (void)dealWithGoodsRequest:(BXHResponse *)response refresh:(BOOL)refresh
{
    if (refresh)
    {
        [self.waresAry removeAllObjects];
    }
    
    [self.waresAry addObjectsFromArray:[BMCWaresModel bxhObjectArrayWithKeyValuesArray:response.data]];
    [self reloadData];
}

- (void)endRefresh
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)headerView:(ShopDetailHeaderView *)headerView couponBtnAction:(ShopCouponBtn *)sender
{
    [self.protcol collectionView:self couponBtnAction:sender];
}

#pragma mark - delegate / datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.waresAry.count;;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (!self.headerView)
    {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[ShopDetailHeaderView className] forIndexPath:indexPath];
        self.headerView.protcol = self;
    }
    return self.headerView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityListCell className] forIndexPath:indexPath];
    cell.weakModel = self.waresAry[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((DEF_SCREENWIDTH - 1) / 2, (DEF_SCREENWIDTH - 1) / 2 * (33 / 35.0));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return [ShopDetailHeaderView sizeForHeader];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.protcol shopWaresCollectionView:self actionAtIndex:indexPath.item];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
