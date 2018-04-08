//
//  WaresAllCommentRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/7/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresAllCommentRequest.h"

@implementation WaresAllCommentRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"waresId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_GoodsAllComment;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
