#import "MainViewController.h"
#import "FetchAction.h"
#import "Store.h"
#import "UIApplication+Accessor.h"

@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [[[UIApplication sharedApplication] mainStore] dispatchAction:[FetchAction new]];
}

@end
