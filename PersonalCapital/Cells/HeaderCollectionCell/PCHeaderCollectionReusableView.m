//
//  PCHeaderCollectionReusableView.m
//  PersonalCapital
//
//  Created by Juan Balderas on 18/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCHeaderCollectionReusableView.h"

@interface PCHeaderCollectionReusableView ()
@property (nonatomic, strong) UIImageView *articleImage;
@property (nonatomic, strong) UILabel *articleTitle;
@property (nonatomic, strong) UILabel *articleDescription;

@property (nonatomic, strong, readwrite) PCArticle *article;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

#pragma mark - Static constants

static const CGFloat leftMargin = 8;
static const CGFloat rightMargin = 8;
static const CGFloat bottomMargin = 8;

@implementation PCHeaderCollectionReusableView

#pragma mark - Lazy load

-(UIImageView *)articleImage {
    if (!_articleImage) {
        _articleImage = [UIImageView new];
    }
    return _articleImage;
}

-(UILabel *)articleTitle {
    if (!_articleTitle) {
        _articleTitle = [UILabel new];
        _articleTitle.numberOfLines = 0;
        [_articleTitle setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium]];
        [_articleTitle setTextColor:[UIColor whiteColor]];
    }
    return _articleTitle;
}

-(UILabel *)articleDescription {
    if (!_articleDescription) {
        _articleDescription = [UILabel new];
        [_articleDescription setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightSemibold]];
        [_articleDescription setTextColor:[UIColor whiteColor]];
        _articleDescription.numberOfLines = 2;
    }
    return _articleDescription;
}

-(UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    }
    return _activityIndicator;
}

#pragma mark - Init methods

- (void)loadView {
    self.backgroundColor = [UIColor whiteColor];

    [self.articleImage addSubview:self.articleTitle];
    [self.articleImage addSubview:self.articleDescription];
    [self addSubview:self.activityIndicator];
    [self addSubview:self.articleImage];

    //Constraints
    [self.articleImage setTranslatesAutoresizingMaskIntoConstraints:NO];

    [[self.articleImage.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [[self.articleImage.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
    [[self.articleImage.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
    [[self.articleImage.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];

    //Description (Bottom)
    [self.articleDescription setTranslatesAutoresizingMaskIntoConstraints:NO];

    [[self.articleDescription.leftAnchor constraintEqualToAnchor:self.articleImage.leftAnchor constant:leftMargin] setActive:YES];
    [[self.articleDescription.rightAnchor constraintEqualToAnchor:self.articleImage.rightAnchor constant: -rightMargin] setActive:YES];
    [[self.articleDescription.bottomAnchor constraintEqualToAnchor:self.articleImage.bottomAnchor constant:-bottomMargin] setActive:YES];

    //Title
    [self.articleTitle setTranslatesAutoresizingMaskIntoConstraints:NO];

    [[self.articleTitle.leftAnchor constraintEqualToAnchor:self.articleDescription.leftAnchor] setActive:YES];
    [[self.articleTitle.rightAnchor constraintEqualToAnchor:self.articleDescription.rightAnchor] setActive:YES];
    [[self.articleTitle.bottomAnchor constraintEqualToAnchor:self.articleDescription.topAnchor constant:-bottomMargin] setActive:YES];

    //Animator
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.centerXAnchor] setActive:YES];
    [[self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.centerYAnchor] setActive:YES];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:tap];
}

-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self loadView];
}

- (void)didTap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapHeaderView:)]) {
        [self.delegate didTapHeaderView:self];
    }
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [self cleanUI];
}

- (BOOL)loadArticle:(PCArticle *)article {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self cleanUI];
        [self updateImageForArticle:article];

        self.articleDescription.text = article.desc;
        self.articleTitle.text = article.title;

        self.article = article;
    });

    return true;
}

- (void)cleanUI {
    self.articleImage.image = nil;
}

- (void)updateImageForArticle:(PCArticle *)article {
    if (article.imageURL != nil) {
        [self.activityIndicator startAnimating];
        __weak typeof(self) weakSelf = self;
        id iDelegate = self.delegate;
        if (iDelegate && [iDelegate respondsToSelector:@selector(imageFromURL:withID:completion:)]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                [iDelegate imageFromURL:article.imageURL withID:article.uuid completion:^(UIImage * _Nullable image, NSUUID * _Nonnull uuid) {
                    if (weakSelf && weakSelf.article.uuid == uuid) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            __strong typeof(weakSelf) strongSelf = weakSelf;
                            strongSelf.articleImage.image = image;
                            [strongSelf.activityIndicator stopAnimating];
                        });
                    }
                }];
            });
        }
    }
}

@end
