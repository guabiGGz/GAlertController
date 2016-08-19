//
//  ViewController.m
//  GAlertControllerExample
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 com.crazycode.zg. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+GAlertController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.tag = 0;
    [button addTarget:self action:@selector(showAlertButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.center = self.view.center;
}

- (void)showAlertButton:(UIButton *)sender {
    GAlertStyle style;
    sender.tag = sender.tag ? 0 : 1;
    style = (sender.tag) ? GAlertStyleAction : GAlertStyleDefault;
    [self showAlert:^(GAlertMaker *make) {
        make.style = style;
        make.title = @"title";
        make.message = @"message";
        [make setDestructiveTitle:@"xx" destructiveHandler:^{
            NSLog(@"xx");
        }];
        [make setCancelTitle:@"cancel" cancelHandler:^{
            NSLog(@"cancel");
        }];
        [make setDefaultAction:^(NSInteger tapIndex) {
            NSLog(@"tap %ld",(long)tapIndex);
        } forOtherTitles:@"aa",@"bb",@"cc", nil];
//        [make setOtherTitles:@[@"aa",@"bb",@"cc"] defaultHandler:^(NSInteger tapIndex) {
//            NSLog(@"tap %ld",(long)tapIndex);
//        }];
//        make.cancelTitle = @"cancelTitle";
      
       
//        make.cancelHandler = ^{
//            NSLog(@"cancel!!!");
//        };
//        
//       
//        make.defaultHandler = ^(NSInteger index){
//            NSLog(@"tap %ld",(long)index);
//        };
//        make.otherTitles = @[@"aa",@"bb",@"cc"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end