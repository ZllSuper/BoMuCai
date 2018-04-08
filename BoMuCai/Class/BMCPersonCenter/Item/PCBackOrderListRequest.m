//
//  PCBackOrderListRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCBackOrderListRequest.h"

@implementation PCBackOrderListRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_BackOrderList;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
