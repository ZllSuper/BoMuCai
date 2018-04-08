//
//  CartGoodsNumChangeRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/15.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface CartGoodsNumChangeRequest : BaseMainRequest

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *goodsId;

@end
