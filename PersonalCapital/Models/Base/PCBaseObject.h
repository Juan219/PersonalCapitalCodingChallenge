//
//  PCBaseObject.h
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PCBaseObject : NSObject

@property (nonatomic, strong, readonly) NSUUID *uuid;

@end

NS_ASSUME_NONNULL_END
