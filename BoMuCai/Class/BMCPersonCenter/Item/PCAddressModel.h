//
//  PCAddressModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCAddressModel : NSObject

@property (nonatomic, copy) NSString *isDefault;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *provinceId;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *cityId;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *areaId;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *addressId;

- (NSString *)composeAddressStr;

- (PCAddressModel *)copy;

@end
