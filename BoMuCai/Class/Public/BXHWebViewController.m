//
//  BXHWebViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHWebViewController.h"
#import "BXHWebProgress.h"
#import <WebKit/WebKit.h>
#import "PCAboutUsDetailRequest.h"
#import "TenderHallDetailRequest.h"


@interface BXHWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) BXHWebProgress *progressView;

@property (nonatomic, assign) BXHWebViewType type;

@property (nonatomic, copy) NSString *html;

@property (nonatomic, strong) NSURL *url;

@end

@implementation BXHWebViewController

- (void)dealloc
{
    [self.progressView closeTimer];
    [self.progressView removeFromSuperlayer];
    self.progressView = nil;
}

- (instancetype)initWithHtml:(NSString *)html
{
    if (self = [super init])
    {
        self.html = html;
        self.type = BXHWebViewNone;
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url
{
    if (self = [super init])
    {
        self.url = url;
        self.type = BXHWebViewNone;
    }
    return self;
}

- (instancetype)initWithWebViewType:(BXHWebViewType)type
{
    if (self = [super init])
    {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    if (self.type == BXHWebWangZhanJieShao)
    {
        [self aboutUsRequest:Type_WangZhanJieShao];
    }
    else if (self.type == BXHWebGongShiJieShao)
    {
        [self aboutUsRequest:Type_GongShiJieShao];
    }
    else if (self.type == BXHWebFaLvShengMing)
    {
        [self aboutUsRequest:Type_FaLvShenMing];
    }
    else if (self.type == BXHWebTenderHallDetail)
    {
        [self tenderHallDetailRequest];
    }
    else
    {
        if (self.url)
        {
            [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
        }
        else
        {
            NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=\"viewport\""
                              " content=\"width=device-width, initial-scale=1.0\">"
                              "<style type=\"text/css\">body { font-family: Arial,\"microsoft yahei\","
                              "Verdana; word-wrap:break-word; padding:0; margin:0; font-size:14px; "
                              "color:#000; background: #fff; "
                              "overflow-x:hidden; }img {padding:0; margin:0; vertical-align:top; border: "
                              "none}li,ul {list-style: none outside none; padding: 0; margin: "
                              "0}input[type=text],select {-webkit-appearance:none; -moz-appearance: none; "
                              "margin:0; padding:0; background:none; border:none; font-size:14px; "
                              "text-indent:3px; font-family: Arial,\"microsoft yahei\",Verdana;}.wrapper { "
                              "width:100%%; padding-right:10px;padding-top:10px;padding-bottom:10px;"
                              "padding-left:10px; box-sizing:border-box;}p { color:#666; line-height:1.0em;}"
                              ".wrapper img { display:block; max-width:100%%; height:auto !important; "
                              "margin-bottom:10px;} p {margin:0; margin-bottom:1px;}</style></head><body><div "
                              "class=\"wrapper\">"
                              "%@"
                              "</div></body></html>", self.html];
            
            [self.webView loadHTMLString:html baseURL:NULL];
        }
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
- (void)aboutUsRequest:(NSString *)type
{
    __weak typeof(self) weakSelf = self;
    PCAboutUsDetailRequest *item = [[PCAboutUsDetailRequest alloc] init];
    item.type = type;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=\"viewport\""
                              " content=\"width=device-width, initial-scale=1.0\">"
                              "<style type=\"text/css\">body { font-family: Arial,\"microsoft yahei\","
                              "Verdana; word-wrap:break-word; padding:0; margin:0; font-size:14px; "
                              "color:#000; background: #fff; "
                              "overflow-x:hidden; }img {padding:0; margin:0; vertical-align:top; border: "
                              "none}li,ul {list-style: none outside none; padding: 0; margin: "
                              "0}input[type=text],select {-webkit-appearance:none; -moz-appearance: none; "
                              "margin:0; padding:0; background:none; border:none; font-size:14px; "
                              "text-indent:3px; font-family: Arial,\"microsoft yahei\",Verdana;}.wrapper { "
                              "width:100%%; padding-right:10px;padding-top:10px;padding-bottom:10px;"
                              "padding-left:10px; box-sizing:border-box;}p { color:#666; line-height:1.0em;}"
                              ".wrapper img { display:block; max-width:100%%; height:auto !important; "
                              "margin-bottom:10px;} p {margin:0; margin-bottom:1px;}</style></head><body><div "
                              "class=\"wrapper\">"
                              "%@"
                              "</div></body></html>", request.response.data[@"content"]];
            
            [weakSelf.webView loadHTMLString:html baseURL:NULL];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        ToastShowBottom(NetWorkErrorTip);
    }];
    
}

- (void)tenderHallDetailRequest
{
    __weak typeof(self) weakSelf = self;
    TenderHallDetailRequest *item = [[TenderHallDetailRequest alloc] init];
    item.tenderHallId = self.requestId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=\"viewport\""
                              " content=\"width=device-width, initial-scale=1.0\">"
                              "<style type=\"text/css\">body { font-family: Arial,\"microsoft yahei\","
                              "Verdana; word-wrap:break-word; padding:0; margin:0; font-size:14px; "
                              "color:#000; background: #fff; "
                              "overflow-x:hidden; }img {padding:0; margin:0; vertical-align:top; border: "
                              "none}li,ul {list-style: none outside none; padding: 0; margin: "
                              "0}input[type=text],select {-webkit-appearance:none; -moz-appearance: none; "
                              "margin:0; padding:0; background:none; border:none; font-size:14px; "
                              "text-indent:3px; font-family: Arial,\"microsoft yahei\",Verdana;}.wrapper { "
                              "width:100%%; padding-right:10px;padding-top:10px;padding-bottom:10px;"
                              "padding-left:10px; box-sizing:border-box;}p { color:#666; line-height:1.0em;}"
                              ".wrapper img { display:block; max-width:100%%; height:auto !important; "
                              "margin-bottom:10px;} p {margin:0; margin-bottom:1px;}</style></head><body><div "
                              "class=\"wrapper\">"
                              "%@"
                              "</div></body></html>", request.response.data];
            
            [weakSelf.webView loadHTMLString:html baseURL:NULL];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        ToastShowBottom(NetWorkErrorTip);
    }];
}

#pragma mark - webViewDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self.progressView startLoad];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.progressView finishedLoad];

//    self.progressView.hidden = YES;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self.progressView finishedLoad];
}

#pragma mark - get
- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (BXHWebProgress *)progressView
{
    if (!_progressView)
    {
        _progressView = [[BXHWebProgress alloc] init];
        _progressView.frame = CGRectMake(0, 42, DEF_SCREENWIDTH, 2);
        [self.navigationController.navigationBar.layer addSublayer:_progressView];
    }
    return _progressView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
