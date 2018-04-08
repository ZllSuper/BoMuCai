//
//  PCQuestionAnswerRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCQuestionAnswerRequest.h"

@implementation PCQuestionAnswerRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"questionId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_NormalQuestionAnswer;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
