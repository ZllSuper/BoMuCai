//
//  WaresDetailRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresDetailRequest.h"

@implementation WaresDetailRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"waresId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_GoodsDetail;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}



@end
