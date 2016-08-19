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

- (void)setCancelTitle:(NSString * _Nullable)cancelTitle
         cancelHandler:(TapCancelHandler _Nullable)cancelHander {
    self.cancelTitle = cancelTitle;
    self.cancelHandler = cancelHander;
}

- (void)setDestructiveTitle:(NSString * _Nullable)destructiveTitle
         destructiveHandler:(TapDestructiveHandler _Nullable)destructiveHandler {
    self.destructiveTitle = destructiveTitle;
    self.destructiveHandler = destructiveHandler;
}

- (void)setOtherTitles:(NSArray<NSString *> * _Nullable)otherTitles
        defaultHandler:(TapIndexDefaultHandler _Nullable)defaultHandler {
    self.otherTitles = otherTitles;
    self.defaultHandler = defaultHandler;
}

- (void)setDefaultAction:(TapIndexDefaultHandler _Nullable)defaultHander
          forOtherTitles:(nullable NSString *)otherTitles, ... NS_REQUIRES_NIL_TERMINATION {
    //获取不定参数
    va_list otherTitles_list;
    va_start(otherTitles_list, otherTitles);
    NSString *tempOtherTitle;
    NSMutableArray<NSString *> *tempOtherTitles = [NSMutableArray arrayWithCapacity:1];
    [tempOtherTitles addObject:otherTitles];
    while ((tempOtherTitle = va_arg(otherTitles_list, NSString *))) {
        [tempOtherTitles addObject:tempOtherTitle];
    }
    va_end(otherTitles_list);
    [self setOtherTitles:tempOtherTitles];
    
    self.defaultHandler = defaultHander;
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