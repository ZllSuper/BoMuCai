//
//  PCCollectSegmentView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/10.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCCollectSegmentView;
@protocol PCCollectSegmentViewDelegate <NSObject>

- (void)segmentViewBtnAction:(PCCollectSegmentView *)segmentView;

@end

@interface PCCollectSegmentView : UIView

@property (nonatomic, strong) UIButton *goodsBtn;

@property (nonatomic, strong) UIButton *shopBtn;

@property (nonatomic, strong) UIView *selLineView;

@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, weak) id <PCCollectSegmentViewDelegate>delegate;

@end
