//
//  BMCTypeModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCTypeModel : NSObject

@property (nonatomic, copy) NSString *typeId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *parentId;

@property (nonatomic, copy) NSString *typeSort;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, strong) NSArray *mdseTypeDtoList;

@end
