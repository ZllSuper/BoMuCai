//
//  BXHPayUtil.m
//  GuoGangTong
//
//  Created by 步晓虎 on 2017/1/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHPayUtil.h"
#import "Order.h"

static NSString *const appId = @"2017022305834619";

static NSString *const seller_id = @"2088621149835423";

static NSString *const rsaPrivateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMIQpXQoeyBq9jdGeovR9QstZ/BoLw6rM4N3iAjosds5PSf/UaByGvhEiT5MnBuKYS8bGicDyyabFZMphlXNxjVitoD+RyC6ErLwS4BrTpVdisyiHxUX2rPLWcg95Xy+PHuoXHHM1SNmj+TLWNx7Cf7Id8P+A6T2KoPte1lMw9qdAgMBAAECgYEAhURDKqKF8zwgutK2YwAao8NZpjkVX6BnrrdN/rg1MxN6kNX/awwQwz7ldJfNeAguNtgIvJQZVPiY90dDzfaSTnH2SXPrLcOi4YCFqASZxG2+G18SqlyDozB+bU+WEjfyKd3KxemKgMehMFxEvIzcyKbYpxO5IYJaf6VFwQJglY0CQQDv8bGafPEvwFV+9M9Isz99TDvQaTTt43HaXLv2qFRSpW/9BXadnBT7eOM1o+D9owN5uNPSJVrDqsuubrihmZ9fAkEAzw0IE+rZd3eZfFVIqzv3Sel/RowKrsCldOgyKAON1JZep9CqgwaN3Orx7CO0kLTRHT09m/FfY5JKuF8z0rTTgwJASKVCgmWFmFGBERkJkRdEB6mHCohvz/5mwBgHiJxaO1N/XnnC+eEBsUlecSUWv3QVX0sIRr2sh0U0ubEoETUzvQJAW1nhjYAZkJcpFe0+0aX0dhzaNdMFx5JhrdHghz0CL6BkhOAQyxxyLN1P/aLHQO02MhNaAlqdfn4GD5CZecakZwJBAK1dNX44D3TARhp7KD732l5nuM5xzPXLBDa4lWjPVe1H7RYFTNhVsRYfLCDaYhhZt9uRCXK3pfagRV1CwN6TUyc=";

static NSString *const notify_url =  @"http://116.231.116.3:8092/ECPartyAMgr/payment/alipayNotice.htmls";

@implementation BXHPayResultUtil

- (instancetype)initWithAliPayResult:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.message = dict[@"memo"];
        self.resultStatus = [dict[@"resultStatus"] integerValue];
        id result = dict[@"result"];
        if ([result isKindOfClass:[NSDictionary class]])
        {
            self.result = result;
        }
        
        switch (self.resultStatus)
         {
            case 9000:
             {
                 self.resultMsg = @"支付成功";
                 self.success = YES;
             }
                break;
             case 8000:
             {
                 self.resultMsg = @"处理中支付结果未知，请稍后刷新查看结果";
                 self.success = NO;
             }
                 break;
             case 4000:
             {
                 self.resultMsg = @"支付失败";
                 self.success = NO;
             }
                 break;
             case 5000:
             {
                 self.resultMsg = @"重复请求";
                 self.success = NO;
             }
                 break;
             case 6001:
             {
                 self.resultMsg = @"取消支付";
                 self.success = NO;
             }
                 break;
             case 6002:
             {
                 self.resultMsg = @"网络连接出错";
                 self.success = NO;
             }
                 break;
             case 6004:
             {
                 self.resultMsg = @"支付结果未知，请稍后刷新查看结果";
                 self.success = NO;
             }
                 break;
  
            default:
             {
                 self.resultMsg = @"其他错误";
                 self.success = NO;
             }
                break;
        }
        
    }
    return self;
}

@end

@interface BXHPayUtil()

@property (nonatomic, copy) CompletionBlock callBack;

@property (nonatomic, strong) Order *order;

@end

@implementation BXHPayUtil

+ (BXHPayUtil *)shareInstance
{
    static dispatch_once_t onceToken;
    static BXHPayUtil *util;
    dispatch_once(&onceToken, ^{
        util = [[BXHPayUtil alloc] init];
    });
    return util;
}

- (instancetype)init
{
    if (self = [super init])
    {
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        self.order = [Order new];
        
        // NOTE: app_id设置
        self.order.app_id = appId;
        
        // NOTE: 支付接口名称
        self.order.method = @"alipay.trade.app.pay";
        
        // NOTE: 参数编码格式
        self.order.charset = @"utf-8";
        
        // NOTE: 当前时间点
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.order.timestamp = [formatter stringFromDate:[NSDate date]];
        
        // NOTE: 支付版本
        self.order.version = @"1.0";
        
        // NOTE: sign_type 根据商户设置的私钥来决定
        self.order.sign_type = @"RSA";
        
        // NOTE: 商品数据
        self.order.biz_content = [BizContent new];
        self.order.biz_content.seller_id = seller_id;
        
        self.order.biz_content.timeout_express = @"30m"; //超时时间设置
        
        self.order.notify_url = notify_url;
    }
    return self;
}

- (void)payCommodityName:(NSString *)name subName:(NSString *)subName tradeNo:(NSString *)tradeNo amount:(CGFloat)amount callBack:(CompletionBlock)callBack
{
//    self.callBack = callBack;
//
//    self.order.biz_content.body = name;
//    self.order.biz_content.subject = subName;
//    self.order.biz_content.out_trade_no = tradeNo; //订单ID（由商家自行制定）
//    self.order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", amount]; //商品价格
//
//    //将商品信息拼接成字符串
//    NSString *orderInfo = [self.order orderInfoEncoded:NO];
//    NSString *orderInfoEncoded = [self.order orderInfoEncoded:YES];
//    BXHLog(@"orderSpec = %@",orderInfo);
//
//    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
//    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    NSString *signedString = nil;
//    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:(rsaPrivateKey)];
//    signedString = [signer signString:orderInfo withRSA2:NO];
//
//    // NOTE: 如果加签成功，则继续执行支付
//    if (signedString != nil)
//    {
//        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
//        NSString *appScheme = @"BoMuCaiAliPay";
//
//        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                 orderInfoEncoded, signedString];
//
//        // NOTE: 调用支付结果开始支付
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:self.callBack];
//    }
}

- (void)payWithSignOrderString:(NSString *)signStr complete:(CompletionBlock)complete
{
    if (![NSString stringIsEmpty:signStr])
    {
        self.callBack = complete;
        NSString *appScheme = @"BoMuCaiAliPay";
        [[AlipaySDK defaultService] payOrder:signStr fromScheme:appScheme callback:self.callBack];
    }
}

- (void)alipayResultUrl:(NSURL *)url
{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:self.callBack];
}

@end
