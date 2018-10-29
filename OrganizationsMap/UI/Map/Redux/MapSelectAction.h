#import <Foundation/Foundation.h>
#import "Action.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapSelectAction : NSObject <Action>
- (instancetype)initWith:(NSString *)organizationName;
@end

NS_ASSUME_NONNULL_END
