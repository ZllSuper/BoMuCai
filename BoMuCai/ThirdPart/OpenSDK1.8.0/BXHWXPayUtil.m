//
//  BXHWXPayUtil.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/9/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHWXPayUtil.h"

@interface BXHWXPayUtil()

@property (nonatomic, copy) PayResultCallBack callBack;

@end

@implementation BXHWXPayUtil

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static BXHWXPayUtil *util;
    dispatch_once(&onceToken, ^{
        util = [[BXHWXPayUtil alloc] init];
    });
    return util;
}

+ (void)registAppWithAppKey:(NSString *)appKey
{
   BOOL ret = [WXApi registerApp:appKey];
    if (!ret)
    {
        NSLog(@"注册失败");
    }
}

- (void)handleOpenUrl:(NSURL *)url
{
    [WXApi handleOpenURL:url delegate:self];
}

- (void)startPayWithPayModel:(BCPayModel *)payModel withCallBack:(PayResultCallBack)callBack
{
    self.callBack = callBack;
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = payModel.partnerid;
    request.prepayId = payModel.prepayid;
    request.nonceStr = payModel.noncestr;
    request.timeStamp = [payModel.timestamp intValue];
    request.package = payModel.package;
    request.sign = payModel.sign;
    [WXApi sendReq:request];
}


#pragma mark - wxPayResponse
//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    if([resp isKindOfClass:[PayResp class]])
    {
        NSString *payResoult = @"";
        BOOL success = NO;
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付成功！";
                success = YES;
                break;
            case -1:
                payResoult = @"支付失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
        self.callBack(success, payResoult);
    }
}


@end
