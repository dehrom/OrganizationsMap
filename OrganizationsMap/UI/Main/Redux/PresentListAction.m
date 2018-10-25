#import "PresentListAction.h"
#import "ListCellModel.h"

@interface PresentListAction ()
@property(strong, nonatomic, nonnull) NSArray<ListCellModel *> *models;
@end

@implementation PresentListAction
@synthesize identifier;
@synthesize payload;

- (instancetype)initWith:(NSArray<ListCellModel *> *)models {
  if (self = [super init]) {
    identifier = NSStringFromClass([self class]);
    _models = [models copy];
  }
  return self;
}
@end
