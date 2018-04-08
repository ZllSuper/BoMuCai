//
//  WaresDetailWebCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresDetailWebCell.h"

@interface WaresDetailWebCell()


@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WaresDetailWebCell

- (void)dealloc
{
//    [self.webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        [self.scrollView addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.mas_equalTo(self.scrollView);
            make.size.mas_equalTo(self.scrollView);
        }];
//        [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
//        if ([[UIDevice currentDevice].systemVersion floatValue] > 9.0)
//        {
//            NSSet *types = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,WKWebsiteDataTypeMemoryCache]];
//            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:types modifiedSince:[NSDate date] completionHandler:^{
//                NSLog(@"clear");
//            }];
//        }
//        else
//        {
//            NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
//            NSString *cookiesFolderPath = [libPath stringByAppendingString:@"/Cookies"];
//            [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:nil];
//        }
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    [self.webView evaluateJavaScript:@"document.body.offsetHeight;"completionHandler:^(id _Nullable result,NSError *_Nullable error) {
//        NSLog(@"document height %@", result);
//    }];
//    NSLog(@"newSize = %@",change[@"new"]);
    CGSize size = [self.webView.scrollView contentSize];
//    NSLog(@"ScrollViewSize = %@",NSStringFromCGSize(size));
    if(self.delegate)
    {
        [self.delegate webCell:self contentSizeChange:size.height];
    }

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)webViewDidLayout:(MyWebView *)webView height:(CGFloat)height
{
    if(self.delegate)
    {
        [self.delegate webCell:self contentSizeChange:height];
    }

}

//-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//{
//    //如果是跳转一个新页面
//    if (self.loaded)
//    {
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }
//    else
//    {
//        self.loaded = YES;
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
}

#pragma mark - get
- (WKWebView *)webView
{
    if (!_webView)
    {
    
//         NSString *jScript = [NSString stringWithFormat:@"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=%lf'); document.getElementsByTagName('head')[0].appendChild(meta);",[UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale];
        
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        
        _webView = [[MyWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
        _webView.protcol = self;
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
        _webView.userInteractionEnabled = NO;
    }
    return _webView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

@end
