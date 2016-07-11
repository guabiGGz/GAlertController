



//
//  GAlertController.m
//  iGanDong
//
//  Created by ksjr-zg on 16/6/22.
//  Copyright © 2016年 iGanDong. All rights reserved.
//

#import "GAlertController.h"
#import <objc/runtime.h>

@interface GAlertController () <UIAlertViewDelegate, UIActionSheetDelegate>
@property (nonatomic)         GAlertStyle  style;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) UIAlertView  *alertView;
@property (nonatomic, strong) UIActionSheet  *actionSheet;
#pragma clang diagnostic pop
@property (nonatomic, strong) UIAlertController  *alertController;
@property (nonatomic, copy)   NSString      *title;
@property (nonatomic, copy)   NSString      *message;
@property (nonatomic, copy)   NSString      *destructiveTitle;
@property (nonatomic, copy)   NSString      *cancelTitle;

@property (nonatomic, copy)   TapIndexDefaultHandler defaultHandler;
@property (nonatomic, copy)   TapCancelHandler cancelHandler;
@property (nonatomic, copy)   TapDestructiveHandler destructiveHandler;
@end
@implementation GAlertController

+ (_Nonnull instancetype)alertWithStyle:(GAlertStyle )style
                                  title:(nullable NSString *)title
                                    msg:(nullable NSString *)msg
                       destructiveTitle:(nullable NSString *)destructiveTitle
                            cancelTitle:(nullable NSString *)cancelTitle
                     destructiveHandler:(nullable TapDestructiveHandler)destructiveHandler
                         defaultHandler:(nullable TapIndexDefaultHandler)defaultHandler
                          cancelHandler:(nullable TapCancelHandler)cancelHandler
                             otherTitle:( NSString * _Nonnull  )otherTitle,... NS_REQUIRES_NIL_TERMINATION {
    
    GAlertController *alert = [GAlertController alertWithType:style];
    alert.defaultHandler = defaultHandler;
    alert.cancelHandler = cancelHandler;
    alert.destructiveHandler = destructiveHandler;
    
    //获取不定参数
    va_list otherTitles_list;
    va_start(otherTitles_list, otherTitle);
    NSString *tempOtherTitle;
   alert.otherTitles = [NSMutableArray arrayWithCapacity:1];
    [alert.otherTitles addObject:otherTitle];
    while ((tempOtherTitle = va_arg(otherTitles_list, NSString *))) {
        [alert.otherTitles addObject:tempOtherTitle];
    }
    va_end(otherTitles_list);

    
    
    if ( floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_8_3 ) {
        switch(style) {
            case GAlertStyleDefault:
                alert.alertView = [alert createAlertWithTitle:title
                                                      message:msg
                                                     delegate:alert
                                            cancelButtonTitle:cancelTitle
                                               defaultHandler:alert.defaultHandler
                                                cancelHandler:alert.cancelHandler];
                    
                break;
            case GAlertStyleAction:
                alert.actionSheet = [alert createActionSheetWithTitle:title
                                                            delegate:alert
                                                   cancelButtonTitle:cancelTitle
                                              destructiveButtonTitle:destructiveTitle
                                                       defaultHandler:alert.defaultHandler
                                                        cancelHandler:alert.cancelHandler
                                                   destructiveHandler:alert.destructiveHandler];
                break;
        }
    }
    
    
    else {

        alert.alertController = [alert createAlertControllerWithStyle:style
                                                               title:title
                                                             message:msg
                                                   cancelButtonTitle:cancelTitle
                                                    destructiveTitle:destructiveTitle
                                                       defaultHandler:alert.defaultHandler
                                                        cancelHandler:alert.cancelHandler
                                                   destructiveHandler:alert.destructiveHandler];
    }
      return alert;
}

+ (_Nonnull instancetype)alertWithType:(GAlertStyle)style {
    GAlertController *alert  = [[GAlertController alloc] init];
    alert.style = style;
    return alert;
}

- (nullable instancetype)style:(GAlertStyle)style {
    self.style = style;
    return self;
}

- (GAlertController *)title:(NSString *)title {
    self.title = title;
    return self;
}

- (GAlertController *)message:(NSString *)message {
    self.message = message;
    return self;
}

- (GAlertController *)destructiveTitle:(NSString *)destructiveTitle {
    self.destructiveTitle = destructiveTitle;
    return self;
}

- (GAlertController *)cancelTitle:(NSString *)cancelTitle {
    self.cancelTitle = cancelTitle;
    return self;
}

- (GAlertController *)destructiveHandler:(nullable TapDestructiveHandler)destructiveHandler {
    self.destructiveHandler = destructiveHandler;
    return self;
}

- (GAlertController *)defaultHandler:(nullable TapIndexDefaultHandler)defaultHandler {
    self.defaultHandler = defaultHandler;
    return self;
}

- (GAlertController *)cancelHandler:(nullable TapCancelHandler)cancelHandler {
    self.cancelHandler = cancelHandler;
    return self;
}

- (GAlertController *)otherTitle:( NSString * _Nonnull  )otherTitle,... NS_REQUIRES_NIL_TERMINATION {
    //获取不定参数
    va_list otherTitles_list;
    va_start(otherTitles_list, otherTitle);
    NSString *tempOtherTitle;
    self.otherTitles = [NSMutableArray arrayWithCapacity:1];
    [self.otherTitles addObject:otherTitle];
    while ((tempOtherTitle = va_arg(otherTitles_list, NSString *))) {
        [self.otherTitles addObject:tempOtherTitle];
    }
    va_end(otherTitles_list);

    return self;
}

