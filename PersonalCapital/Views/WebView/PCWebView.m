//
//  PCWebView.m
//  PersonalCapital
//
//  Created by Juan Balderas on 19/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCWebView.h"

@implementation PCWebView

-(WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView new];
    }
    return _webView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self addSubview:self.webView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.webView.frame = self.bounds;
}

@end
