//
//  PCArticle.m
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCArticle.h"

#define sValue              @"value"
#define sAttributes         @"attributes"
#define sPersonalCapital    @"PersonalCapital"

#define sArticleTitle       @"title"
#define sArticleMedia       @"media:content"
#define sArticleMediaURL    @"url"
#define sArticleDesc        @"description"
#define sArticlePublishDate @"pubDate"
#define sArticleLink        @"link"

@interface PCArticle()

@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *imageURL;
@property (nonatomic, copy, readwrite) NSString *desc;
@property (nonatomic, copy, readwrite) NSString *publishDate;
@property (nonatomic, copy, readwrite) NSString *linkURL;

@end

static NSString * const urlComponentForMobile = @"?displayMobileNavigation=0";

@implementation PCArticle

- (instancetype)initWithDetails:(NSDictionary *)details {
    self = [self init];

    if (self != nil) {
        [self loadDetails:details];
    }

    return self;
}

- (void)loadDetails:(NSDictionary *)details {

    self.title          = [[details objectForKey:sArticleTitle] objectForKey:sValue];
    self.imageURL       = [[[details objectForKey:sArticleMedia] objectForKey:sAttributes] objectForKey:sArticleMediaURL];
    self.desc           = [[details objectForKey:sArticleDesc] objectForKey:sValue];
    self.publishDate    = [[details objectForKey:sArticlePublishDate] objectForKey:sValue];
    self.linkURL        = [[details objectForKey:sArticleLink] objectForKey:sValue];
}

- (NSURL *)mobileLinkURL {
    return [NSURL URLWithString:[self.linkURL stringByAppendingString:urlComponentForMobile]];
}

@end
