//
//  PCBaseViewController.h
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCBaseViewController : UIViewController

///This method will be called from viewDidLoad.
///Override this method to prepare your view
///like: set delegates, register cell for a TableView or Collection view etc.

-(void)prepareView;

@end
