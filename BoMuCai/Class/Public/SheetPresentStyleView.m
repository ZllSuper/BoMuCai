//
//  SheetPresentStyleView.m
//  Wookong
//
//  Created by WilliamChen on 17/3/28.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "SheetPresentStyleView.h"

const NSUInteger kSheetPresentStyleViewTag = 478210;

@interface SheetPresentStyleView ()
@property (nonatomic, strong) UIButton *tapToDimsissButton;
@end
@implementation SheetPresentStyleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.enableOutsideTapDismiss = YES;
        if (@available(iOS 11, *)) {
            _safeAreaInsetsEdge = [[UIApplication sharedApplication] delegate].window.safeAreaInsets;
        }

        self.tag = kSheetPresentStyleViewTag;
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        CGSize size = self.frame.size;
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, size.height, size.width, 300.0)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)show
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (![window viewWithTag:kSheetPresentStyleViewTag]) {
        [window addSubview:self];
        
        CGRect frame = self.contentView.frame;
        frame.origin.y -= frame.size.height;
        [UIView animateWithDuration:0.25 animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
            self.contentView.frame = frame;
        }];
    }
}

- (void)dismissWithCompletionBlock:(void (^)(BOOL))completion
{
    CGRect frame = self.contentView.frame;
    frame.origin.y = CGRectGetHeight(self.frame);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.frame = frame;
        self.backgroundColor = [UIColor clearColor];
    } completion:completion];
}

- (void)setEnableOutsideTapDismiss:(BOOL)enableOutsideTapDismiss
{
    _enableOutsideTapDismiss = enableOutsideTapDismiss;
    
    if (enableOutsideTapDismiss) {
        if (!_tapToDimsissButton) {
            _tapToDimsissButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _tapToDimsissButton.backgroundColor = [UIColor clearColor];
            [self addSubview:_tapToDimsissButton];
        }
        [_tapToDimsissButton addTarget:self action:@selector(tapToDismissButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        if ([_tapToDimsissButton.allTargets containsObject:self]) {
            [_tapToDimsissButton removeTarget:self action:@selector(tapToDismissButtonAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)tapToDismissButtonAction
{
    [self dismissWithCompletionBlock:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_tapToDimsissButton) {
        _tapToDimsissButton.frame = self.bounds;
    }
}

@end
