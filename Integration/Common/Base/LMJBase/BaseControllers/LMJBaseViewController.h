//
//  LLMJBBaseViewController.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/11.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJRequestBaseViewController.h"


@interface LMJBaseViewController : LMJRequestBaseViewController

@property(nonatomic,copy)NSDictionary *parameter;

@property(nonatomic,copy)NSString *ID;

@end
