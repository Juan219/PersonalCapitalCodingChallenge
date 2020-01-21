//
//  ImageTitleCollectionViewCell.m
//  PersonalCapital
//
//  Created by Juan Balderas on 16/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "ImageTitleCollectionViewCell.h"

@interface ImageTitleCollectionViewCell ()
@property (nonatomic, strong) UIImageView *articleImage;
@property (nonatomic, strong) UILabel *articleTitle;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) PCArticle *article;

@end

#pragma mark - Static constants

static const CGFloat leftMargin = 8;
static const CGFloat rightMargin = 8;

static const CGFloat imagePercentage = 0.75;

@implementation ImageTitleCollectionViewCell

-(UIImageView *)articleImage {
    if (!_articleImage) {
        _articleImage = [UIImageView new];
    }
    return _articleImage;
}

-(UILabel *)articleTitle {
    if (!_articleTitle) {
        _articleTitle = [UILabel new];
        _articleTitle.numberOfLines = 2;
        _articleTitle.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    }
    return _articleTitle;
}

-(UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        _activityIndicator.tintColor = [UIColor blueColor];
    }
    return _activityIndicator;
}

-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self loadView];
}

- (void)loadView {
    UIView *view = [self contentView];
    view.backgroundColor = [UIColor whiteColor];

    self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.masksToBounds = true;
    self.contentView.layer.cornerRadius = 5;

    [self.articleImage addSubview:self.activityIndicator];
    [view addSubview:self.articleImage];
    [view addSubview:self.articleTitle];

    //Image
    self.articleImage.translatesAutoresizingMaskIntoConstraints = false;
    [[self.articleImage.widthAnchor constraintEqualToConstant:view.frame.size.width] setActive:YES];
    [[self.articleImage.centerXAnchor constraintEqualToAnchor:view.centerXAnchor] setActive:YES];
    [[self.articleImage.topAnchor constraintEqualToAnchor:view.topAnchor constant:0] setActive:YES];
    [[self.articleImage.heightAnchor constraintEqualToAnchor:view.heightAnchor multiplier:imagePercentage constant:0] setActive:YES];

    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false;
    [[self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.articleImage.centerXAnchor] setActive:YES];
    [[self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.articleImage.centerYAnchor] setActive:YES];

    //Label
    self.articleTitle.translatesAutoresizingMaskIntoConstraints = false;
    [[self.articleTitle.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:leftMargin] setActive:YES];
    [[self.articleTitle.rightAnchor constraintEqualToAnchor:view.rightAnchor constant:-rightMargin] setActive:YES];
    [[self.articleTitle.topAnchor constraintEqualToAnchor:self.articleImage.bottomAnchor constant:0] setActive:YES];
    [[self.articleTitle.heightAnchor constraintEqualToAnchor:view.heightAnchor multiplier:1.0 - imagePercentage constant:0] setActive:YES];

    [[self.articleTitle.bottomAnchor constraintEqualToAnchor:view.bottomAnchor] setActive:YES];

}

- (BOOL)loadArticle:(PCArticle *)article {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self cleanUI];
        [self updateImageForArticle:article];

        self.article = article;
        self.articleTitle.text = self.article.title;
    });

    return true;
}

- (void)cleanUI {
    self.articleImage.image = nil;
}

- (void)updateImageForArticle:(PCArticle *)article {
    [self.activityIndicator startAnimating];
    if (article.imageURL != nil) {
        id iDelegate = self.delegate;
        __weak typeof(self) weakSelf = self;
        if (iDelegate != nil && [iDelegate respondsToSelector:@selector(imageFromURL:withID:completion:)]) {
            [iDelegate imageFromURL:article.imageURL withID:article.uuid completion:^(UIImage * _Nullable image, NSUUID * _Nonnull uuid) {
                if (weakSelf && weakSelf.article.uuid == uuid) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (weakSelf) {
                            __strong typeof(weakSelf) strongSelf = weakSelf;
                            strongSelf.articleImage.image = image;
                            [strongSelf.activityIndicator stopAnimating];
                        }
                    });
                }
            }];
        } else {
            [self.activityIndicator stopAnimating];
            NSLog(@"delegate doesn't conform to URLImageLoader protocol");
        }
    }
    else {
        [self.activityIndicator stopAnimating];
    }
}

@end
