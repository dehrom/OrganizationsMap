#import "PresentListAction.h"
#import "ListSectionModel.h"

@implementation PresentListAction
@synthesize payload;

- (instancetype)initWith:(NSArray<ListSectionModel *> *)models {
  if (self = [super init]) {
    payload = [models copy];
  }
  return self;
}
@end
