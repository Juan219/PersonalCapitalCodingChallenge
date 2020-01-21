//
//  PCURLImageLoaderCollectionViewCell.h
//  PersonalCapital
//
//  Created by Juan Balderas on 18/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"

NS_ASSUME_NONNULL_BEGIN

///Base Cell with functionality for loading an image from a URL.
@interface PCURLImageLoaderCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak)id<URLImageLoader> delegate;

@end

NS_ASSUME_NONNULL_END
