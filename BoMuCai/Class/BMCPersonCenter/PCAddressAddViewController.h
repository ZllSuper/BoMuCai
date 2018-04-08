//
//  PCAddressAddViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCAddressModel.h"

typedef void(^AddressAddCompelet)(PCAddressModel *addressMode);

@interface PCAddressAddViewController : UIViewController

- (instancetype)initWithEditAddressModel:(PCAddressModel *)addressModel addressCompelet:(AddressAddCompelet)compelet;

- (instancetype)initWithCompelet:(AddressAddCompelet)compelet;

@end
