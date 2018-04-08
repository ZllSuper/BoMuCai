//
//  FMPColorMap.h
//  Category
//
//  Created by Evan.Cheng on 15/12/26.
//  Copyright (c) 2015年 Cheng. All rights reserved.//

#ifndef ColorMap_h
#define ColorMap_h

#pragma mark - 颜色 -
/**
 *  从16进制数生成UIColor
 *
 *  @param rgbValue   16进制值
 *
 *  @return
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]


// 主色调
#define Color_Main_Dark        UIColorFromRGB(0xE16337)

#define Color_Main_Light      UIColorFromRGB(0xf39700)
// 橘色
#define Color_Orange          UIColorFromRGB(0xDE5849)

// 无色
#define Color_Clear           [UIColor clearColor]

// 白色
#define Color_White           [UIColor whiteColor]


// 线的颜色
#define Color_Gray_Line       [[UIColor lightGrayColor] colorWithAlphaComponent:0.3]

// 背景色
#define Color_Gray_bg         UIColorFromRGB(0xF6F6F6)  

#define Color_Line_Border     UIColorFromRGB(0xF5F5F5)

#define Color_Gray_ImageBg    [UIColorFromRGB(0xF5F5F5)  colorWithAlphaComponent:0.8]

#define Color_NavigationBar   Color_Main_Dark//UIColorFromRGB(0x1F89D4)

#define Color_TextFiledBack   UIColorFromRGB(0xEBEBEB)

//分割线的颜色
#define Color_Line_Separator  UIColorFromRGB(0x707070)


//============text
//bar文字
#define Color_BarText         [UIColor darkTextColor]
//主体文字色
#define Color_MainText        UIColorFromRGB(0x303030)

#define Color_Text_Gray       [UIColor grayColor]
#define Color_Text_DarkGray       [UIColor darkGrayColor]


#define Color_Text_LightGray  [UIColor lightGrayColor]

//按钮灰色未点击字色
#define Color_UnSelectText    UIColorFromRGB(0xcdcdcd)

#endif /* ColorMap_h */
