
//
//  FMPFontMap.h
//  Category
//
//  Created by Evan.Cheng on 15/12/26.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#ifndef FontMap_h
#define FontMap_h

// 设备
#define Is_iPhone4   (CGRectEqualToRect([[UIScreen mainScreen] bounds], CGRectMake(0, 0, 320, 480)))

#define Is_iPhone5   (CGRectEqualToRect([[UIScreen mainScreen] bounds], CGRectMake(0, 0, 320, 568)))

#define Is_iPhone6   (CGRectEqualToRect([[UIScreen mainScreen] bounds], CGRectMake(0, 0, 375, 667)))

#define Is_iPhone6plus  (CGRectEqualToRect([[UIScreen mainScreen] bounds], CGRectMake(0, 0, 414, 736)))


// 字体
#define FontWithPIX(__FontSize__) [UIFont systemFontOfSize:(__FontSize__/2.0)]

#define FontWithSize(__FontSize__) [UIFont systemFontOfSize:__FontSize__]


//#define Font_ch_Size_6   (Is_iPhone6plus ? 20 : 18)
#define Font_sys_18      [UIFont systemFontOfSize:18]
#define Font_Bold_18     [UIFont boldSystemFontOfSize:18]

#define Font_sys_17      [UIFont systemFontOfSize:17]
#define Font_Bold_17     [UIFont boldSystemFontOfSize:17]

#define Font_sys_15      [UIFont systemFontOfSize:15]
#define Font_Bold_15     [UIFont boldSystemFontOfSize:15]

//#define Font_ch_Size_7   (Is_iPhone6plus ? 18 : 16)
#define Font_sys_16      [UIFont systemFontOfSize:16]
#define Font_Bold_16     [UIFont boldSystemFontOfSize:16]

//#define Font_ch_Size_8   (Is_iPhone6plus ? 16 : 14)
#define Font_sys_14      [UIFont systemFontOfSize:14]
#define Font_Bold_14     [UIFont boldSystemFontOfSize:14]

//#define Font_ch_Size_10  (Is_iPhone6plus ? 15 : 13)
#define Font_sys_13      [UIFont systemFontOfSize:13]
#define Font_Bold_13     [UIFont boldSystemFontOfSize:13]

//#define Font_ch_Size_12  (Is_iPhone6plus ? 14 : 12)
#define Font_sys_12      [UIFont systemFontOfSize:12]
#define Font_Bold_12     [UIFont boldSystemFontOfSize:12]

//#define Font_ch_Size_11  (Is_iPhone6plus ? 13 : 11)
#define Font_sys_11      [UIFont systemFontOfSize:11]
#define Font_Bold_11     [UIFont boldSystemFontOfSize:11]


//#define Font_ch_Size_14  (Is_iPhone6plus ? 12 : 10)
#define Font_sys_10      [UIFont systemFontOfSize:10]
#define Font_Bold_10     [UIFont boldSystemFontOfSize:10]

//#define Font_ch_Size_13  (Is_iPhone6plus ? 11 : 9)
#define Font_sys_9       [UIFont systemFontOfSize:9]
#define Font_Bold_9      [UIFont boldSystemFontOfSize:9]

#define Font_sys_8       [UIFont systemFontOfSize:8]
#define Font_Bold_8      [UIFont boldSystemFontOfSize:8]

//页面文字
#define Font_TextBtn_Big Font_Bold_16
#define Font_TextBtn_Mid Font_Bold_14

#define Font_TextTable   Font_sys_14
#define Font_TextMid     Font_sys_13
#define Font_TextSmall   Font_sys_12


#endif /* FontMap_h */
