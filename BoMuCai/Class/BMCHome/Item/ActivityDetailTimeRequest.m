//
//  ActivityDetailTimeRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ActivityDetailTimeRequest.h"

@implementation ActivityDetailTimeRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"activityId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_ActivityDetailTime;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end
