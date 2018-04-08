//
//  ActivityTimeDownView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ActivityTimeDownView.h"

@interface  ActivityTimeDownView()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ActivityTimeDownView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.dayLabel.layer.cornerRadius = 2;
    self.dayLabel.layer.masksToBounds = YES;
    
    self.hourLabel.layer.cornerRadius = 2;
    self.hourLabel.layer.masksToBounds = YES;
    
    self.mintLabel.layer.cornerRadius = 2;
    self.mintLabel.layer.masksToBounds = YES;
    
    self.endTime = NO;
}

- (void)dealloc
{
    if (self.timer)
    {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)startCountDown:(NSTimeInterval)time
{
    if (time == 0)
    {
        self.endTime = YES;
        return;
    }
    __block NSInteger organlTime = time;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        BXHLog(@"timedown =========================================");
        if (organlTime <= 0)
        {
            if (weakSelf != nil)
            {
                dispatch_source_cancel(weakSelf.timer);
                weakSelf.timer = nil;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.endTime = YES;
                [weakSelf setTextDay:0 hour:0 mint:0];
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
//            long seconds = hourSurplus % mintUnit;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTextDay:day hour:hour mint:mint];
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

- (void)setTextDay:(NSInteger)day hour:(NSInteger)hour mint:(NSInteger)mint
{
    self.dayLabel.text = [NSString stringWithFormat:@"%02ld",day];
    self.hourLabel.text = [NSString stringWithFormat:@"%02ld",hour];
    self.mintLabel.text = [NSString stringWithFormat:@"%02ld",mint];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
