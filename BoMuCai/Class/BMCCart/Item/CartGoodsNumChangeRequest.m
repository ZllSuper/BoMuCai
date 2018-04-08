//
//  CartGoodsNumChangeRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/15.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CartGoodsNumChangeRequest.h"

@implementation CartGoodsNumChangeRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"goodsId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_CartGoodsNumChange;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
