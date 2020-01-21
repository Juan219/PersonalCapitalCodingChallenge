//
//  PCNetworkManager.h
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^APIResponseBlock)(BOOL succes, NSData * _Nullable data, NSError * _Nullable error);

@interface PCNetworkManager : PCBaseObject

- (void)performRequest:(NSURLRequest *)request response:(APIResponseBlock)response;

///Returns a URLRequest using base URL and appending the path.
- (NSMutableURLRequest *)GETRequestWithURLPath:(NSString*)path;

@end

NS_ASSUME_NONNULL_END
