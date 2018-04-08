//
//  ActivityListCollectionVIew.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ActivityListCollectionVIew.h"

@interface  ActivityListCollectionVIew()

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, weak) ActivityHeaderView *headerView;

@end

@implementation ActivityListCollectionVIew

- (void)dealloc
{
    [self.headerView.timeView stopCountDown];
    self.headerView.timeView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)layout;
    [flowLayout setSectionInset:UIEdgeInsetsMake(1, 0, 0, 0)];
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout])
    {
        self.sourceAry = [NSMutableArray array];
        
        self.backgroundColor = Color_Gray_Line;
        
        self.dataSource = self;
        self.delegate = self;
        
        [self creatHeader];
        [self creatFooter];
        
        [self registerNib:[UINib nibWithNibName:[ActivityListCell className] bundle:nil] forCellWithReuseIdentifier:[ActivityListCell className]];
        [self registerClass:[ActivityHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[ActivityHeaderView className]];
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

- (void)endRefresh
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    ActivityDetailRequest *waresRequest = [[ActivityDetailRequest alloc] init];
    waresRequest.curPage = [NSString stringWithFormat:@"%ld",self.page];
    waresRequest.pageSize = @"10";
    waresRequest.activityId = self.activityId;
    
    ActivityDetailTimeRequest *timeRequest = [[ActivityDetailTimeRequest alloc] init];
    timeRequest.activityId = self.activityId;
    
    self.container = [[BXHRequestContainer alloc] init];
    
    if (!refresh)
    {
        self.container.requestAry = @[waresRequest];
    }
    else
    {
        self.container.requestAry = @[timeRequest,waresRequest];
    }
    
    ProgressShow(self.superview);
    [self.container chainRequestWithSuccess:^BOOL( BXHBaseRequest *request, BOOL end) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            if([request isKindOfClass:[ActivityDetailRequest class]])
            {
                [weakSelf listSourceDeal:request.response refresh:refresh];
            }
            else if ([request isKindOfClass:[ActivityDetailTimeRequest class]])
            {
                [weakSelf timeSourceDeal:request.response];
            }
            if (end)
            {
                ProgressHidden(weakSelf.superview);
                [weakSelf endRefresh];
            }
            return YES;
        }
        else
        {
            ProgressHidden(weakSelf.superview);
            ToastShowBottom(request.response.message);
            [weakSelf endRefresh];
            return NO;
        }
        
    } failure:^BOOL(NSError *error, BXHBaseRequest *request, BOOL end) {
        ProgressHidden(weakSelf.superview);
        ToastShowBottom(NetWorkErrorTip);
        [weakSelf endRefresh];
        return NO;
    }];
}

- (void)listSourceDeal:(BXHResponse *)response refresh:(BOOL)refresh
{
    if (refresh)
    {
        [self.sourceAry removeAllObjects];
    }
    
    [self.sourceAry addObjectsFromArray:[BMCWaresModel bxhObjectArrayWithKeyValuesArray:response.data]];
    [self reloadData];
}

- (void)timeSourceDeal:(BXHResponse *)response
{
    [self.headerView.timeView startCountDown:[response.data longLongValue] / 1000];
}

#pragma mark - delegate / datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sourceAry.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (!self.headerView)
    {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[ActivityHeaderView className] forIndexPath:indexPath];
        [self.headerView.imageView sd_setImageWithURL:[NSURL encodeURLWithString:self.headerImage] placeholderImage:ImagePlaceHolder];
    }
    return self.headerView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityListCell className] forIndexPath:indexPath];
    cell.weakModel = self.sourceAry[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.protcol collectionView:self indexPathAction:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((DEF_SCREENWIDTH - 1) / 2, (DEF_SCREENWIDTH - 1) / 2 * (33 / 35.0));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return [ActivityHeaderView sizeForHeader];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
