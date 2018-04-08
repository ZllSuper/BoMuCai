//
//  ZWAdView.m
//  ADScrollview
//
//  Created by Zhouwu on 14/11/7.
//  Copyright (c) 2014年 com.thomas. All rights reserved.
//

#import "DTAdView.h"
//#import "UIImageView+WebCache.h"

@interface DTAdView ()

@property(nonatomic,strong) NSMutableArray * pageControlConstraints;


@end

@implementation DTAdView

- (instancetype)init
{
    if (self = [super init])
    {
        self.adPeriodTime = 2.0f;
        self.adAutoplay = YES;
        [self setAdScrollView];
        [self setPageControl];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.adScrollView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.adScrollView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)setAdScrollView
{
    self.adScrollView = [[UIScrollView alloc]init];
    self.adScrollView.pagingEnabled = YES;
    self.adScrollView.delegate = self;
    self.adScrollView.scrollsToTop = NO;
    self.adScrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:self.adScrollView];
}

- (void)setPageControl
{
    // UIPageControl
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.enabled = NO;
    self.pageControl.currentPageIndicatorTintColor = Color_Main_Dark;
//    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.1];
    self.pageControl.numberOfPages = self.adDataArray.count;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl(20)]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageControl]-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    self.pageControlConstraints = [NSMutableArray arrayWithArray:pageControlVConstraints];
    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    
    [self addConstraints:self.pageControlConstraints];
}

#pragma mark -加载并播放广告数据内容
-(void)loadAdDataThenStart
{
    if (_adScrollView.subviews.count != 0) {
        for (UIView * subView in _adScrollView.subviews) {
            [subView removeFromSuperview];
        }
    }
    [self.adScrollView setContentSize:CGSizeMake(self.adScrollView.bounds.size.width*(self.adDataArray.count+2), self.adScrollView.bounds.size.height)];
    self.pageControl.numberOfPages = self.adDataArray.count;
    _pageControl.currentPage = 0;
    
    for (int i=0; i<self.adDataArray.count; i++) {
        UIImageView *adImageView= [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*self.adScrollView.bounds.size.width, 0, self.adScrollView.bounds.size.width,self.adScrollView.bounds.size.height)];
        adImageView.tag=i;
        adImageView.userInteractionEnabled=YES;
        adImageView.contentMode = UIViewContentModeScaleAspectFill;
        adImageView.clipsToBounds = YES;
        [adImageView sd_setImageWithURL:[NSURL encodeURLWithString:[[NSString alloc] initWithFormat:@"%@",self.adDataArray[i]]] placeholderImage:ImagePlaceHolder];
        [adImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImgClick)]];
        [self.adScrollView addSubview:adImageView];
    }
    
    UIImageView *lastAdImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height)];
    lastAdImageView.contentMode = UIViewContentModeScaleAspectFill;
    lastAdImageView.clipsToBounds = YES;
    if(self.adDataArray.count > 0)
    {
        [lastAdImageView sd_setImageWithURL:[NSURL encodeURLWithString:[[NSString alloc] initWithFormat:@"%@",self.adDataArray[self.adDataArray.count-1]]] placeholderImage:ImagePlaceHolder];
        [self.adScrollView addSubview:lastAdImageView];
    }
    
    UIImageView *firstAdImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.adDataArray.count+1)*self.adScrollView.bounds.size.width, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height)];
    firstAdImageView.contentMode = UIViewContentModeScaleAspectFill;
    firstAdImageView.clipsToBounds = YES;
    [firstAdImageView sd_setImageWithURL:[NSURL encodeURLWithString:[[NSString alloc] initWithFormat:@"%@",[self.adDataArray firstObject]]] placeholderImage:ImagePlaceHolder];
    [self.adScrollView addSubview:firstAdImageView];
    
    [self.adScrollView setContentOffset:CGPointMake(self.adScrollView.bounds.size.width, 0)];
    if (self.adAutoplay) {
        if (!self.adLoopTimer) {
            self.adLoopTimer = [NSTimer scheduledTimerWithTimeInterval:self.adPeriodTime target:self selector:@selector(loopAd) userInfo:nil repeats:YES];
        }
    }
}

