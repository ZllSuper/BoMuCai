//
//  BMShareView.h
//  BoMuCai
//
//  Created by Lala on 2017/12/15.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "SheetPresentStyleView.h"

typedef NS_ENUM(NSInteger, BMShareType) {
    BMShareTypeWXNone,            // 未选择
    BMShareTypeWXSession,         // 微信好友
    BMShareTypeWXTimeline,        // 微信朋友圈
};

typedef void(^BMShareViewBlock)( BMShareType shareType);

@interface BMShareView : SheetPresentStyleView

/**
 构造选择器
 
 @param completionBlock 点击确定按钮后的回调
 @return 实例
 */
- (instancetype _Nullable )initWithCompletionBlock:(BMShareViewBlock _Nullable )completionBlock;

@end
