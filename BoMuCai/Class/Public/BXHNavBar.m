//
//  BXHNavBar.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHNavBar.h"

#define ALphaFloat 120

@interface BXHNavBar()

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, assign) CGPoint topOffset;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation BXHNavBar

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview)
    {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (instancetype) initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init])
    {
        self.scrollView = scrollView;
        
        self.topOffset = CGPointZero;
    
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
        self.shadeColor = Color_White;
        
        [self addSubview:self.backView];
        [self addSubview:self.lineView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(self);
            make.height.mas_equalTo(0.7);
        }];
    }
    return self;
}

- (void)backAlphaChange:(CGFloat)alpha up:(BOOL)up
{
    
}

#pragma mark - scrollViewDelegate

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGPoint newOffset = [change[@"new"] CGPointValue];
    if (newOffset.y >= (self.scrollView.contentSize.height - self.scrollView.height) && self.scrollView.contentSize.height > self.scrollView.height)
    {
        newOffset.y = (self.scrollView.contentSize.height - self.scrollView.height);
        self.lineView.alpha = self.backView.alpha = 1;
        [self backAlphaChange:self.backView.alpha up:YES];
    }
    else if (newOffset.y <= 0)
    {
        newOffset.y = 0;
        self.lineView.alpha = self.backView.alpha = 0;
        [self backAlphaChange:self.backView.alpha up:NO];
    }
    else
    {
        BOOL up = newOffset.y > self.topOffset.y;
        CGFloat offset = newOffset.y - self.topOffset.y;
        CGFloat alpha = self.backView.alpha;
        if (up && alpha < 1)
        {
            CGFloat alphaOffset = offset / ALphaFloat;
            alpha += alphaOffset;
            
            if (alpha > 1)
            {
                alpha = 1;
            }
            self.lineView.alpha = self.backView.alpha = alpha;
            [self backAlphaChange:self.backView.alpha up:up];
        }
        else if (!up && alpha > 0)
        {
            offset = -offset;
            CGFloat alphaOffset = offset / ALphaFloat;
            alpha -= alphaOffset;
            if (alpha < 0)
            {
                alpha = 0;
            }
            self.lineView.alpha = self.backView.alpha = alpha;
            [self backAlphaChange:self.backView.alpha up:up];
        }
    }
    
    
    self.topOffset = newOffset;
}



#pragma mark - set / get
- (void)setShadeColor:(UIColor *)shadeColor
{
    _shadeColor = shadeColor;
    self.backView.backgroundColor = _shadeColor;
}

- (UIView *)backView
{
    if (!_backView)
    {
        _backView = [[UIView alloc] init];
        _backView.alpha = 0;
    }
    return _backView;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = Color_Gray_Line;
    }
    return _lineView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
