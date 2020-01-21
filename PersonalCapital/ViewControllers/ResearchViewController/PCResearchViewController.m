//
//  PCResearchViewController.m
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCResearchViewController.h"
#import "LocalizableConstants.h"
#import "PCArticlesAPIManager.h"

//Main View
#import "PCResearchView.h"

//Additional views
#import "ImageTitleCollectionViewCell.h"
#import "PCHeaderCollectionReusableView.h"

//Navigation
#import "PCWebViewController.h"

@interface PCResearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PCHeaderCollectionViewProtocol>

@property (nonatomic, strong, readonly) PCResearchView *researchView;
@property (nonatomic, strong, readwrite) id<ArticlesAPIManager> apiManager;

@property (nonatomic, copy) NSArray<PCArticle *> *articles;
@property (nonatomic, strong) PCArticle * mainArticle;

@end

const NSInteger headerViewHeight = 300;

@implementation PCResearchViewController

#pragma mark - Lazy load.

- (PCResearchView *)researchView {
    return (PCResearchView *)self.view;
}

-(NSString *)title {
    return NSLocalizedString(title_research, @"");
}

#pragma mark - Life cycle

- (instancetype)initWithAPIManager:(id<ArticlesAPIManager>)apiManager {
    self = [super init];
    if (self) {
        self.apiManager = apiManager;
    }
    return self;
}

- (void)loadView {
    self.view = [[PCResearchView alloc] initWithFrame:UIScreen.mainScreen.bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)prepareView {
    [super prepareView];

    self.researchView.collectionView.delegate = self;
    self.researchView.collectionView.dataSource = self;

    [self.researchView.collectionView registerClass:[ImageTitleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ImageTitleCollectionViewCell class])];
    [self.researchView.collectionView registerClass:[PCHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([PCHeaderCollectionReusableView class])];

    //Adding Reload button
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = reloadButton;
}

- (void)refresh {
    [self.researchView.activityIndicator startAnimating];
    [self getArticles];
}

#pragma mark - API calls

- (void)getArticles {
    __weak __typeof(self) weakSelf = self;
    [self.apiManager getArticlesWithCompletionBlock:^(NSArray<PCArticle *> * _Nonnull articles) {
        if (weakSelf) {
            [self.researchView.activityIndicator stopAnimating];
            NSMutableArray *lArticles = [articles mutableCopy];
            weakSelf.mainArticle = [lArticles firstObject];
            [lArticles removeObjectAtIndex:0];
            weakSelf.articles = lArticles;
            [weakSelf.researchView.collectionView reloadData];
        }
    }];
}

#pragma mark - UICollectionView delegate & datasource

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ImageTitleCollectionViewCell *articleCell = (ImageTitleCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageTitleCollectionViewCell class]) forIndexPath:indexPath];
    articleCell.delegate = self;
    [articleCell loadArticle:self.articles[indexPath.row]];
    return articleCell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { 
    return [self.articles count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    PCHeaderCollectionReusableView *articleheader = (PCHeaderCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([PCHeaderCollectionReusableView class]) forIndexPath:indexPath];
    articleheader.delegate = self;
    [articleheader loadArticle:self.mainArticle];
    return articleheader;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.frame.size.width, headerViewHeight);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PCArticle *article = [self.articles objectAtIndex:indexPath.row];
    [self openWebViewForArticle:article];
}

#pragma mark - PCHeaderCollectionViewProtocol delegate method

- (void)didTapHeaderView:(nonnull PCHeaderCollectionReusableView *)headerView {
    [self openWebViewForArticle:headerView.article];
}

#pragma mark - URLImageLoader delegate method

- (void)imageFromURL:(NSString *)stringURL withID:(NSUUID *)uuid completion:(ImageBlock)block {
    [self.apiManager getImageFromURLString:stringURL completion:^(BOOL success, UIImage * _Nonnull image) {
        block(image);
    }];
}

#pragma mark - Helper methods

- (void)openWebViewForArticle:(PCArticle *)article {
    if (article.mobileLinkURL != nil) {
        PCWebViewController *webViewVC = [[PCWebViewController alloc] initWithTitle:article.title andURL:article.mobileLinkURL];
        [self.navigationController pushViewController:webViewVC animated:true];
    }
}


@end