#pragma mark - 循环播放
-(void)loopAd
{
    CGFloat pageWidth = self.adScrollView.frame.size.width;
    int currentPage = self.adScrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages-1;
    }
    else if (currentPage == self.pageControl.numberOfPages+1) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    
    __block NSInteger currPageNumber = self.pageControl.currentPage;
    CGSize viewSize = self.adScrollView.frame.size;
    CGRect rect = CGRectMake((currPageNumber+2)*pageWidth, 0, viewSize.width, viewSize.height);
    
    [UIView animateWithDuration:0.7 animations:^{
        [self.adScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
        currPageNumber++;
        if (currPageNumber == self.pageControl.numberOfPages) {
            [self.adScrollView setContentOffset:CGPointMake(self.adScrollView.bounds.size.width, 0)];
            currPageNumber = 0;
        }
    }];
    
    currentPage = self.adScrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages-1;
    }
    else if (currentPage == self.pageControl.numberOfPages+1) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
}
#pragma mark---- UIScrollView delegate methods

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
        NSInteger currentAdPage;
        currentAdPage=self.adScrollView.contentOffset.x/self.adScrollView.bounds.size.width;
        if (currentAdPage==0) {
            [scrollView scrollRectToVisible:CGRectMake(self.adScrollView.bounds.size.width*self.pageControl.numberOfPages, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height) animated:NO];
            currentAdPage=self.pageControl.numberOfPages-1;
        }
        else if (currentAdPage==(self.pageControl.numberOfPages+1)) {
            [scrollView scrollRectToVisible:CGRectMake(self.adScrollView.bounds.size.width, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height) animated:NO];
            currentAdPage=0;
        }
        else{
            currentAdPage=currentAdPage-1;
        }
        self.pageControl.currentPage=currentAdPage;
    
    if (self.adAutoplay) {
        if (!self.adLoopTimer) {
            self.adLoopTimer = [NSTimer scheduledTimerWithTimeInterval:self.adPeriodTime target:self selector:@selector(loopAd) userInfo:nil repeats:YES];
        }
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始拖动scrollview的时候 停止计时器控制的跳转
    if (self.adAutoplay) {
        if (self.adLoopTimer) {
            [self.adLoopTimer invalidate];
            self.adLoopTimer = nil;
        }
    }
}

- (void)setPageControlPosition:(DTPageControlPosition)pageControlPosition
{
    NSString *vFormat = nil;
    NSString *hFormat = nil;
    
    switch (pageControlPosition) {
        case DTPageControlPosition_TopLeft: {
            vFormat = @"V:|-0-[pageControl(20)]";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case DTPageControlPosition_TopCenter: {
            vFormat = @"V:|-0-[pageControl(20)]";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case DTPageControlPosition_TopRight: {
            vFormat = @"V:|-0-[pageControl(20)]";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        case DTPageControlPosition_BottomLeft: {
            vFormat = @"V:[pageControl(20)]-0-|";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case DTPageControlPosition_BottomCenter: {
            vFormat = @"V:[pageControl(20)]-0-|";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case DTPageControlPosition_BottomRight: {
            vFormat = @"V:[pageControl(20)]-0-|";
            hFormat = @"H:[pageControl]-|";
            break;
        }
    }
    
    [self removeConstraints:self.pageControlConstraints];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    [self.pageControlConstraints removeAllObjects];
    [self.pageControlConstraints addObjectsFromArray:pageControlVConstraints];
    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    
    [self addConstraints:self.pageControlConstraints];
    
}


- (void)setHidePageControl:(BOOL)hidePageControl
{
    self.pageControl.hidden = hidePageControl;
}

#pragma mark - 点击
-(void)adImgClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(adView:didSelectAdAtNum:)]) {
        [self.delegate adView:self didSelectAdAtNum:self.pageControl.currentPage];
    }
}
@end
