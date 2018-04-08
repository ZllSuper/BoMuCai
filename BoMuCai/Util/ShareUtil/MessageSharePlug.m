//
//  MessageSharePlug.m
//  QueenBK
//
//  Created by 步晓虎 on 15/8/24.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import "MessageSharePlug.h"

@implementation MessageSharePlug

- (void)shareWithTitle:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)thumbImage shareType:(BXHShareType)shareType mediaType:(BXHMediaType)mediaType media:(id)media
{
    if ([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController *messageVc = [[MFMessageComposeViewController alloc]init];
        
        switch (mediaType)
        {
            case BXHMediaText:
            {
                messageVc.body = desc;
            }
                break;
            case BXHMediaImage:
            {
                if([MFMessageComposeViewController canSendAttachments])
                {
                    messageVc.body = desc;
                    [messageVc addAttachmentData:UIImageJPEGRepresentation(media, 1.0) typeIdentifier:@"public.image" filename:@"photo.jpg"];
                }
                else
                {
                    self.callBack(ShareStatuesFail,@"手机不支持发图片",-1);
                    return;
                }
            }
                break;
            case BXHMediaWebPage:
            {
                messageVc.body = [desc stringByAppendingString:media];
            }
                break;
            case BXHMediaMusic:
            {
                
            }
                break;
            case BXHMediaVedio:
            {
            
            }
                break;
            default:
                break;
        }
        
        messageVc.messageComposeDelegate = self;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:messageVc animated:true completion:nil];
    }
    else
    {
        self.callBack(ShareStatuesFail,@"手机不支持消息",-1);
    }
}


#pragma mark - MessageDelegate
-(void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:true completion:nil];
    switch (result)
    {
        case MessageComposeResultCancelled:
        {
            self.callBack(ShareStatuesFail,@"取消发送",0);
            break;
        }
        case MessageComposeResultFailed:
        {
            self.callBack(ShareStatuesFail,@"发送失败",2);
        }
            break;
        case MessageComposeResultSent:
        {
            self.callBack(ShareStatuesSuccess,@"发送成功",1);
        }
            break;
        default:
            break;
    }
}
@end
