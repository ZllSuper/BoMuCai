//
//  BMCDelCollectRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface BMCDelCollectRequest : BaseMainRequest

@property (nonatomic, copy) NSString *unCollectId;//uncollectId

@property (nonatomic, copy) NSString *type;//	0:收藏 1:点赞 2:关注

@property (nonatomic, copy) NSString *collectStu;//	01900001:商品 01900002:话题 01900003:店铺

@property (nonatomic, copy) NSString *userId;

@end
