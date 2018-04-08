//
//  BXHWebViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BXHWebViewType)
{
    BXHWebWangZhanJieShao,
    BXHWebGongShiJieShao,
    BXHWebFaLvShengMing,
    BXHWebTenderHallDetail,
    BXHWebViewNone
};

@interface BXHWebViewController : UIViewController

@property (nonatomic, copy) NSString *requestId;

- (instancetype)initWithHtml:(NSString *)html;

- (instancetype)initWithUrl:(NSURL *)url;

- (instancetype)initWithWebViewType:(BXHWebViewType)type;

@end
