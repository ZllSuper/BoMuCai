//
//  WaresTypeModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WaresTypeStatue)
{
    WaresTypeNormal,
    WaresTypeSelect,
    WaresTypeUnenable
};

#define EMPTY_SEL @"空"

@interface WaresTypeModel : NSObject

@property (nonatomic, copy) NSString *typeId;

@property (nonatomic, copy) NSString *name;

//@property (nonatomic, copy) NSString *count;

@property (nonatomic, assign) WaresTypeStatue statue;

@end
