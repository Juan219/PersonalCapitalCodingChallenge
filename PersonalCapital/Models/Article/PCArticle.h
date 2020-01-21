//
//  PCArticle.h
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCArticle : PCBaseObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *imageURL;
@property (nonatomic, copy, readonly) NSString *desc;
@property (nonatomic, copy, readonly) NSString *publishDate;
@property (nonatomic, copy, readonly) NSString *linkURL;
@property (nonatomic, copy, readonly) NSURL *mobileLinkURL;

- (instancetype)initWithDetails:(NSDictionary *)details;


@end

NS_ASSUME_NONNULL_END
