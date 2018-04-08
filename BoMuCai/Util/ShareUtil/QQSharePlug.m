//
//  QQSharePlug.m
//  QueenBK
//
//  Created by 步晓虎 on 15/8/24.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import "QQSharePlug.h"


@implementation QQSharePlug

- (void)shareWithTitle:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)thumbImage shareType:(BXHShareType)shareType mediaType:(BXHMediaType)mediaType media:(id)media
{
    QQApiObject *objc = [self qqApiObjecWithitle:title descStr:desc thumbImage:thumbImage shareType:shareType mediaType:mediaType media:media];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:objc];
    
    QQApiSendResultCode sent;
    if (shareType == BXHQQFriends)
    {
        sent = [QQApiInterface sendReq:req];
    }
    else
    {
        sent = [QQApiInterface SendReqToQZone:req];
    }
    NSLog(@"%d",sent);
    if (sent != 0)
    {
        self.callBack(ShareStatuesFail,@"权限问题",sent);
    }
}


- (QQApiObject *)qqApiObjecWithitle:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)thumbImage shareType:(BXHShareType)shareType mediaType:(BXHMediaType)mediaType media:(id)media
{
    NSData* data = UIImageJPEGRepresentation(thumbImage, 0.8);
    
    switch (mediaType)
    {
        case BXHMediaText:
        {
            QQApiTextObject *textObject = [[QQApiTextObject alloc] initWithText:desc];
            textObject.title = title;
            textObject.description = desc;
            return textObject;
        }
        case BXHMediaMusic:
        {
            return nil;
        }
        case BXHMediaVedio:
        {
            return nil;
        }
        case BXHMediaImage:
        {
            QQApiImageObject *imageObject = [[QQApiImageObject alloc] initWithData:UIImageJPEGRepresentation(media, 1.0) previewImageData:data title:title description:desc];
            return imageObject;
        }
        case BXHMediaWebPage:
        {
            NSURL* url = [NSURL URLWithString:media];
            QQApiNewsObject* webPageObject = [QQApiNewsObject objectWithURL:url title:title description:desc previewImageData:data];
            return webPageObject;
        }
        default:
            break;
    }
}

#pragma mark - QQApiDelegate
- (void)onResp:(QQBaseResp *)resp
{
    if ([resp isKindOfClass:[SendMessageToQQResp class]])
    {
        SendMessageToQQResp *sResp = (SendMessageToQQResp *)resp;
        ShareStatues statue = [sResp.result integerValue] == 0 ? ShareStatuesSuccess : ShareStatuesFail;
        self.callBack(statue,resp.errorDescription,resp.result.integerValue);
    }

}



@end
