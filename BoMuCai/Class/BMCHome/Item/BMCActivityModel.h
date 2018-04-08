//
//  BMCActivityModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCActivityModel : NSObject

@property (nonatomic, copy) NSString *activityId;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *imageApp;

@property (nonatomic, copy) NSString *activityImageApp;

@property (nonatomic, copy) NSString *abstracts; //摘要

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *endDate;

@end
