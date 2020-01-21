//
//  PCWebViewController.h
//  PersonalCapital
//
//  Created by Juan Balderas on 19/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCWebViewController : PCBaseViewController

@property (nonatomic, strong, readonly) NSURL *url;

-(instancetype)initWithTitle:(NSString *)title andURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
