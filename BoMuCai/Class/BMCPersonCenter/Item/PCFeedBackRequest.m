//
//  PCFeedBackRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/6/2.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCFeedBackRequest.h"

@implementation PCFeedBackRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"qDescription" : @"description"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_FeedBack;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
