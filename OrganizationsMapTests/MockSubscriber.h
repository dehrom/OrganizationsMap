#import <Foundation/Foundation.h>
#import "StoreSubscriber.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockSubscriber : NSObject <StoreSubscriber>
@property (strong) id<State> state;
@end

NS_ASSUME_NONNULL_END
