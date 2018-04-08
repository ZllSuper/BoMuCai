//
//  PCAboutUsDetailRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

#define Type_WangZhanJieShao @"00800005"
#define Type_GongShiJieShao @"00800006"
#define Type_FaLvShenMing @"00800007"


@interface PCAboutUsDetailRequest : BaseMainRequest

@property (nonatomic, copy) NSString *type; //00800005  网站介绍 00800006  公司介绍 00800007  法律声明

@end
