//
//  PCWebViewController.m
//  PersonalCapital
//
//  Created by Juan Balderas on 19/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCWebViewController.h"

#import "PCWebView.h"

@interface PCWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong, readonly) PCWebView *webView;

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSString *viewTitle;

@end

@implementation PCWebViewController

#pragma mark - Lazy load.

-(PCWebView *)webView {
    return (PCWebView *)self.view;
}

-(NSString *)title {
    return self.viewTitle;
}

-(NSURL *)url {
    return self.request.URL;
}

#pragma mark - Life cycle

-(instancetype)initWithTitle:(NSString *)title andURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.request = [NSURLRequest requestWithURL:url];
        self.viewTitle = title;
    }
    return self;
}

-(void)loadView {
    self.view = [PCWebView new];
}

-(void)prepareView {
    [super prepareView];
    self.webView.webView.navigationDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.webView.webView loadRequest:self.request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleView];
}

- (void)addTitleView {
    self.navigationController.navigationBar.prefersLargeTitles = false;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    titleLabel.text = self.viewTitle;
    self.navigationItem.titleView = titleLabel;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.webView.activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.webView.activityIndicator stopAnimating];
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"error loading pageL: %@", error.localizedDescription);
}


@end
