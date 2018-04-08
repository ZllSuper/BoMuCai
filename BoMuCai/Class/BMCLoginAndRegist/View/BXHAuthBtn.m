//
//  BXHAuthBtn.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/2/26.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "BXHAuthBtn.h"

@interface BXHAuthBtn ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation BXHAuthBtn

- (void)dealloc
{
    if (self.timer)
    {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)startVerify:(NSInteger)time
{
    __block NSInteger organlTime = time;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        if (organlTime <= 0)
        {
            if (weakSelf != nil)
            {
                dispatch_source_cancel(weakSelf.timer);
                weakSelf.timer = nil;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:@"获取验证码" forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = YES;
            });
        }
        else
        {
            NSInteger seconds = organlTime;
            seconds = (seconds == 0 ? organlTime : seconds);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:[NSString stringWithFormat:@"%lds",(long)seconds] forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = NO;
            });
            organlTime--;
        }
    });
    dispatch_resume(self.timer);
}

- (void)startCountDown:(NSTimeInterval)time withNormalText:(NSString *)normalText
{
    __block NSInteger organlTime = time;
    __block NSString *showText = normalText;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"timedown =========================================");
        if (organlTime <= 0)
        {
            if (weakSelf != nil)
            {
                dispatch_source_cancel(weakSelf.timer);
                weakSelf.timer = nil;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:showText forState:UIControlStateNormal];
                weakSelf.enabled = NO;
                [weakSelf setBackgroundColor:[UIColor grayColor]];
            });
        }
        else
        {
            long dayUnit = 60 * 60 * 24;
            long hourUnit = 60 * 60;
            long mintUnit = 60;
            
            long day = organlTime / dayUnit;
            long daySurplus = organlTime % dayUnit;
            long hour = daySurplus / hourUnit;
            long hourSurplus = daySurplus % hourUnit;
            long mint = hourSurplus / mintUnit;
            long seconds = hourSurplus % mintUnit;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableAttributedString *attribute;
                NSString *str;
                if (day >= 1)
                {
                    str = [NSString stringWithFormat:@"活动报名(距报名截止:%ld天)",day];
                    
                }
                else
                {
                    str = [NSString stringWithFormat:@"活动报名(距报名截止:%ld时%ld分%ld秒)",hour,mint,seconds];
                }
                attribute = [[NSMutableAttributedString alloc] initWithString:str];
                [attribute addAttribute:NSForegroundColorAttributeName value:Color_White range:NSMakeRange(0, str.length)];
                [attribute addAttribute:NSFontAttributeName value:Font_sys_16 range:NSMakeRange(0, 4)];
                [attribute addAttribute:NSFontAttributeName value:Font_sys_10 range:NSMakeRange(4, str.length-4)];
                [weakSelf setAttributedTitle:attribute forState:UIControlStateNormal];
//                [self setTitle:[NSString stringWithFormat:@"%ld天%ld时%ld分%ld秒",day,hour,mint,seconds] forState:UIControlStateNormal];
//                [self setBackgroundColor:[UIColor grayColor]];
            });
            organlTime--;
        }
    });
    dispatch_resume(self.timer);
}

- (void)stopCountDown
{
    if (self.timer)
    {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
