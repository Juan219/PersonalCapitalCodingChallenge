//
//  PCBaseView.m
//  PersonalCapital
//
//  Created by Juan Balderas on 18/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCBaseView.h"

@interface PCBaseView ()
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicator;
@end

@implementation PCBaseView

-(UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    }
    return _activityIndicator;
}


@end
