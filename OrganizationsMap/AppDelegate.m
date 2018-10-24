#import "AppDelegate.h"
#import "MainViewController.h"
#import "Store.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  __auto_type controller = [[MainViewController alloc] init];
  controller.viewControllers =
      @ [[UIViewController new], [UIViewController new]];
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = controller;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
