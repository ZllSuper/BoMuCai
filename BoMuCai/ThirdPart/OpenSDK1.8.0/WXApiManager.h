//
//  WXApiManager.h
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol WXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

- (void)managerDidRecvChooseCardResponse:(WXChooseCardResp *)response;

- (void)managerDidRecvChooseInvoiceResponse:(WXChooseInvoiceResp *)response;
@end

@interface WXApiManager : NSObject<WXApiDelegate>

@property (nonatomic, weak) id<WXApiManagerDelegate> delegate;

+ (instancetype)sharedManager;

- (void)sendAuthScope:(NSString *)scope state:(NSString *)state openId:(NSString *)openId fromViewContoller:(UIViewController *)vc;

- (void)sendMessage:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage webUrl:(NSString *)webUrl type:(int)type;

- (BOOL)handleOpenUrl:(NSURL *)url;

@end
