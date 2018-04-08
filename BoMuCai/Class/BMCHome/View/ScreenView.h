//
//  ScreenView.h
//  ECar
//
//  Created by 步晓虎 on 14-12-17.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ScreenViewItemType)
{
    ScreenViewItemNormal,
    ScreenViewItemSort,
    ScreenViewItemTouch
};

typedef NS_ENUM(NSInteger, ScreenViewItemStatue)
{
    ScreenViewItemStatueNormal,
    ScreenViewItemStatueSelect,
    ScreenViewItemStatueSelectAsc,
    ScreenViewItemStatueSelectDsc
};

@interface ScreenViewItem : UIControl

@property (nonatomic, assign) ScreenViewItemStatue itemState;

@property (nonatomic, assign) ScreenViewItemType type;

- (instancetype)initWithTitle:(NSString *)title;

- (void)setImage:(UIImage *)image withState:(ScreenViewItemStatue)statue;

@end


@class ScreenView;

@protocol ScreenViewDelegate <NSObject>

- (void)screenView:(ScreenView *)screenView screenItemAction:(ScreenViewItem *)item index:(NSInteger)index;

@end

@interface ScreenView : UIView

@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, weak) id <ScreenViewDelegate>delegate;

- (instancetype)initWithScreenItems:(NSArray <ScreenViewItem *> *)items;

- (void)setScreenItemTitle:(NSString *)title atIndex:(NSInteger)index;//0.....

- (void)selectItemAtIndex:(NSInteger)index;

@end
