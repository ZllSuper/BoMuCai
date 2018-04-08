//
//  WaresDetailWebCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MyWebView.h"

@class WaresDetailWebCell;

@protocol WaresDetailWebCellDelegate <NSObject>

- (void)webCell:(WaresDetailWebCell *)cell contentSizeChange:(CGFloat)contentSize;

@end

@interface WaresDetailWebCell : UITableViewCell <WKNavigationDelegate, MyWebViewProtcol>

@property (nonatomic, strong) MyWebView *webView;

@property (nonatomic, weak) id <WaresDetailWebCellDelegate>delegate;

@end
