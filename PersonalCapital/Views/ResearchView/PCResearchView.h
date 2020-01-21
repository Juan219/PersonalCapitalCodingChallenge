//
//  PCResearchView.h
//  PersonalCapital
//
//  Created by Juan Balderas on 18/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCResearchView : PCBaseView
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicator;
@end

NS_ASSUME_NONNULL_END
