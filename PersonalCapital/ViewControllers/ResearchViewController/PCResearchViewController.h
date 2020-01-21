//
//  PCResearchViewController.h
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCBaseViewController.h"
#import "PCArticlesAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCResearchViewController : PCBaseViewController

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithAPIManager:(id<ArticlesAPIManager>)apiManager;

@property (nonatomic, strong, readonly) id<ArticlesAPIManager> apiManager;

@end

NS_ASSUME_NONNULL_END
