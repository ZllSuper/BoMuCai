//
//  ShopWaresCollectionView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailHeaderView.h"
#import "ActivityListCell.h"


#import "ShopDetailRequest.h"
#import "GoodsSearchRequest.h"

@class ShopWaresCollectionView;

@protocol ShopWaresCollectionViewProtcol <NSObject>

- (void)shopWaresCollectionView:(ShopWaresCollectionView *)collectionView actionAtIndex:(NSInteger)index;

- (void)shopWaresCollectionView:(ShopWaresCollectionView *)collectionView collectStatue:(NSString *)collectStatus;

- (void)collectionView:(ShopWaresCollectionView *)collectionView couponBtnAction:(ShopCouponBtn *)sender;

@end

@interface ShopWaresCollectionView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ShopDetailHeaderViewProtcol>

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, weak) ShopDetailHeaderView *headerView;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSMutableArray *waresAry;

@property (nonatomic, strong) BXHRequestContainer *container;

@property (nonatomic, weak) id <ShopWaresCollectionViewProtcol>protcol;

@end
