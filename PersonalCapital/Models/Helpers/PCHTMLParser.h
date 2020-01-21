//
//  PCHTMLParser.h
//  PersonalCapital
//
//  Created by Juan Balderas on 16/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCBaseObject.h"

@class PCHTMLParser;

typedef void (^HTMLParserCompletionBlock)(BOOL success, NSMutableDictionary * _Nullable nodes);

NS_ASSUME_NONNULL_BEGIN

@interface PCHTMLParser : PCBaseObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNodeNames:(NSArray *)nodeNames;

-(void)parseFromData:(NSData *)data completionBlock:(HTMLParserCompletionBlock)completion;


@end

NS_ASSUME_NONNULL_END
