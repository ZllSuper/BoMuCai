//
//  CarGoodModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarGoodModel.h"

@implementation CarGoodModel

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"waresId" : @"id"};
}

- (NSArray *)bxhIgnoredPropertyNames
{
    return @[@"select"];
}

+ (CarGoodModel *)copyWith:(CarGoodModel *)model
{
    CarGoodModel *goodModel = [[CarGoodModel alloc] init];
    goodModel.waresId = model.waresId;
    goodModel.mdsePropertyId = model.mdsePropertyId;
    goodModel.mdseName = model.mdseName;
    goodModel.image = model.image;
    goodModel.unitPrice = model.unitPrice;
    goodModel.amount = model.amount;
    goodModel.stock = model.stock;
    goodModel.typeDtos = model.typeDtos;
    goodModel.yunfei = model.yunfei;
    return goodModel;
}

- (NSString *)typeDtoToStr
{
    NSString *result = @"";
    for (NSDictionary *dict in self.typeDtos)
    {
        if (result.length == 0)
        {
            result = [NSString stringWithFormat:@"%@-%@",dict[@"type"],dict[@"value"]];
        }
        else
        {
            result = [NSString stringWithFormat:@"%@ %@-%@",result,dict[@"type"],dict[@"value"]];
        }
    }
    return result;
}

@end
