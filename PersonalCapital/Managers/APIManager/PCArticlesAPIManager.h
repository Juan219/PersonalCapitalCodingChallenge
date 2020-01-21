//
//  PCArticlesAPIManager.h
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PCNetworkManager.h"
#import "PCArticle.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ArticlesResponseBlock)(NSArray <PCArticle *> * articles);
typedef void (^ImageResponseBlock)(BOOL success, UIImage *image);

@protocol ArticlesAPIManager <NSObject>

- (void)getArticlesWithCompletionBlock:(ArticlesResponseBlock)completion;
- (void)getImageFromURLString:(NSString *)urlString completion:(ImageResponseBlock)block;

@end

@interface PCArticlesAPIManager : PCNetworkManager<ArticlesAPIManager>

@end

NS_ASSUME_NONNULL_END
