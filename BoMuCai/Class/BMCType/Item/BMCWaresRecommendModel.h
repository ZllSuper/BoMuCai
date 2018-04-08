//
//  BMCWaresRecommendModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

// 推荐商品	id:商品编号 name ：商品名称 image：图片 price：价格 assessCount：评论数量
@interface BMCWaresRecommendModel : NSObject

@property (nonatomic, copy) NSString *waresId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *assessCount;

@end
