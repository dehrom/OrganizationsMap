#import "UIApplication+Accessor.h"
#import "AppDelegate.h"

@implementation UIApplication (Accessor)
- (Store *)mainStore {
    return ((AppDelegate *)[[UIApplication sharedApplication] delegate]).store;
}
@end
