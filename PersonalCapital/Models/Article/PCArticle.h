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

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *imageURL;
@property (nonatomic, strong, readonly) NSString *desc;
@property (nonatomic, strong, readonly) NSString *publishDate;
@property (nonatomic, strong, readonly) NSString *linkURL;
@property (nonatomic, strong, readonly) NSURL *mobileLinkURL;

- (instancetype)initWithDetails:(NSDictionary *)details;


@end

NS_ASSUME_NONNULL_END
