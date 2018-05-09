//
//  ShopTypeViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMCTypeModel.h"

typedef  NS_ENUM(NSInteger, ShopType)
{
    ShopTypeLevelOne,
    ShopTypeLevelTwo,
    ShopTypeLevelThree
};

typedef void(^ShopTypeChooseCallBack)(BMCTypeModel *model);

@interface ShopTypeViewController : UIViewController

@property (nonatomic, readonly, assign) ShopType shopType;

- (instancetype)initWithShopType:(ShopType)shopType andLevelModel:(BMCTypeModel *)model andShopId:(NSString *)shopId andShopChooseCallBack:(ShopTypeChooseCallBack)callBack;

- (instancetype)initWithShopType:(ShopType)shopType andShopId:(NSString *)shopId andShopChooseCallBack:(ShopTypeChooseCallBack)callBack;

@end
