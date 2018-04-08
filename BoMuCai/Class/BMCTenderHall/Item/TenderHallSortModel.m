//
//  TenderHallSortModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallSortModel.h"

@implementation TenderHallSortModel

- (instancetype) init
{
    if (self = [super init])
    {
        self.type = @"";
        self.typeId = @"";
        self.statue = @"";
        self.statueId = @"";
        self.pro = @"";
        self.proId = @"";
        self.startTime = @"";
        self.endTime = @"";
        self.nameLike = @"";
    }
    return self;
}

- (void)clear
{
    self.type = @"";
    self.typeId = @"";
    self.statue = @"";
    self.statueId = @"";
    self.pro = @"";
    self.proId = @"";
    self.startTime = @"";
    self.endTime = @"";
    self.nameLike = @"";

}

- (void)resetModel:(TenderHallSortModel *)model
{
    self.type = model.type;
    self.typeId = model.typeId;
    self.statue = model.statue;
    self.statueId = model.statueId;
    self.pro = model.pro;
    self.proId = model.proId;
    self.startTime = model.startTime;
    self.endTime = model.endTime;
    self.nameLike = model.nameLike;

}

@end
