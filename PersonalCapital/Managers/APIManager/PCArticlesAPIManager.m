//
//  PCArticlesAPIManager.m
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCArticlesAPIManager.h"
#import "APIConstants.h"
#import "PCHTMLParser.h"
#import "PCXMLParserConstants.h"

@interface PCArticlesAPIManager()

@end

@implementation PCArticlesAPIManager

///Returns articles from Personal Capital
- (void)getArticlesWithCompletionBlock:(ArticlesResponseBlock)completion {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

        NSURLRequest *request = [self GETRequestWithURLPath:API_Articles];

        [self performRequest:request response:^(BOOL succes, NSData * _Nullable data, NSError * _Nullable error) {
            if (succes) {
                PCHTMLParser *parser = [[PCHTMLParser alloc] initWithNodeNames:@[article_item_node]];
                [parser parseFromData:data completionBlock:^(BOOL success, NSMutableDictionary * _Nullable nodes) {
                    NSMutableArray<PCArticle *> *articles = [[NSMutableArray alloc] initWithCapacity:nodes.count];
                    if (success) {
                        for (NSDictionary * articleInfo in nodes) {
                            @autoreleasepool {
                                PCArticle *article = [[PCArticle alloc] initWithDetails:articleInfo];
                                if (article) {
                                    [articles addObject:article];
                                }
                            }
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(success, [articles copy]);
                    });
                }];
            }
        }];
    });
}

- (void)getImageFromURLString:(NSString *)urlString andUUID:(NSUUID *)uuid completion:(ImageResponseBlock)block {
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:REQUEST_TIME_OUT];
    [self performRequest:imageRequest response:^(BOOL succes, NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *image;
        if (succes) {
            if (data != nil) {
                image = [UIImage imageWithData:data];
            }
        }
        block(succes, image, uuid);
    }];
}

@end
