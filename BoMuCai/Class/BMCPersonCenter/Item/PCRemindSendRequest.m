//
//  PCRemindSendRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCRemindSendRequest.h"

@implementation PCRemindSendRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"orderId" : @"id"};
}

- (NSString *)remark
{
    return @"";
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_RemindSend;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}



@end
