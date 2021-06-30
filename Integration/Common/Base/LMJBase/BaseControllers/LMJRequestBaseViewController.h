//
//  LMJRequestBaseViewController.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/24.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJTextViewController.h"

@interface LMJRequestBaseViewController : LMJTextViewController
#pragma mark - 加载框

- (void)showLoading;

- (void)dismissLoading;

- (void)showLoading:(NSString *)LoadingText;
@end
