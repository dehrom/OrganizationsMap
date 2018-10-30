#import "AppDelegate.h"
#import "ListTableViewController.h"
#import "MainReducer.h"
#import "MainState.h"
#import "MainStore.h"
#import "MainViewController.h"
#import "MapViewController.h"
#import "Store.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    __auto_type controller = [[MainViewController alloc] init];
    self.store = [[MainStore alloc] initWith:[MainReducer new] state:[MainState new]];
    // controller.viewControllers = @ [[ListTableViewController new],
    // [UIViewController new]];
    controller.viewControllers = [self createPair];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSArray<UIViewController *> *)createPair {
    __auto_type first = [[UINavigationController alloc] initWithRootViewController:[ListTableViewController new]];
    __auto_type second = [[UINavigationController alloc] initWithRootViewController:[MapViewController new]];
    return @[ first, second ];
}

@end
