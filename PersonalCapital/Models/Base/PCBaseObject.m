//
//  PCBaseObject.m
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCBaseObject.h"

@interface PCBaseObject()
@property (nonatomic, strong, readwrite) NSUUID *uuid;
@end

@implementation PCBaseObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.uuid = [NSUUID UUID];
    }
    return self;
}

@end
