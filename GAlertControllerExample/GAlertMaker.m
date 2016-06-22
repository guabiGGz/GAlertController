//
//  GAlertMaker.m
//  升级版流式标签支持点击
//
//  Created by mac on 16/6/22.
//  Copyright © 2016年 zhangguobing. All rights reserved.
//

#import "GAlertMaker.h"

@interface GAlertMaker ()
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) GAlertController *alert;
@end

@implementation GAlertMaker
- (void)setStyle:(GAlertStyle)style {
    [_alert style:style];
}

- (void)setTitle:(NSString *)title {
    [_alert title:title];
}

- (void)setDestructiveTitle:(NSString *)destructiveTitle {
    [_alert destructiveTitle:destructiveTitle];
}

- (void)setCancelTitle:(NSString *)cancelTitle {
    [_alert cancelTitle:cancelTitle];
}

- (void)setMessage:(NSString *)message {
    [_alert message:message];
}

- (void)setCancelHandler:(TapCancelHandler)cancelHandler {
    [_alert cancelHandler:cancelHandler];
}

- (void)setDefaultHandler:(TapIndexDefaultHandler)defaultHandler {
    [_alert defaultHandler:defaultHandler];
}

- (void)setDestructiveHandler:(TapDestructiveHandler)destructiveHandler {
    [_alert destructiveHandler:destructiveHandler];
}

- (void)setOtherTitles:(NSArray<NSString *> *)otherTitles {
    [_alert setOtherTitles:otherTitles.mutableCopy];
}

- (instancetype)initWithViewController:(__kindof UIViewController * _Nonnull )viewController {
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.alert = [[GAlertController alloc] init];
    }
    return self;
}

- (void)showAlert {
    [self.alert showAtViewController:self.viewController];
}
@end