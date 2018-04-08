//
//  BaseSharePlug.h
//  QueenBK
//
//  Created by 步晓虎 on 15/8/24.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>
//分享类型
typedef NS_ENUM(NSInteger, BXHShareType)
{
    BXHWXSceneSession,
    BXHWXSceneTimeline,
    BXHQQFriends,
    BXHQQZone,
    BXHWeiBo,
    BXHMessage,
    BXHNormal
    
};

//多媒体类型
typedef NS_ENUM(NSInteger, BXHMediaType)
{
    BXHMediaText,
    BXHMediaImage,
    BXHMediaVedio,
    BXHMediaMusic,
    BXHMediaWebPage
};

typedef NS_ENUM(NSInteger,ShareStatues)
{
    ShareStatuesBegain,
    ShareStatuesSuccess,
    ShareStatuesFail
};

typedef void (^EndShareCallBack)(ShareStatues statue,NSString *message,NSInteger code);

@interface BaseSharePlug : NSObject

- (void)shareWithTitle:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)thumbImage shareType:(BXHShareType)shareType mediaType:(BXHMediaType)mediaType media:(id)media;

@property (nonatomic, copy) EndShareCallBack callBack;

- (void)setShareCallBack:(EndShareCallBack)callBack;

@end
