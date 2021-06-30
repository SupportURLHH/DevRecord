//
//  LMJWebViewController.m
//  PLMMPRJK
//
//  Created by NJHu on 2017/4/9.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJWebViewController.h"

/// URL key for 404 not found page.
static NSString *const kAX404NotFoundURLKey = @"ax_404_not_found";
/// URL key for network error page.
static NSString *const kAXNetworkErrorURLKey = @"ax_network_error";

/// URL key for 404 not found page.
static NSString *const kAX404NotFoundBackKey = @"ax_404_back";
/// URL key for network error page.
static NSString *const kAXNetworkErrorBackKey = @"ax_network_back";

@interface LMJWebViewController ()

/** <#digest#> */
@property (weak, nonatomic) UIProgressView *progressView;

/** <#digest#> */
@property (strong, nonatomic) UIButton *backBtn;

/** <#digest#> */
@property (strong, nonatomic) UIButton *closeBtn;

@end

@implementation LMJWebViewController

- (void)setGotoURL:(NSString *)gotoURL {
//    @"`#%^{}\"[]|\\<> "   最后有一位空格
    _gotoURL = gotoURL;
//    [gotoURL stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "] invertedSet]];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    LMJWeak(self);
    [self.wkWebView addObserverBlockForKeyPath:LMJKeyPath(weakself.wkWebView, estimatedProgress) block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        weakself.progressView.progress = weakself.wkWebView.estimatedProgress;
        if (weakself.wkWebView.estimatedProgress  >= 1.0f ) {
            // 加载完成
            [UIView animateWithDuration:0.25f animations:^{
                weakself.progressView.alpha = 0.0f;
                weakself.progressView.progress = 0.0f;
            }];
        }else{
            weakself.progressView.alpha = 1.0f;
        }
    }];
    
    [self.wkWebView addObserverBlockForKeyPath:LMJKeyPath(self.wkWebView, title) block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        if (!LMJIsEmpty(newVal) && [newVal isKindOfClass:[NSString class]] && [weakself webViewController:weakself webViewIsNeedAutoTitle:weakself.wkWebView]) {
            weakself.title = newVal;
        }
    }];
    
    [self.wkWebView.scrollView addObserverBlockForKeyPath:LMJKeyPath(self.wkWebView.scrollView, contentSize) block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        [weakself webView:weakself.wkWebView scrollView:weakself.wkWebView.scrollView contentSize:weakself.wkWebView.scrollView.contentSize];
    }];

    if (self.gotoURL.length > 0) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.gotoURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
        [self.wkWebView loadRequest:request];
        
    }else if (!LMJIsEmpty(self.contentHTML)) {
        [self.wkWebView loadHTMLString:self.contentHTML baseURL:self.baseURL];
        
    }else{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kAX404NotFoundHTMLPath] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
        [self.wkWebView loadRequest:request];
    }
}

- (void)loadURL:(NSURL *)pageURL {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:pageURL];
    request.timeoutInterval = 20;
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    [self.wkWebView loadRequest:request];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.progressView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

//- (NSMutableAttributedString *)lmjNavigationBarTitle:(LMJNavigationBar *)navigationBar{
//    return [self changeTitle:nil];
//}

- (CGFloat)lmjNavigationHeight:(LMJNavigationBar *)navigationBar{
    return TopBarHeight;
}

#pragma mark - LMJNavUIBaseViewControllerDataSource
#pragma mark - 设置左上角的一个返回按钮和一个关闭按钮
/** 导航条的左边的 view */
- (UIView *)lmjNavigationBarLeftView:(LMJNavigationBar *)navigationBar
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];

    leftView.backgroundColor = [UIColor whiteColor];

    self.backBtn.mj_origin = CGPointZero;

    self.closeBtn.mj_x = leftView.mj_w - self.closeBtn.mj_w;

    [leftView addSubview:self.backBtn];

    [leftView addSubview:self.closeBtn];

    return leftView;
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    [self backBtnClick:sender webView:self.wkWebView];
}

