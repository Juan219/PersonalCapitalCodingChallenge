#import "SceneDelegate.h"
#import "PCResearchViewController.h"
#import "PCArticlesAPIManager.h"
#import "PCNavigationController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {

    UIWindowScene *wScene = (UIWindowScene*)scene;

    if (scene != nil) {
        self.window = [[UIWindow alloc] initWithWindowScene:wScene];

        id<ArticlesAPIManager> apiManager = [[PCArticlesAPIManager alloc] init];
        PCResearchViewController *researchVC = [[PCResearchViewController alloc] initWithAPIManager:apiManager];

        PCNavigationController *navController = [[PCNavigationController alloc] initWithRootViewController:researchVC];

        self.window.rootViewController = navController;
        [self.window makeKeyAndVisible];
    }

}


@end
