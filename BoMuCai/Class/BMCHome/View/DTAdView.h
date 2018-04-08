//
//  ZWAdView.h
//  ADScrollview
//
//  Created by Zhouwu on 14/11/7.
//  Copyright (c) 2014年 com.thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DTPageControlPosition) {
    DTPageControlPosition_TopLeft,
    DTPageControlPosition_TopCenter,
    DTPageControlPosition_TopRight,
    DTPageControlPosition_BottomLeft,
    DTPageControlPosition_BottomCenter,
    DTPageControlPosition_BottomRight
};

@protocol DTAdViewDelagate;

@interface DTAdView : UIView <UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView   * adScrollView;

@property(nonatomic,strong) UIPageControl  * pageControl;

@property(nonatomic,retain) NSTimer        * adLoopTimer;

@property(nonatomic,  copy) NSArray        * adDataArray;     // 广告图片数组

@property(nonatomic,assign) CGFloat          adPeriodTime;    // 切换广告时间,默认2秒

@property(nonatomic,assign) BOOL             adAutoplay;      // 是否自动播放广告,默认yes

@property(nonatomic,assign) BOOL             hidePageControl; // hide pageControl, default is NO

@property(nonatomic,assign) DTPageControlPosition pageControlPosition;

@property(nonatomic,  weak) id<DTAdViewDelagate>delegate;

- (void)loadAdDataThenStart;  //加载广告图片并开始播放

@end

@protocol DTAdViewDelagate <NSObject>

@optional;
- (void)adView:(DTAdView *)adView didSelectAdAtNum:(NSInteger)num;

@end
