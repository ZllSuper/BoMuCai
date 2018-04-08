//
//  PCAddressCreatRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCAddressCreatRequest : BaseMainRequest

@property (nonatomic, copy) NSString *userId; //	用户Id

@property (nonatomic, copy) NSString *name;//	收货人

@property (nonatomic, copy) NSString *phone;//	联系电话

@property (nonatomic, copy) NSString *province;//	省份

@property (nonatomic, copy) NSString *city;//	城市

@property (nonatomic, copy) NSString *area;//	区

@property (nonatomic, copy) NSString *address;//	详细地址

@end
