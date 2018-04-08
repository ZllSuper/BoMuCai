//
//  BMCShopModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCShopModel : NSObject

@property (nonatomic, copy) NSString *shopId; //店铺id

@property (nonatomic, copy) NSString *name;//店铺名称

@property (nonatomic, copy) NSString *phone;//店铺电话

@property (nonatomic, copy) NSString *image;//店铺icon

@property (nonatomic, copy) NSString *realName;//真实姓名

@property (nonatomic, copy) NSString *province; //省

@property (nonatomic, copy) NSString *city;//市

@property (nonatomic, copy) NSString *area;//区

@property (nonatomic, copy) NSString *address;//公司地址

@property (nonatomic, copy) NSString *careNum;//	关注数

@property (nonatomic, copy) NSString *shopLevel; //	店铺等级

@property (nonatomic, copy) NSString *auditingStatus; //	审核状态	00100001：未审核 00100002：已通过 00100003：已拒绝

@property (nonatomic, copy) NSString *easemob; //环信id

@end
