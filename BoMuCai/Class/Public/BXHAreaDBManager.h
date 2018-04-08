//
//  BXHAreaDBManager.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXHProModel.h"
#import "BXHCityModel.h"
#import "BXHAreaModel.h"

@interface BXHAreaDBManager : NSObject

+ (BXHAreaDBManager *)defaultManeger;

- (NSArray *)getProList;

- (NSArray *)getCityListWithProId:(NSString *)proId;

- (NSArray *)getAreaListWithCityId:(NSString *)cityId;

@end
