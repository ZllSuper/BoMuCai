//
//  BXHClockView.m
//  TryLayout
//
//  Created by 步晓虎 on 2017/2/10.
//  Copyright © 2017年 金人网络. All rights reserved.
//

#import "BXHClockView.h"

#define CenterPointWidth 2
#define DialPlateWidth 2
#define MintLineWidth 2
#define SecondLineWidth 1

#define PointPercent 0.5
#define DaielPercent 0.2
#define MarkPercent 0.2
#define MintPercent 0.05
#define SecondsPercent 0.05

@interface BXHClockView ()

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) BOOL animate;

@property (nonatomic, assign) NSInteger mint;

@property (nonatomic, assign) NSInteger seconds;

@end

@implementation BXHClockView

- (void)dealloc
{
    if (self.timer)
    {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = Color_Clear;
        _progress = 0;
        _mint = 0;
        _seconds = 0;
    }
    return self;
}

- (void)startAnimate
{
    self.animate = YES;
    
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(nil, 0), NSEC_PER_SEC / 10, 0);
    dispatch_source_set_event_handler(self.timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.seconds ++;
            });
  
    });
    dispatch_resume(self.timer);
}

- (void)endAnimate
{
    if (self.timer)
    {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    self.seconds = 0;
    self.mint = 0;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setSeconds:(NSInteger)seconds
{
    _seconds = seconds;
    if (seconds == 60)
    {
        _mint++;
        _seconds = 0;
    }
    [self setNeedsDisplay];

}

- (void)setMint:(NSInteger)mint
{
    _mint = mint;
    if (mint == 60)
    {
        mint = 0;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
 
        CGContextRef context = UIGraphicsGetCurrentContext();
        [Color_Clear set];
        CGContextFillRect(context, rect);
        
        [self drawCirclePoint:context rect:rect];
        [self drawDialPlate:context rect:rect];
        [self drawMarkLineContext:context rect:rect];

        [self drawMintHand:self.mint context:context rect:rect];
        [self drawSecondHand:self.seconds context:context rect:rect];
}

//0 ~ 0.2
- (void)drawCirclePoint:(CGContextRef)context rect:(CGRect)rect
{
    CGFloat endAngle = self.progress / PointPercent;
    if (endAngle > 1)
    {
        endAngle = 1;
    }
    CGContextSetStrokeColorWithColor(context, Color_Main_Dark.CGColor);
    CGContextSetLineWidth(context, CenterPointWidth);
    CGContextAddArc(context, CGRectGetMidX(rect), CGRectGetMidY(rect), CenterPointWidth / 2, 0, endAngle * 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)drawDialPlate:(CGContextRef)context rect:(CGRect)rect
{
    CGFloat endAngle = self.progress - PointPercent;
    if (endAngle <= 0)
    {
        return;
    }
    endAngle = endAngle / DaielPercent;
    if (endAngle > 1)
    {
        endAngle = 1;
    }

    CGContextSetStrokeColorWithColor(context, Color_Main_Dark.CGColor);
    CGContextSetLineWidth(context, DialPlateWidth);
    CGContextAddArc(context, CGRectGetMidX(rect), CGRectGetMidY(rect), rect.size.width / 2 - DialPlateWidth / 2, 0, endAngle * 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);

}

- (void)drawMintHand:(CGFloat)min context:(CGContextRef)context rect:(CGRect)rect
{
    CGFloat endAngle = self.progress - PointPercent - DaielPercent - MarkPercent;
    if (endAngle <= 0)
    {
        return;
    }
    endAngle = endAngle / MintPercent;
    if (endAngle > 1)
    {
        endAngle = 1;
    }

    
    if (min < 15)
    {
        min = 45 + min;
    }
    else
    {
        min -= 15;
    }

    CGFloat angle = (min / 60.0) * M_PI * 2;
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat radius = rect.size.width / 2;
    CGFloat length = radius * 0.5 * endAngle;
    CGPoint endPoint =  [self endPointWithRadius:length startPoint:startPoint angle:angle];
    CGContextSetLineWidth(context, MintLineWidth);

    CGContextSetStrokeColorWithColor(context, Color_Main_Dark.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
}

- (void)drawSecondHand:(CGFloat)second context:(CGContextRef)context rect:(CGRect)rect
{
    CGFloat endAngle = self.progress - PointPercent - DaielPercent - MarkPercent - MintPercent;
    if (endAngle <= 0)
    {
        return;
    }
    endAngle = endAngle / SecondsPercent;
    if (endAngle > 1)
    {
        endAngle = 1;
    }

    
    if (second < 15)
    {
        second = 45 + second;
    }
    else
    {
        second -= 15;
    }
    
    CGFloat angle = (second / 60.0) * M_PI * 2;
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat radius = rect.size.width / 2;
    CGFloat length = radius * 0.7 * endAngle;
    CGPoint endPoint =  [self endPointWithRadius:length startPoint:startPoint angle:angle];
    CGContextSetLineWidth(context, SecondLineWidth);

    CGContextSetStrokeColorWithColor(context, Color_Main_Dark.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
}

- (void)drawMarkLineContext:(CGContextRef)context rect:(CGRect)rect
{
    CGFloat endAngle = self.progress - PointPercent - DaielPercent;
    if (endAngle <= 0)
    {
        return;
    }
    endAngle = endAngle / MarkPercent;
    if (endAngle > 1)
    {
        endAngle = 1;
    }
    
    for (NSInteger i = 0; i < 60 * endAngle; i ++ )
    {
        CGFloat angle = (i / 60.0) * M_PI * 2;
        CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
        CGFloat radius = rect.size.width / 2 - 3;
        CGFloat length = (i % 5 == 0) ? radius * 0.9 : radius * 0.95;
        CGPoint endPoint1 =  [self endPointWithRadius:length startPoint:startPoint angle:angle];
        CGPoint endPoint2 =  [self endPointWithRadius:radius startPoint:startPoint angle:angle];
        
        CGContextSetLineWidth(context, SecondLineWidth);
        
        CGContextSetStrokeColorWithColor(context, Color_Main_Dark.CGColor);
        CGContextMoveToPoint(context, endPoint1.x, endPoint1.y);
        CGContextAddLineToPoint(context, endPoint2.x, endPoint2.y);
        CGContextStrokePath(context);
    }
}


- (CGPoint)endPointWithRadius:(CGFloat)radius  startPoint:(CGPoint)startPoint angle:(CGFloat)angle
{
    int index = angle / M_PI_2; //用户区分在第几象限内
    index = index % 3;
    float x = 0,y = 0;//用于保存_dotView的frame
    x = startPoint.x + cos(angle)*radius;
    y = startPoint.y + sin(angle)*radius;

    return CGPointMake(x, y);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
    // Drawing code
}
*/

@end
