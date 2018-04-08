//
//  CartPayModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/15.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CartPayModel.h"

@implementation CartPayModel

- (CartPayModel *)init
{
    if (self = [super init])
    {
        self.shopModels = [NSMutableArray array];
        self.buyNum = 0;
    }
    return self;
}

@end
