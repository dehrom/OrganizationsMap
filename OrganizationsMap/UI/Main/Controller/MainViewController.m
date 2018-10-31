#import "MainViewController.h"
#import "FetchAction.h"
#import "MainStore.h"
#import "UIApplication+Accessor.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[UIApplication sharedApplication] mainStore] dispatchAction:[FetchAction new]];
}

@end
