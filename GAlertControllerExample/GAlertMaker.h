//
//  GAlertMaker.h
//  升级版流式标签支持点击
//
//  Created by mac on 16/6/22.
//  Copyright © 2016年 zhangguobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAlertController.h"
@interface GAlertMaker : NSObject

@property (nonatomic)         GAlertStyle  style;
@property (nonatomic, copy, nullable)   NSString      *title;
@property (nonatomic, copy, nullable)   NSString      *message;
@property (nonatomic, copy, nullable)   NSString      *destructiveTitle;
@property (nonatomic, copy, nullable)   NSString      *cancelTitle;
@property (nonatomic, strong, nullable) NSArray<NSString *> *otherTitles;
@property (nonatomic, copy, nullable)   TapIndexDefaultHandler defaultHandler;
@property (nonatomic, copy, nullable)   TapCancelHandler cancelHandler;
@property (nonatomic, copy, nullable)   TapDestructiveHandler destructiveHandler;

- (_Nonnull instancetype)initWithViewController:(__kindof UIViewController * _Nonnull )viewController;

- (void)setCancelTitle:(NSString * _Nullable)cancelTitle
         cancelHandler:(TapCancelHandler _Nullable)cancelHander;

- (void)setDestructiveTitle:(NSString * _Nullable)destructiveTitle
         destructiveHandler:(TapDestructiveHandler _Nullable)destructiveHandler;

//- (void)setOtherTitles:(NSArray<NSString *> * _Nullable)otherTitles
//        defaultHandler:(TapIndexDefaultHandler _Nullable)defaultHandler;

- (void)setDefaultAction:(TapIndexDefaultHandler _Nullable)defaultHander
     forOtherTitles:(nullable NSString *)otherTitles, ... NS_REQUIRES_NIL_TERMINATION ;

- (void)showAlert;
@end
