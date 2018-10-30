#import <Foundation/Foundation.h>
#import "Action.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListOrganizationSelectAction : NSObject <Action>
- (instancetype)initWith:(NSString *)organizationName;
@end

NS_ASSUME_NONNULL_END
