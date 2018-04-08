//
//  ShopCouponShowView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/22.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCouponBtn.h"
#import "ShopCouponModel.h"

#define ItemWidth (DEF_SCREENWIDTH - 84) / 3
#define ItemHeight ItemWidth * (47.0 / 85)

@class ShopCouponShowView;
@protocol ShopCouponShowViewProtcol <NSObject>

- (void)showView:(ShopCouponShowView *)showView couponBtnAction:(ShopCouponBtn *)btn;

@end

@interface ShopCouponShowView : UIScrollView

@property (nonatomic, strong) NSArray *shopCouponModelAry;

@property (nonatomic, weak) id <ShopCouponShowViewProtcol>protcol;

@end
