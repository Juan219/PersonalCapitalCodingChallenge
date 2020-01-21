//
//  PCSingleHeaderCollectionViewFlowLayout.m
//  PersonalCapital
//
//  Created by Juan Balderas on 18/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCSingleHeaderCollectionViewFlowLayout.h"

const CGFloat minimumInheritSpacing = 8;
const CGFloat minimumLineSpacing = 8;
const CGFloat sectionInset = 8;
const CGFloat cellHeight = 150;

const NSInteger numberOfVerticalColumnsiPhone = 2;
const NSInteger numberOfHorizontalColumnsiPhone = 3;

const NSInteger numberOfVerticalColumnsiPad = 3;
const NSInteger numberOfHorizontalColumnsiPad = 4;

@interface PCSingleHeaderCollectionViewFlowLayout ()
@property (nonatomic, assign) NSInteger numberOfColumns;
@end

@implementation PCSingleHeaderCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(sectionInset, sectionInset, sectionInset, sectionInset);
    }
    return self;
}

- (CGSize)itemSize {
    return CGSizeMake((self.collectionView.frame.size.width - ((self.numberOfColumns + 1) * sectionInset)) / self.numberOfColumns, cellHeight);
}

-(CGFloat)minimumInteritemSpacing {
    return minimumInheritSpacing;
}

-(CGFloat)minimumLineSpacing {
    return minimumLineSpacing;
}

- (void)updateNumberOfColumns {
    UIDevice *device = [UIDevice currentDevice];
    UIDeviceOrientation orientation = device.orientation;
    BOOL isIpad = device.userInterfaceIdiom == UIUserInterfaceIdiomPad;

    BOOL isLandscape = UIDeviceOrientationIsLandscape(orientation);
    BOOL isPortrait = UIDeviceOrientationIsPortrait(orientation);


    if (orientation == UIDeviceOrientationUnknown || isPortrait) {
        if (isIpad) {
            self.numberOfColumns = numberOfVerticalColumnsiPad;
        } else {
            self.numberOfColumns = numberOfVerticalColumnsiPhone;
        }
    } else if (isLandscape) {
        if (isIpad) {
            self.numberOfColumns = numberOfHorizontalColumnsiPad;
        } else {
            self.numberOfColumns = numberOfHorizontalColumnsiPhone;
        }
    }
}

@end
