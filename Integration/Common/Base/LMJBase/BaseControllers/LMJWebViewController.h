//
//  LMJWebViewController.h
//  PLMMPRJK
//
//  Created by NJHu on 2017/4/9.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJBaseViewController.h"
#import <WebKit/WebKit.h>

#define kAX404NotFoundHTMLPath [[NSBundle bundleForClass:NSClassFromString(@"AXWebViewController")] pathForResource:@"html.bundle/404" ofType:@"html"]

#define kAXNetworkErrorHTMLPath [[NSBundle bundleForClass:NSClassFromString(@"AXWebViewController")] pathForResource:@"html.bundle/neterror" ofType:@"html"]


@class LMJWebViewController;
@protocol LMJWebViewControllerDelegate <NSObject>

@optional
// 左上边的返回按钮点击
- (void)backBtnClick:(UIButton *)backBtn webView:(WKWebView *)webView ;

//左上边的关闭按钮的点击
- (void)closeBtnClick:(UIButton *)closeBtn webView:(WKWebView *)webView;

// 监听 self.webView.scrollView 的 contentSize 属性改变，从而对底部添加的自定义 View 进行位置调整
- (void)webView:(WKWebView *)webView scrollView:(UIScrollView *)scrollView contentSize:(CGSize)contentSize;

@end


@protocol LMJWebViewControllerDataSource <NSObject>

@optional
// 默认需要, 是否需要进度条
- (BOOL)webViewController:(LMJWebViewController *)webViewController webViewIsNeedProgressIndicator:(WKWebView *)webView;

// 默认需要自动改变标题
- (BOOL)webViewController:(LMJWebViewController *)webViewController webViewIsNeedAutoTitle:(WKWebView *)webView;

@end

@interface LMJWebViewController : LMJBaseViewController<WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler, LMJWebViewControllerDelegate, LMJWebViewControllerDataSource>

/** webView */
@property (nonatomic, strong) WKWebView *wkWebView;

/** <#digest#> */
@property (nonatomic, copy) NSString *gotoURL;

/** <#digest#> */
@property (nonatomic, copy) NSString *contentHTML;

@property (nonatomic, copy) NSURL *baseURL;

- (void)loadURL:(NSURL *)pageURL;

// 7页面加载完调用, 必须调用super
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation NS_REQUIRES_SUPER;


// 8页面加载失败时调用, 必须调用super
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error NS_REQUIRES_SUPER;

- (void)webView:(WKWebView *)webView didReceiveScriptMessage:(WKScriptMessage *)message zykBody:(NSString *)body;

@end
