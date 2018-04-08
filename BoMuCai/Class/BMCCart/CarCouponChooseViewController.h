//
//  CarCouponChooseViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCouponModel.h"
#import "CarShopModel.h"

@class CarCouponChooseViewController;

@protocol CarCouponChooseViewControllerDelegate <NSObject>

- (void)couponChooseViewController:(CarCouponChooseViewController *)vc couponModel:(ShopCouponModel *)chooseModel;

@end

@interface CarCouponChooseViewController : UIViewController

@property (nonatomic, weak) id <CarCouponChooseViewControllerDelegate>delegate;

@property (nonatomic, readonly, weak) CarShopModel *shopModel;

- (instancetype)initWithShopModel:(CarShopModel *)shopModel;

@end
