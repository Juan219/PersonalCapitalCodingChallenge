//
//  PCWebView.m
//  PersonalCapital
//
//  Created by Juan Balderas on 19/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCWebView.h"

@interface PCWebView ()
@property (nonatomic, strong, readwrite) WKWebView *webView;
@end

@implementation PCWebView

-(WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView new];
    }
    return _webView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self.webView addSubview:self.activityIndicator];
    [self addSubview:self.webView];

    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.webView.centerXAnchor] setActive:YES];
    [[self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.webView.centerYAnchor] setActive:YES];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.webView.frame = self.bounds;
}

@end
