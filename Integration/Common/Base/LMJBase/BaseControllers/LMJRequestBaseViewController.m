//
//  LMJRequestBaseViewController.m
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/24.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJRequestBaseViewController.h"

@interface LMJRequestBaseViewController ()

@end

@implementation LMJRequestBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 加载框
- (void)showLoading
{
//    [MBProgressHUD showProgressToView:self.view Text:@"加载中..."];
}

- (void)dismissLoading
{
//    [MBProgressHUD hideHUDForView:self.view];
}

- (void)showLoading:(NSString *)LoadingText
{
//    [MBProgressHUD showProgressToView:self.view Text:LoadingText];
}

- (void)dealloc
{
    if ([self isViewLoaded]) {
//        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }
}

@end
