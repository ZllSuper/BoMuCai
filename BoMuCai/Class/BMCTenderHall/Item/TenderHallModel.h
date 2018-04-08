//
//  TenderHallModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/28.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TenderHallModel : NSObject

@property (nonatomic, copy) NSString *hallId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *typeId;

@property (nonatomic, copy) NSString *beginDate;

@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, copy) NSString *tenderStatus;

- (NSString *)switchTenderStatue;

@end
