//
//  PCOrderDetailBtnBottomView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCOrderDetailBtnBottomView;

@protocol PCOrderDetailBtnBottomViewDelegate <NSObject>

- (void)bottomView:(PCOrderDetailBtnBottomView *)bottomView btnActionAtIndex:(NSInteger)index;

@end

@interface PCOrderDetailBtnBottomView : UIView

@property (nonatomic, weak) id <PCOrderDetailBtnBottomViewDelegate>delegate;

- (instancetype) initWithTitles:(NSArray *)titles;

- (void)reloadWithTitles:(NSArray *)titles;

@end
