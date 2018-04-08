//
//  WBSharePlug.m
//  QueenBK
//
//  Created by 步晓虎 on 15/8/24.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import "WBSharePlug.h"
#import "NSString+BXHMyString.h"

@implementation WBSharePlug

- (void)shareWithTitle:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)thumbImage shareType:(BXHShareType)shareType mediaType:(BXHMediaType)mediaType media:(id)media
{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = desc;

    switch (mediaType)
    {
        case BXHMediaText:
        {
            message.text = desc;
        }
            break;
        case BXHMediaImage:
        {
            WBImageObject *image = [WBImageObject object];
            image.imageData = UIImageJPEGRepresentation(media, 1.0);
            message.imageObject = image;
        }
            break;
        case BXHMediaWebPage:
        {
            WBWebpageObject *webpage = [WBWebpageObject object];
            webpage.objectID = [NSString generateUuidString];
            webpage.title = title;
            webpage.description = [NSString stringWithFormat:@"%@-%.0f",desc,[[NSDate date] timeIntervalSince1970]];
            webpage.thumbnailData = UIImageJPEGRepresentation(thumbImage, 1.0);
            webpage.webpageUrl = media;
            message.mediaObject = webpage;
        }
            break;
        case BXHMediaVedio:
        {
        
        }
            break;
        case BXHMediaMusic:
        {
        
        }
            break;
        default:
            break;
    }

    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    BOOL success = [WeiboSDK sendRequest:request];
    if (!success)
    {
        self.callBack(ShareStatuesFail,@"未知错误",-100);
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
        switch (response.statusCode)
        {
            case WeiboSDKResponseStatusCodeSuccess:
            {
                self.callBack(ShareStatuesSuccess,@"分享成功",0);
            }
                break;
            case WeiboSDKResponseStatusCodeUserCancel:
            {
                self.callBack(ShareStatuesFail,@"取消分享",-1);
            }
                break;
            default:
            {
                self.callBack(ShareStatuesFail,@"分享失败",(int)response.statusCode);
            }
                break;
        }
        
//    else if ([response isKindOfClass:WBAuthorizeResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"认证结果", nil);
//        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        
//        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
//        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
//        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
//        [alert show];
//    }
//    else if ([response isKindOfClass:WBPaymentResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"支付结果", nil);
//        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
//    else if([response isKindOfClass:WBSDKAppRecommendResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"邀请结果", nil);
//        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
}


@end
