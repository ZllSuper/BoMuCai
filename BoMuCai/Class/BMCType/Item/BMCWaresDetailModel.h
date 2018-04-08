//
//  BMCWaresDetailModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMCWaresCommentModel.h"
#import "BMCWaresRecommendModel.h"
#import "WaresTypeSectionModel.h"
#import "BMCWaresGoupsModel.h"

@interface BMCWaresDetailModel : NSObject

@property (nonatomic, copy) NSString *buyCount; //购买数量

@property (nonatomic, copy) NSString *mdseId; //	商品编号

@property (nonatomic, copy) NSString *shopName; //	店铺名称

@property (nonatomic, copy) NSString *shopId; //	店铺编号

@property (nonatomic, copy) NSString *shopLogo;	//店铺logo

@property (nonatomic, copy) NSString *mdseName;	//商品名称

@property (nonatomic, copy) NSString *repertory; //	库存

@property (nonatomic, copy) NSString *price;//	价格

@property (nonatomic, copy) NSString *assessCount;//	评价数量

@property (nonatomic, copy) NSString *buyNum; //	总销量

@property (nonatomic, copy) NSString *yunfei; //运费

@property (nonatomic, copy) NSString *morenfenlei; //默认分类id

@property (nonatomic, copy) NSString *remark; //商品详情

@property (nonatomic, copy) NSString *collection; //0未收藏1已收藏

@property (nonatomic, copy) NSString *easemobId;

@property (nonatomic, copy) NSArray *assessDto;//评论集合	nickName:昵称 photo:头像 starLevel：评价星等 createTime：发布时间 introduce：内容

@property (nonatomic, copy) NSArray *mdseImageDto;//	轮播图

@property (nonatomic, copy) NSArray *mdseTypePropertyDtos;// 属性集合	name:属性名

@property (nonatomic, copy) NSArray *mdseTuijianDtos; // 推荐商品	id:商品编号 name ：商品名称 image：图片 price：价格 assessCount：评论数量

@property (nonatomic, copy) NSArray *mdsePropertyDtos;// 商品排列组合	id：组合id， propertyValue：属性id组合逗号分隔 amount：库存 unitPrice：单价

@end
