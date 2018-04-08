//
//  CartOrderSubmitRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/12.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface CartOrderSubmitRequest : BaseMainRequest

@property (nonatomic, copy) NSString *propertyStr; //	商品property编号|购买数量,商品property编号|购买数量

@property (nonatomic, copy) NSString *couponStr; //	优惠券

@property (nonatomic, copy) NSString *addresId; //	地址

@property (nonatomic, copy) NSString *userId; //	用户编号

@end
