//
//  WXSharePlug.m
//  QueenBK
//
//  Created by 步晓虎 on 15/8/24.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import "WXSharePlug.h"
#import "NSString+BXHMyString.h"

@implementation WXSharePlug

- (void)shareWithTitle:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)thumbImage shareType:(BXHShareType)shareType mediaType:(BXHMediaType)mediaType media:(id)media
{
    id mediaObject = [self wxMediaObjectWithMediaType:mediaType media:media];
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    if (mediaObject)
    {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = desc;
        [message setThumbImage:thumbImage];
        message.mediaObject = mediaObject;
        req.message = message;
        req.bText = NO;

    }
    else
    {
        req.bText = YES;
        req.text = desc;
    }
    
    
    req.scene = [self getThirdShareTypeWithBXHShareType:shareType];
    BOOL success = [WXApi sendReq:req];
    if (!success)
    {
        self.callBack(ShareStatuesFail,@"未知错误",-100);
    }
}

- (id)wxMediaObjectWithMediaType:(BXHMediaType)mediaType media:(id)media
{
    switch (mediaType)
    {
        case BXHMediaText:
            
            return nil;
        case BXHMediaMusic:
        {
            WXMusicObject *musicObject = [[WXMusicObject alloc] init];
            musicObject.musicUrl = media;
            return musicObject;
        }
        case BXHMediaVedio:
        {
            WXVideoObject *vedioObject = [[WXVideoObject alloc] init];
            vedioObject.videoUrl = media;
            return vedioObject;
        }
        case BXHMediaImage:
        {
            WXImageObject *imageObject = [[WXImageObject alloc] init];
            imageObject.imageData = UIImageJPEGRepresentation(media, 1.0);
            return imageObject;
        }
        case BXHMediaWebPage:
        {
            WXWebpageObject *webPageObject = [[WXWebpageObject alloc] init];
            webPageObject.webpageUrl = media;
            return webPageObject;
        }
        default:
            break;
    }
}

- (NSInteger)getThirdShareTypeWithBXHShareType:(BXHShareType)shareType
{
    switch (shareType)
    {
        case BXHWXSceneTimeline:
            return WXSceneTimeline;
        case BXHWXSceneSession:
            return WXSceneSession;
            
        default:
            return shareType;
            break;
    }
}

#pragma maker - WXDelegate
- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if([NSString stringIsEmpty:resp.errStr]) resp.errStr = @"分享失败";
        ShareStatues statue = resp.errCode == 0 ? ShareStatuesSuccess : ShareStatuesFail;
        self.callBack(statue,resp.errStr,resp.errCode);
    }

}

@end
