//
//  PCWebView.h
//  PersonalCapital
//
//  Created by Juan Balderas on 19/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCBaseView.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PCWebView : PCBaseView
@property (nonatomic, strong) WKWebView *webView;
@end

NS_ASSUME_NONNULL_END
