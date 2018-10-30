#import "ListOrganizationSelectAction.h"

@implementation ListOrganizationSelectAction
@synthesize payload;

- (instancetype)initWith:(NSString *)organizationName {
    if (self = [super init]) {
        payload = organizationName;
    }
    return self;
}
@end
