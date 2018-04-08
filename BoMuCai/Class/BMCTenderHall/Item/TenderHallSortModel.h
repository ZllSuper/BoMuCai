//
//  TenderHallSortModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TenderHallSortModel : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *typeId;

@property (nonatomic, copy) NSString *statue;

@property (nonatomic, copy) NSString *statueId;

@property (nonatomic, copy) NSString *pro;

@property (nonatomic, copy) NSString *proId;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *nameLike;

- (void)clear;

- (void)resetModel:(TenderHallSortModel *)model;

@end
