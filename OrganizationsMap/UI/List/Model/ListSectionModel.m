#import "ListSectionModel.h"

@implementation ListSectionModel
- (instancetype)initWith:(int)organizationId
                   title:(NSString *)title
                  visits:(NSArray<NSString *> *)visits {
  if (self = [super init]) {
    _title = title;
    _organizationId = organizationId;
    _visits = [visits copy];
  }
  return self;
}
@end
