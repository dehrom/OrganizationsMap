#import <UIKit/UIKit.h>

@class Store;

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Accessor)
- (Store *)mainStore;
@end

NS_ASSUME_NONNULL_END
