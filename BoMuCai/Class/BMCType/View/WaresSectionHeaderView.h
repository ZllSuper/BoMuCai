//
//  WaresSectionHeaderView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SectionActionType)
{
    SectionDetailActionType,
    SectionCommentActionType
};

@class WaresSectionHeaderView;

@protocol WaresSectionHeaderViewDelegate <NSObject>

- (void)sectionView:(WaresSectionHeaderView *)sectionView actionType:(SectionActionType)actionType;

@end

@interface WaresSectionHeaderView : UIView

@property (nonatomic, strong) UIButton *detailBtn;

@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, weak) id <WaresSectionHeaderViewDelegate>delegate;

+ (CGFloat)showHeight;

@end
