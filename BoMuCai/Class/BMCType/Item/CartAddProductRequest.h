//
//  CartAddProductRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface CartAddProductRequest : BaseMainRequest

@property (nonatomic, copy) NSString *mdsePropertyId; //mdsePropertyId

@property (nonatomic, copy) NSString *userId;//	用户编号

@property (nonatomic, copy) NSString *amount;//	数量

@end
