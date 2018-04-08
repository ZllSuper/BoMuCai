//
//  ShopDetailRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface ShopDetailRequest : BaseMainRequest

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *userId;

@end