- (void)left_close_button_event:(UIButton *)sender
{
    [self closeBtnClick:sender webView:self.wkWebView];
}

#pragma mark - LMJWebViewControllerDataSource
// 默认需要, 是否需要进度条
- (BOOL)webViewController:(LMJWebViewController *)webViewController webViewIsNeedProgressIndicator:(WKWebView *)webView
{
    return YES;
}

// 默认需要自动改变标题
- (BOOL)webViewController:(LMJWebViewController *)webViewController webViewIsNeedAutoTitle:(WKWebView *)webView
{
    return YES;
}

#pragma mark - LMJWebViewControllerDelegate
//// 导航条左边的返回按钮的点击
- (void)backBtnClick:(UIButton *)backBtn webView:(WKWebView *)webView
{
    if (self.wkWebView.canGoBack) {
        self.closeBtn.hidden = NO;
        [self.wkWebView goBack];
    }else
    {
        self.closeBtn.hidden = YES;
        [self closeBtnClick:self.closeBtn webView:self.wkWebView];
    }
}

//// 关闭按钮的点击
- (void)closeBtnClick:(UIButton *)closeBtn webView:(WKWebView *)webView {
    // 判断两种情况: push 和 present
    if ((self.navigationController.presentedViewController || self.navigationController.presentingViewController) && self.navigationController.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 监听 self.webView.scrollView 的 contentSize 属性改变，从而对底部添加的自定义 View 进行位置调整
- (void)webView:(WKWebView *)webView scrollView:(UIScrollView *)scrollView contentSize:(CGSize)contentSize
{
    NSLog(@"%@\n%@\n%@", webView, scrollView, NSStringFromCGSize(contentSize));
}

#pragma mark - webDelegate
// 1, 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
//    NSURLComponents *components = [[NSURLComponents alloc] initWithString:navigationAction.request.URL.absoluteString];
//
//    // URL actions for 404 and Errors:
//    if ([[NSPredicate predicateWithFormat:@"SELF ENDSWITH[cd] %@ OR SELF ENDSWITH[cd] %@", kAX404NotFoundURLKey, kAXNetworkErrorURLKey] evaluateWithObject:components.URL.absoluteString]) {
//        // Reload the original URL.
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.gotoURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
//        [self.wkWebView loadRequest:request];
//    }
//
//    // Back actions for 404 and Errors:
//    if ([[NSPredicate predicateWithFormat:@"SELF ENDSWITH[cd] %@ OR SELF ENDSWITH[cd] %@", kAX404NotFoundBackKey, kAXNetworkErrorBackKey] evaluateWithObject:components.URL.absoluteString]) {
//        // Reload the original URL.
//        [self.navigationController popViewControllerAnimated:YES];
//        decisionHandler(WKNavigationActionPolicyCancel);
//        return;
//    }
    NSLog(@"decidePolicyForNavigationAction   ====    %@", navigationAction);
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

// 2开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"didStartProvisionalNavigation   ====    %@", navigation);
}

// 4, 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"decidePolicyForNavigationResponse   ====    %@", navigationResponse);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 5,内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSLog(@"didCommitNavigation   ====    %@", navigation);
}

// 7页面加载完调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    if (self.wkWebView.canGoBack) {
        self.closeBtn.hidden = NO;
    }else {
        self.closeBtn.hidden = YES;
    }
    NSLog(@"didFinishNavigation   ====    %@", navigation);
}

- (void)webView:(WKWebView *)webView didReceiveScriptMessage:(WKScriptMessage *)message zykBody:(NSString *)body
{
    NSLog(@"didReceiveScriptMessage  zykBody ====    %@", body);
}

