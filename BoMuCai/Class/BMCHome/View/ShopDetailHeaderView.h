//
//  ShopDetailHeaderView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCouponShowView.h"
#import "ShopIconAndNameView.h"
#import "BMCShopModel.h"

@class ShopDetailHeaderView;
@protocol ShopDetailHeaderViewProtcol <NSObject>

- (void)headerView:(ShopDetailHeaderView *)headerView couponBtnAction:(ShopCouponBtn *)sender;

@end

@interface ShopDetailHeaderView : UICollectionReusableView <ShopCouponShowViewProtcol>

@property (nonatomic, strong) ShopCouponShowView *couponView;

@property (nonatomic, strong) ShopIconAndNameView *iconNameView;

@property (nonatomic, strong) BMCShopModel *shopModel;

@property (nonatomic, strong) NSArray *couponAry;

@property (nonatomic, weak) id <ShopDetailHeaderViewProtcol>protcol;

+ (CGSize)sizeForHeader;

@end
