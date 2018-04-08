//
//  BaseSharePlug.m
//  QueenBK
//
//  Created by 步晓虎 on 15/8/24.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import "BaseSharePlug.h"

@implementation BaseSharePlug

- (void)shareWithTitle:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)thumbImage shareType:(BXHShareType)shareType mediaType:(BXHMediaType)mediaTyep media:(id)media delegate:(id)deleagte
{
    
}


- (void)setShareCallBack:(EndShareCallBack)callBack
{
    self.callBack = callBack;
}

@end
