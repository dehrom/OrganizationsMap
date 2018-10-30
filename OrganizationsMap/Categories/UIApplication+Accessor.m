#import "AppDelegate.h"
#import "UIApplication+Accessor.h"

@implementation UIApplication (Accessor)
- (Store *)mainStore {
    return ((AppDelegate *)[[UIApplication sharedApplication] delegate]).store;
}
@end