- (void)showAtViewController:( __kindof UIViewController * _Nonnull )viewController {
    if (!viewController)            return;
    if ( floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_8_3 ) {
    objc_setAssociatedObject(viewController, @"ggAlert", self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);  
    switch(self.style) {
            case GAlertStyleDefault:
                self.alertView = [self createAlertWithTitle:self.title
                                                      message:self.message
                                                     delegate:self
                                            cancelButtonTitle:self.cancelTitle
                                               defaultHandler:self.defaultHandler
                                                cancelHandler:self.cancelHandler];
                
                break;
            case GAlertStyleAction:
                self.actionSheet = [self createActionSheetWithTitle:self.title
                                                             delegate:self
                                                    cancelButtonTitle:self.cancelTitle
                                               destructiveButtonTitle:self.destructiveTitle
                                                       defaultHandler:self.defaultHandler
                                                        cancelHandler:self.cancelHandler
                                                   destructiveHandler:self.destructiveHandler];
                break;
        }
    }
    
    
    else {
        
        self.alertController = [self createAlertControllerWithStyle:self.style
                                                                title:self.title
                                                              message:self.message
                                                    cancelButtonTitle:self.cancelTitle
                                                     destructiveTitle:self.destructiveTitle
                                                       defaultHandler:self.defaultHandler
                                                        cancelHandler:self.cancelHandler
                                                   destructiveHandler:self.destructiveHandler];
    }
    
    if ( floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_8_3 ) {
        switch (self.style) {
            case GAlertStyleDefault: {
                [self.alertView show];
                break;
            }
            case GAlertStyleAction: {
                [self.actionSheet showInView:viewController.view];
                break;
            }
        }

    }
    
    else {
        [viewController presentViewController:self.alertController animated:YES completion:nil];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIAlertView *)createAlertWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                             delegate:(nullable id /*<UIAlertViewDelegate>*/)delegate
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                       defaultHandler:(TapIndexDefaultHandler)defaultHandler
                        cancelHandler:(TapCancelHandler)cancelHandler {
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:title
                                      message:message
                                     delegate:delegate
                            cancelButtonTitle:cancelButtonTitle
                            otherButtonTitles:nil];
    @autoreleasepool {
        for (int i = 0; i < self.otherTitles.count; i++) {
            [al addButtonWithTitle:self.otherTitles[i]];
        }
    }
    
    return al;
}
#pragma clang diagnostic pop

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIActionSheet *)createActionSheetWithTitle:(nullable NSString *)title
                                     delegate:(nullable id<UIActionSheetDelegate>)delegate
                            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                       destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                               defaultHandler:(TapIndexDefaultHandler)defaultHandler
                                cancelHandler:(TapCancelHandler)cancelHandler
                           destructiveHandler:(TapDestructiveHandler)destructiveHandler {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                       delegate:delegate
                              cancelButtonTitle:cancelButtonTitle
                         destructiveButtonTitle:destructiveButtonTitle
                              otherButtonTitles:nil];
    @autoreleasepool {
        for (int i = 0; i < self.otherTitles.count; i++) {
            [actionSheet addButtonWithTitle:self.otherTitles[i]];
        }
    }
    return actionSheet;
}
#pragma clang diagnostic pop

- (UIAlertController *)createAlertControllerWithStyle:(GAlertStyle)style
                                                title:(nullable NSString *)title
                                              message:(nullable NSString *)message
                                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                     destructiveTitle:(NSString *)destructiveTitle
                                       defaultHandler:(TapIndexDefaultHandler)defaultHandler
                                        cancelHandler:(TapCancelHandler)cancelHandler
                                   destructiveHandler:(TapDestructiveHandler)destructiveHandler {
    
    switch(style) {
        case GAlertStyleDefault:{
            self.alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            break;
        }
        case GAlertStyleAction:{
            self.alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        }
            break;
    }
    
    NSInteger indexOffset = 0;
    if(cancelButtonTitle) {
        indexOffset += 1;
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if(cancelHandler)       cancelHandler();
        }];
        [self.alertController addAction:cancelAction];
    }
                                       
    if(destructiveTitle) {
        indexOffset += 1;
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if(destructiveHandler)       destructiveHandler();
        }];
        [self.alertController addAction:destructiveAction];
    }
    
    if(self.otherTitles) {
        @autoreleasepool {
            for (int i = 0; i < self.otherTitles.count; i++) {
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:self.otherTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if(defaultHandler)       defaultHandler(i + indexOffset);
                }];
                [self.alertController addAction:otherAction];
            }
        }
    }
    return self.alertController;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0) {
    
    if (buttonIndex == alertView.cancelButtonIndex) {
        if (self.cancelHandler)   self.cancelHandler();
    } else {
        self.defaultHandler(buttonIndex);
    }
    // objc_removeAssociatedObjects(self);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
- (void)alertViewCancel:(UIAlertView *)alertView {
//    if (self.cancelHandler)   self.cancelHandler();
    // objc_removeAssociatedObjects(self);
}
#pragma clang diagnostic pop

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (!buttonIndex) {
        if (self.destructiveHandler) self.destructiveHandler();
    } else {
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            if (self.cancelHandler)   self.cancelHandler();
        } else {
            self.defaultHandler(buttonIndex);
        }
    }
    // objc_removeAssociatedObjects(self);
}
#pragma clang diagnostic pop

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    //objc_removeAssociatedObjects(self);
}
#pragma clang diagnostic pop
@end
