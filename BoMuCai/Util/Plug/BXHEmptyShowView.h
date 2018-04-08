//
//  BXHEmptyShowView.h
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/11/17.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BXHEmptyShowType)
{
    BXHEmptyTitleType,
    BXHEmptyImageType,
    BXHEmptyBtnType,
    BXHEmptyImageAndTitleType,
    BXHEmptyTitleAndBtnType,
    BXHEmptyImageAndBtnType,
    BXHEmptyTitleImageAndBtnType
};

@class BXHEmptyShowView;

@protocol BXHEmptyShowViewDelegate <NSObject>

- (void)emptyShowViewBtnActionDelegate:(BXHEmptyShowView *)emptyView;

@end


@interface BXHEmptyShowView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *actionBtn;

@property (nonatomic, assign) BXHEmptyShowType showType;

@property (nonatomic, weak) id <BXHEmptyShowViewDelegate>delegate;

+ (BXHEmptyShowView *)creatWithSuperView:(UIView *)superView andShowType:(BXHEmptyShowType)showType;

- (void)showEmpty;

- (void)hiddenEmpty;

@end
