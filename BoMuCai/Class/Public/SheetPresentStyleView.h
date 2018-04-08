//
//  SheetPresentStyleView.h
//  Wookong
//
//  Created by WilliamChen on 17/3/28.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 类似 ActionSheet 从底部弹出的 View
 */
@interface SheetPresentStyleView : UIView

/**
 Present 弹出 ContentView
 */
@property (nonatomic, strong, nonnull) UIView *contentView;

/**
 为了适配 iPhone X 这种异形屏幕添加的属性，在本 App 里主要使用 .bottom 的值，防止视图底部被遮盖。当然
 此属性在 iOS 11 以下没有意义，值为 UIEdgeInsetZero
 */
@property (nonatomic, assign, readonly) UIEdgeInsets safeAreaInsetsEdge;

/**
 是否允许点击非 Content 区域消失
 */
@property (nonatomic, assign) BOOL enableOutsideTapDismiss;

/**
 显示在窗口上
 */
- (void)show;

/**
 动画消失

 @param completion 动画消失后的 Block
 */
- (void)dismissWithCompletionBlock:(nullable void(^)(BOOL finished))completion;
@end
