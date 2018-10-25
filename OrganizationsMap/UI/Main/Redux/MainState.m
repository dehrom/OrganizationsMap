#import "MainState.h"

@implementation MainState
- (instancetype)init {
  if (self = [super init]) {
    _data = [NSMutableArray new];
    _mapItems = [NSMutableArray new];
  }
  return self;
}

#pragma mark - State

- (instancetype)initWithCoder:(NSCoder *)coder {
  if (self = [super init]) {
    _data = [coder decodeObjectOfClass:[NSArray class] forKey:@"data"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:self.data forKey:@"data"];
}
@end