// 8页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
//    if (error.code == NSURLErrorCannotFindHost) {// 404
//        [self loadURL:[NSURL fileURLWithPath:kAX404NotFoundHTMLPath]];
//    } else {
//        [self loadURL:[NSURL fileURLWithPath:kAXNetworkErrorHTMLPath]];
//    }
//    NSLog(@"didFailProvisionalNavigation   ====    %@\nerror   ====   %@", navigation, error);
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"网页加载失败" message:@"是否退出页面" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alertVC addAction:actionCancel];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        if (self.wkWebView.canGoBack) {
//            [self.wkWebView goBack];
//        }else{
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
//    [alertVC addAction:action];
//    [self presentViewController:alertVC animated:YES completion:nil];
}

//当 WKWebView 总体内存占用过大，页面即将白屏的时候，系统会调用回调函数
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
    NSLog(@"webViewWebContentProcessDidTerminate");
}

#pragma mark - 懒加载
- (WKWebView *)wkWebView
{
    if(_wkWebView == nil)
    {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];///初始化一个WKWebViewConfiguration对象
        config.preferences = [WKPreferences new];///初始化偏好设置属性：preferences
        config.preferences.minimumFontSize = 17; ///The minimum font size in points default is 0;
        config.preferences.javaScriptEnabled = YES;///是否支持JavaScript
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;///不通过用户交互，是否可以打开窗口
        config.dataDetectorTypes = UIDataDetectorTypeAll;/// 检测各种特殊的字符串：比如电话、网站
        config.allowsInlineMediaPlayback = YES;/// 播放视频
        config.userContentController = [WKUserContentController new];
//        [config.userContentController addScriptMessageHandler:self name:@"hybrid"];
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, TopBarHeight, self.view.bounds.size.width, self.view.bounds.size.height-TopBarHeight) configuration:config];
        webView.scrollView.bounces = NO;
        [self.view addSubview:webView];
        _wkWebView = webView;
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        webView.opaque = NO;
        webView.backgroundColor = [UIColor clearColor];
//        webView.allowsBackForwardNavigationGestures = NO;/// 取消网页的滑动返回上级
        
    }
    return _wkWebView;
}

/// 加载进度条
- (UIProgressView *)progressView
{
    if(_progressView == nil && [self.parentViewController isKindOfClass:[UINavigationController class]])
    {
        UIProgressView *progressView = [[UIProgressView alloc] init];
        [self.view addSubview:progressView];
        _progressView = progressView;
        progressView.mj_h = 1;
        progressView.mj_w = self.view.mj_w;
        progressView.mj_y = self.lmj_navgationBar.mj_h;
        progressView.tintColor = UIColorHex(0x4485F4);
        if ([self respondsToSelector:@selector(webViewController:webViewIsNeedProgressIndicator:)]) {
            if (![self webViewController:self webViewIsNeedProgressIndicator:self.wkWebView]) {
                progressView.hidden = YES;
            }
        }
    }
    return _progressView;
}

/// 返回上级
- (UIButton *)backBtn
{
    if(_backBtn == nil)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
        btn.mj_size = CGSizeMake(34, 44);
        [btn addTarget:self action:@selector(leftButtonEvent:navigationBar:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn = btn;
    }
    return _backBtn;
}

/// 关闭页面
- (UIButton *)closeBtn
{
    if(_closeBtn == nil)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.hidden = YES;
        [btn setTitle:@"关闭" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        btn.mj_size = CGSizeMake(44, 44);
        btn.hidden = NO;
        [btn addTarget:self action:@selector(left_close_button_event:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn = btn;
    }
    return _closeBtn;
}

- (void)dealloc
{
//    [_wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"hybrid"];
    NSLog(@"LMJWebViewController -- dealloc");
    [_wkWebView.scrollView removeObserverBlocks];
    [_wkWebView removeObserverBlocks];
    _wkWebView.UIDelegate = nil;
    _wkWebView.navigationDelegate = nil;
    _wkWebView.scrollView.delegate = nil;
}
@end

