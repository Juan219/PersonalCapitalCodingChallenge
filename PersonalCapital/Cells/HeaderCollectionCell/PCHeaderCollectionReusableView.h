//
//  PCHeaderCollectionReusableView.h
//  PersonalCapital
//
//  Created by Juan Balderas on 18/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCArticle.h"
#import "Protocols.h"

NS_ASSUME_NONNULL_BEGIN

@class PCHeaderCollectionReusableView;

@protocol PCHeaderCollectionViewProtocol <URLImageLoader>

- (void)didTapHeaderView:(PCHeaderCollectionReusableView *)headerView;

@end

@interface PCHeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic, weak) id<PCHeaderCollectionViewProtocol> delegate;

@property (nonatomic, strong, readonly) PCArticle *article;

- (BOOL)loadArticle:(PCArticle *)article;

@end

NS_ASSUME_NONNULL_END
