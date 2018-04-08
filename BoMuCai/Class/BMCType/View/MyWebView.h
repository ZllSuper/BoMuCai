//
//  MyWebView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/6/2.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <WebKit/WebKit.h>

@class MyWebView;
@protocol MyWebViewProtcol <NSObject>

- (void)webViewDidLayout:(MyWebView *)webView height:(CGFloat)height;

@end

@interface MyWebView : WKWebView

@property (nonatomic, assign) CGFloat preHeight;

@property (nonatomic, weak) id <MyWebViewProtcol>protcol;

@end
