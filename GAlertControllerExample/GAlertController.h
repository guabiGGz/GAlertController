//
//  GAlertController.h
//  iGanDong
//
//  Created by ksjr-zg on 16/6/22.
//  Copyright © 2016年 iGanDong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


//NS_ASSUME_NONNULL_BEGIN

typedef void (^TapCancelHandler)(void);
typedef void (^TapDestructiveHandler)(void);
typedef void (^TapIndexDefaultHandler)(NSInteger tapIndex);

typedef NS_ENUM(NSInteger, GAlertStyle) {
    GAlertStyleDefault = 0,
    GAlertStyleAction
};

@interface GAlertController : NSObject
@property (nonatomic, strong)  NSMutableArray<NSString *>  * _Nonnull otherTitles;
+ (_Nonnull instancetype)alertWithStyle:(GAlertStyle )style
                                  title:(nullable NSString *)title
                                    msg:(nullable NSString *)msg
                       destructiveTitle:(nullable NSString *)destructiveTitle
                            cancelTitle:(nullable NSString *)cancelTitle
                     destructiveHandler:(nullable TapDestructiveHandler)destructiveHandler
                         defaultHandler:(nullable TapIndexDefaultHandler)defaultHandler
                          cancelHandler:(nullable TapCancelHandler)cancelHandler
                             otherTitle:( NSString * _Nonnull  )otherTitle,... NS_REQUIRES_NIL_TERMINATION;


+ (_Nonnull instancetype)alertWithType:(GAlertStyle)styleX;

- (nullable instancetype)style:(GAlertStyle)style;

- (nullable instancetype)title:(nullable NSString * )title;

- (nullable instancetype)message:(nullable NSString *)message;

- (nullable instancetype)destructiveTitle:(nullable NSString *)destructiveTitle;

- (nullable instancetype)cancelTitle:(nullable NSString *)cancelTitle;

- (nullable instancetype)destructiveHandler:(nullable TapDestructiveHandler)destructiveHandler;

- (nullable instancetype)defaultHandler:(nullable TapIndexDefaultHandler)defaultHandler;

- (nullable instancetype)cancelHandler:(nullable TapCancelHandler)cancelHandler;

- (nullable instancetype)otherTitle:( NSString * _Nonnull  )otherTitle,... NS_REQUIRES_NIL_TERMINATION;

- (void)showAtViewController:( __kindof UIViewController * _Nonnull )viewController;
@end
//NS_ASSUME_NONNULL_END