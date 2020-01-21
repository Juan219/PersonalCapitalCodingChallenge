//
//  ImageTitleCollectionViewCell.h
//  PersonalCapital
//
//  Created by Juan Balderas on 16/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCURLImageLoaderCollectionViewCell.h"
#import "PCArticle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageTitleCollectionViewCell : PCURLImageLoaderCollectionViewCell 
- (BOOL)loadArticle:(PCArticle *)article;
@end

NS_ASSUME_NONNULL_END
