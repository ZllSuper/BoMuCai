//
//  PCAddressModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAddressModel.h"

@implementation PCAddressModel

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"addressId" : @"id"};
}

- (NSString *)composeAddressStr
{
    return [NSString stringWithFormat:@"%@%@%@%@",self.province,self.city,self.area,self.address];
}

- (PCAddressModel *)copy
{
    PCAddressModel *copyMoel = [[PCAddressModel alloc] init];
    copyMoel.isDefault = self.isDefault;
    copyMoel.name = self.name;
    copyMoel.phone = self.phone;
    copyMoel.provinceId = self.provinceId;
    copyMoel.province = self.province;
    copyMoel.cityId = self.cityId;
    copyMoel.city = self.city;
    copyMoel.area = self.area;
    copyMoel.areaId = self.areaId;
    copyMoel.address = self.address;
    copyMoel.addressId = self.addressId;
    return copyMoel;
}

@end
