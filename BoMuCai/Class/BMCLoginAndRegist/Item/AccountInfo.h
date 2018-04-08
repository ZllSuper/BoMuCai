//
//  AccountInfo.h
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/2/29.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KAccountInfo  ([AccountInfo shareInstance])

typedef void(^AccountLogOutCallBack)();

typedef void(^AccountLoginCallBack)();

@interface AccountInfo : NSObject

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *easemob;
@property (nonatomic, copy) NSString *easemobPassword;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *point;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *maxIntegral;

@property (nonatomic, copy) NSString *levelScling;

+ (AccountInfo *)shareInstance;

- (BOOL)saveToDisk;

- (void)resetSourceWithDict:(NSDictionary *)dict;

- (BOOL)logout;

- (void)monitorWithLogOut:(AccountLogOutCallBack)callBack;

- (void)monitorWithlogin:(AccountLoginCallBack)callBack;


@end
