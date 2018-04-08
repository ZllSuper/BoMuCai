//
//  WaresTypeSectionModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaresTypeModel.h"

@interface WaresTypeSectionModel : NSObject

@property (nonatomic, strong) NSArray <WaresTypeModel *>*models;

@property (nonatomic, copy) NSString *name;

@end
