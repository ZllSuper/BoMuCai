//
//  BXHCityModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXHAreaModel.h"

@interface BXHCityModel : NSObject

@property (nonatomic, copy) NSString *cityId;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, strong) NSMutableArray *areaList;

@end
