//
//  BXHMyAlertView.m
//  ECar
//
//  Created by 步晓虎 on 15-1-8.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import "BXHMyAlertView.h"

@implementation BXHMyAlertView

- (instancetype) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil])
    {
        
    }
    return self;
}

- (void)showWithActionHander:(AlertViewActionHander)hander
{
    self.actionHander = hander;
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.actionHander(self,buttonIndex);
}

@end
