//
//  CartGoodsDelRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/15.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CartGoodsDelRequest.h"

@implementation CartGoodsDelRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"goodsId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_CartGoodsDel;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
