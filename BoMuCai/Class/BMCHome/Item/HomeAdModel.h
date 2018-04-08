//
//  HomeAdModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeAdModel : NSObject

@property (nonatomic, copy) NSString *adId; //	编码

@property (nonatomic, copy) NSString *name;//	名称

@property (nonatomic, copy) NSString *image;//	图片

@property (nonatomic, copy) NSString *linkType;//	链接类型  0:商品 1:活动 2:外部链接 3:富文本

@property (nonatomic, copy) NSString *linkUrl;//	链接地址

@property (nonatomic, copy) NSString *remarks;//	富文本描述

@end
