//
//  BMCWaresDetailModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCWaresDetailModel.h"

@implementation BMCWaresDetailModel

- (instancetype)init
{
    if (self = [super init])
    {
        self.buyCount = @"1";
    }
    return self;
}

- (NSArray *)bxhIgnoredPropertyNames
{
    return @[@"buyCount"];
}

- (void)keyValueToObjecDidFinish
{
    if (self.assessDto && self.assessDto.count > 0)
    {
        self.assessDto = [BMCWaresCommentModel bxhObjectArrayWithKeyValuesArray:self.assessDto];
    }
    
    if (self.mdseTuijianDtos && self.mdseTuijianDtos.count > 0)
    {
        self.mdseTuijianDtos = [BMCWaresRecommendModel bxhObjectArrayWithKeyValuesArray:self.mdseTuijianDtos];
    }
    
    if (self.mdseTypePropertyDtos && self.mdseTypePropertyDtos.count > 0)
    {
        self.mdseTypePropertyDtos = [WaresTypeSectionModel bxhObjectArrayWithKeyValuesArray:self.mdseTypePropertyDtos];
    }
    
    if (self.mdsePropertyDtos && self.mdsePropertyDtos.count > 0)
    {
        self.mdsePropertyDtos = [BMCWaresGoupsModel bxhObjectArrayWithKeyValuesArray:self.mdsePropertyDtos];
    }
}

@end
