//
//  PCOrderCommentRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/5/26.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderCommentRequest.h"

@implementation PCOrderCommentRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_OrderComment;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end
