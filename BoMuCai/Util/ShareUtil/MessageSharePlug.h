//
//  MessageSharePlug.h
//  QueenBK
//
//  Created by 步晓虎 on 15/8/24.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSharePlug.h"
#import <MessageUI/MessageUI.h>

@interface MessageSharePlug : BaseSharePlug<MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>

@end