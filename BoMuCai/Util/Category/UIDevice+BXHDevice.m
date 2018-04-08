//
//  UIDevice+BXHDevice.m
//  ECar
//
//  Created by 步晓虎 on 15-1-17.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import "UIDevice+BXHDevice.h"
#import "NSString+BXHMyString.h"
#import <sys/utsname.h>

@implementation UIDevice (BXHDevice)

+ (BOOL)belowPhoneType:(NSString *)phoneType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([[deviceString substringToIndex:3] isEqualToString:@"iPh"])
    {
        if ([[deviceString substringWithRange:NSMakeRange(6, 1)] integerValue] > [phoneType integerValue])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}


+ (NSString *)getDeviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *jsonStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DeviceModelName" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *modelDict = [jsonStr jsonObject];
    return modelDict[deviceString] == nil ? @"" : modelDict[deviceString];
}

+ (NSString *)getDeviceResolution
{
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    return [NSString stringWithFormat:@"%.2lfx%.2lf",rect_screen.size.width * scale_screen,rect_screen.size.height * scale_screen];
}

@end
