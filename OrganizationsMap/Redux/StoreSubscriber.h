#import <Foundation/Foundation.h>

@protocol State;

NS_ASSUME_NONNULL_BEGIN

@protocol StoreSubscriber <NSObject>
- (void)newState:(id<State>)state;
@end

NS_ASSUME_NONNULL_END
