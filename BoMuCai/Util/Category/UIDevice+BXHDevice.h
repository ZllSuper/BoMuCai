//
//  UIDevice+BXHDevice.h
//  ECar
//
//  Created by 步晓虎 on 15-1-17.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (BXHDevice)

+ (NSString *)getDeviceModelName;

+ (NSString *)getDeviceResolution;

+ (BOOL)belowPhoneType:(NSString *)phoneType;

@end
