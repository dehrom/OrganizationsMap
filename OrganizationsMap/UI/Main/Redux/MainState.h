#import <UIKit/UIKit.h>
#import "State.h"

@class ListState;
@class MapState;

NS_ASSUME_NONNULL_BEGIN

@interface MainState : NSObject <State>
@property (strong, nonatomic, nonnull, readonly) ListState *listState;
@property (strong, nonatomic, nonnull, readonly) MapState *mapState;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new;
- (instancetype)initWithListState:(ListState *)listState MapState:(MapState *)mapState;
@end

NS_ASSUME_NONNULL_END
