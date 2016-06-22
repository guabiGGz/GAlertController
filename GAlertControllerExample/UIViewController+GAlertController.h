//
//  UIViewController+GAlertController.h
//  升级版流式标签支持点击
//
//  Created by mac on 16/6/22.
//  Copyright © 2016年 zhangguobing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAlertController.h"

#import "GAlertMaker.h"
@interface UIViewController (GAlertController)
- (void)showAlert:(void(^)(GAlertMaker *make))block;
@end
