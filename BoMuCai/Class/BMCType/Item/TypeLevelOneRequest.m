//
//  TypeLevelOneRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TypeLevelOneRequest.h"

@implementation TypeLevelOneRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"shopId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_TypeLevelOne;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end
