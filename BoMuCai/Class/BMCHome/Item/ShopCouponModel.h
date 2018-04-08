//
//  ShopCouponModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/22.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCouponModel : NSObject

@property (nonatomic, copy) NSString *couponId;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *denomination; //面额（分）

@property (nonatomic, copy) NSString *quota; //限额 (分)

@property (nonatomic, copy) NSString *useStart;//	使用开始时间

@property (nonatomic, copy) NSString *useEnd;//	使用结束时间

@property (nonatomic, copy) NSString *isEffect;//	0:生效 1:失效

@property (nonatomic, copy) NSString *useStatus;//	0:未使用1:已使用

@property (nonatomic, copy) NSString *receiveNum;

@property (nonatomic, copy) NSString *status; //0不可用 1可用

@property (nonatomic, assign) BOOL enable;

@property (nonatomic, assign) BOOL select;

@end
