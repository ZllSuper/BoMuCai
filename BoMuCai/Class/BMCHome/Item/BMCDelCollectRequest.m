//
//  BMCDelCollectRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCDelCollectRequest.h"

@implementation BMCDelCollectRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"unCollectId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_DelCollect;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
