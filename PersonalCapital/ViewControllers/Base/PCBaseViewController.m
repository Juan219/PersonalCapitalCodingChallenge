//
//  PCBaseViewController.m
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCBaseViewController.h"

@implementation PCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareView];
}

- (void)prepareView {
    //Override this method to provide own implementation for preparing your view.
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
