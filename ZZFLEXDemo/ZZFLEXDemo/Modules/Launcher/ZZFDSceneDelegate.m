#import "ZZFDSceneDelegate.h"
#import "ZZFDMainViewController.h"

@implementation ZZFDSceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions
{
    if (![scene isKindOfClass:[UIWindowScene class]]) {
        return;
    }

    ZZFDMainViewController *mainVC = [[ZZFDMainViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    appearance.backgroundColor = [UIColor whiteColor];
    appearance.shadowImage = [UIImage new];
    navC.navigationBar.standardAppearance = appearance;
    navC.navigationBar.scrollEdgeAppearance = appearance;

    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    self.window.rootViewController = navC;
    [self.window makeKeyAndVisible];
}

@end
