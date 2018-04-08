//
//  PCAccountModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCAccountModel : NSObject

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *phone;

- (NSString *)sexToHanZi;

@end
