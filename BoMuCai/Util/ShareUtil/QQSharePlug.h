//
//  QQSharePlug.h
//  QueenBK
//
//  Created by 步晓虎 on 15/8/24.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSharePlug.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentApiInterface.h>

@interface QQSharePlug : BaseSharePlug<QQApiInterfaceDelegate>

@end
