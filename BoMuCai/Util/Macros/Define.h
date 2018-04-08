//
//  Define.h
//  HangZhouSchool
//
//  Created by admin on 16/1/31.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#ifndef Define_h
#define Define_h


#define HEIGHT_LINE (1.0/[UIScreen mainScreen].scale)

#define MainAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/*-----------screen----------*/
#define DEF_SCREENBOUNDS ([UIScreen mainScreen].bounds)

#define DEF_SCREENSIZE  ([UIScreen mainScreen].bounds.size)

#define DEF_SCREENWIDTH ([UIScreen mainScreen].bounds.size.width)

#define DEF_SCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)

#define BXHStrongObj(o) __strong typeof(o) o##Strong = o;

#define BXHWeakObj(o) __weak typeof(o) o##Weak = o;

#define BXHBlockObj(o) __block typeof(o) o##block = o;


#define WebHead @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta http-equiv=\"Cache-Control\" content=\"no-cache\"/><meta name=\"viewport\" content=\"width=device-width; initial-scale=1.4;  minimum-scale=1.0; maximum-scale=2.0\"/><meta name=\"MobileOptimized\" content=\"240\"/></head>"

//图片
#define ImageWithName(imageName) [UIImage imageNamed:imageName]

#define ImagePlaceHolder  ImageWithColor([UIColor lightGrayColor]) //ImageWithName(@"PlaceHoldImage")

#define ImageWithResizableImage(imageName,edgInset) [[UIImage imageNamed:imageName] resizableImageWithCapInsets:edgInset resizingMode:UIImageResizingModeStretch]

#define ImageStartLoadUrl @"ImageStartLoadUrl"

// 资源路径
#define PathForResource(__ResourceName__,__Type__) ([[NSBundle mainBundle] pathForResource:__ResourceName__ ofType:__Type__])


// 发送通知
#define NotificationPost(__notificationName__)   [[NSNotificationCenter defaultCenter] postNotificationName:__notificationName__ object:nil]

// 发送带参数的通知
#define NotificationParamsPost(__notificationName__,__object__)   [[NSNotificationCenter defaultCenter] postNotificationName:__notificationName__ object:__object__]

// 发送通知 与 userInfo
#define NotificationPostWithUserInfo(__notificationName__,__userInfo__)   [[NSNotificationCenter defaultCenter] postNotificationName:__notificationName__ object:nil userInfo:__userInfo__]

// 添加观察者
#define NotificationAddObserver(__observer__,__selector__,__notificationName__)   [[NSNotificationCenter defaultCenter] addObserver:self selector:__selector__ name:__notificationName__ object:nil]
// 移除观察者
#define NotificationRemoveObserver(__observer__,__notificationName__)    [[NSNotificationCenter defaultCenter] removeObserver:__observer__ name:__notificationName__ object:nil]

// 提示框
#define ToastShowTop(text) [XHToast showTopWithText:text duration:2]
#define ToastShowCenter(text) [XHToast showCenterWithText:text duration:2]
#define ToastShowBottom(text) [XHToast showBottomWithText:text duration:2]
#define ToastShowBottomAndDuation(text,dur) [XHToast showBottomWithText:text duration:dur]


#define ProgressHidden(view)  [LBProgressHUD hideAllHUDsForView:view animated:YES]
#define ProgressShow(view) [LBProgressHUD showHUDto:view animated:YES]

#define NetWorkErrorTip @"网络错误请重新连接"


#endif /* Define_h */
