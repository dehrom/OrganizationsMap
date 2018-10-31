#import "AppDelegate.h"
#import "ListTableViewController.h"
#import "MapReducer.h"
#import "ListReducer.h"
#import "MainState.h"
#import "MainStore.h"
#import "MainViewController.h"
#import "MapViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.store = [[MainStore alloc] initWith:@[ [ListReducer new], [MapReducer new] ] state:[MainState new]];

    __auto_type controller = [[MainViewController alloc] init];
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
