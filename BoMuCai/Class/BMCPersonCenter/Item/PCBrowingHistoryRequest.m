//
//  PCBrowingHistoryRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCBrowingHistoryRequest.h"

@implementation PCBrowingHistoryRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_BrowsingHistory;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end
