//
//  Protocols.h
//  PersonalCapital
//
//  Created by Juan Balderas on 19/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#ifndef Protocols_h
#define Protocols_h

NS_ASSUME_NONNULL_BEGIN
typedef void (^ImageBlock)(UIImage * _Nullable image);

@protocol URLImageLoader <NSObject>

- (void)imageFromURL:(NSString *)stringURL withID:(NSUUID *)uuid completion:(ImageBlock)block;

@end
NS_ASSUME_NONNULL_END

#endif /* Protocols_h */
