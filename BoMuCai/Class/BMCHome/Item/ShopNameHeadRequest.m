//
//  ShopNameHeadRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopNameHeadRequest.h"

@implementation ShopNameHeadRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"shopId" : @"id"};
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.cacheTime = 60 * 30;
        self.cachePolicy = BXHRequestReturnCacheDataElseReloadRemoteData;
    }
    return self;
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KUR_ShopNameHead;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
