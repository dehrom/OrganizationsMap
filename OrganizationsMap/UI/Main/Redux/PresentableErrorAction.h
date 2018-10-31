#import <Foundation/Foundation.h>
#import "Action.h"

NS_ASSUME_NONNULL_BEGIN

@interface PresentableErrorAction : NSObject <Action>
- (instancetype)initWith:(NSError *)error;
@end

NS_ASSUME_NONNULL_END
