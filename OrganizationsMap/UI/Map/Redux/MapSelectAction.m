#import "MapSelectAction.h"

@implementation MapSelectAction
@synthesize payload;

- (instancetype)initWith:(NSString *)organizationName {
  if (self = [super init]) {
    payload = organizationName;
  }
  return self;
}
@end
