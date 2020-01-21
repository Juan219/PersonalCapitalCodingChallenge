//
//  PCResearchView.m
//  PersonalCapital
//
//  Created by Juan Balderas on 18/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCResearchView.h"
#import "PCSingleHeaderCollectionViewFlowLayout.h"

@interface PCResearchView ()
@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@property (nonatomic, strong, readwrite) PCSingleHeaderCollectionViewFlowLayout * collectionViewFlowLayout;
@end

@implementation PCResearchView

- (PCSingleHeaderCollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [PCSingleHeaderCollectionViewFlowLayout new];
        [_collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return _collectionViewFlowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]
                           initWithFrame:CGRectZero
                           collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        _collectionView.backgroundColor = [UIColor whiteColor];

    }
    return _collectionView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self.collectionView addSubview:self.activityIndicator];
    [self addSubview:self.collectionView];

    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.collectionView.centerYAnchor] setActive:YES];
    [[self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.collectionView.centerXAnchor] setActive:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionViewFlowLayout invalidateLayout];
    [self.collectionViewFlowLayout updateNumberOfColumns];
    self.collectionView.frame = self.bounds;
}

@end
