#import <UIKit/UIKit.h>

@class MainStore;

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Accessor)
- (MainStore *)mainStore;
@end

NS_ASSUME_NONNULL_END
