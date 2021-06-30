//
//  LMJTextViewController.m
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/26.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJTextViewController.h"

@interface LMJTextViewController ()
/** <#digest#> */
@property (nonatomic, strong) NSArray<UITextField *> *requiredTextFields;

@end

@implementation LMJTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


@end
