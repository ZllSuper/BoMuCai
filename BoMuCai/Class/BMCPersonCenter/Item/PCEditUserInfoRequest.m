//
//  PCEditUserInfoRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCEditUserInfoRequest.h"

@interface PCEditUserInfoRequest ()

@property (nonatomic, strong) NSMutableDictionary *sourceDict;

@end

@implementation PCEditUserInfoRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_EditUserInfo;
    self.reuqestBody = self.sourceDict;
    self.method = BXHRequestMethodPost;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    [self.sourceDict setValue:value forKey:key];
}

- (void)setUserId:(NSString *)userId
{
    _userId = userId;
    [self.sourceDict setObject:userId forKey:@"id"];
}
//
//- (void)setAddress:(NSString *)address
//{
//    _address = address;
//    [self.sourceDict setObject:address forKey:@"address"];
//}
//
//- (void)setPhone:(NSString *)phone
//{
//    _phone = phone;
//    [self.sourceDict setObject:phone forKey:@"phone"];
//}
//
//- (void)setEmail:(NSString *)email
//{
//    _email = email;
//    [self.sourceDict setObject:email forKey:@"email"];
//}
//
//- (void)setSex:(NSString *)sex
//{
//    _sex = sex;
//    [self.sourceDict setObject:sex forKey:@"sex"];
//}
//
//- (void)setQq:(NSString *)qq
//{
//    _qq = qq;
//    [self.sourceDict setObject:qq forKey:@"qq"];
//}
//
//- (void)setCompanyName:(NSString *)companyName
//{
//    _companyName = companyName;
//    [self.sourceDict setObject:companyName forKey:@"companyName"];
//}
//
//- (void)setNickName:(NSString *)nickName
//{
//    _nickName = nickName;
//    [self.sourceDict setObject:nickName forKey:@"nickName"];
//}

- (NSMutableDictionary *)sourceDict
{
    if (!_sourceDict)
    {
        _sourceDict = [[NSMutableDictionary alloc] init];
    }
    return _sourceDict;
}

@end
