//
//  BMCWaresCommentModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
//评论集合	nickName:昵称 photo:头像 starLevel：评价星等 createTime：发布时间 introduce：内容
@interface BMCWaresCommentModel : NSObject

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *starLevel;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *introduce;

@end
