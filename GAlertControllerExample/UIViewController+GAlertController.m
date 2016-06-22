


//
//  UIViewController+GAlertController.m
//  升级版流式标签支持点击
//
//  Created by mac on 16/6/22.
//  Copyright © 2016年 zhangguobing. All rights reserved.
//

#import "UIViewController+GAlertController.h"

@implementation UIViewController (GAlertController)

- (void)showAlert:(void(^)(GAlertMaker *make))block  {
    GAlertMaker *make = [[GAlertMaker alloc] initWithViewController:self];
    block(make);
    [make showAlert];
}
@end
