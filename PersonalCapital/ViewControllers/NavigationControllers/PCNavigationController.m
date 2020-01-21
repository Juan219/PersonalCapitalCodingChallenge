//
//  PCNavigationController.m
//  PersonalCapital
//
//  Created by Juan Balderas on 16/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCNavigationController.h"

@implementation PCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    self.navigationBar.prefersLargeTitles = YES;
    self.navigationBar.backgroundColor = [UIColor whiteColor];
}

@end
