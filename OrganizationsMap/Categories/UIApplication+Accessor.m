#import "AppDelegate.h"
#import "MainStore.h"
#import "UIApplication+Accessor.h"

@implementation UIApplication (Accessor)
- (MainStore *)mainStore {
    return ((AppDelegate *)[[UIApplication sharedApplication] delegate]).store;
}
@end
