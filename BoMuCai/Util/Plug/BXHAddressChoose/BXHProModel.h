//
//  BXHProModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXHCityModel.h"

@interface BXHProModel : NSObject

@property (nonatomic, copy) NSString *provId;

@property (nonatomic, copy) NSString *provName;

@property (nonatomic, strong) NSMutableArray *cityList;

@end
