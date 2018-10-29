#import "MainState.h"

@implementation MainState
- (instancetype)init {
  if (self = [super init]) {
    _data = [NSMutableArray new];
    _mapItems = [NSMutableArray new];
  }
  return self;
}

- (id)copyWithZone:(nullable NSZone *)zone;
{
  __auto_type copyState = [MainState new];
  copyState.status = self.status;
  copyState.data = [self.data mutableCopy];
  copyState.mapItems = [self.mapItems mutableCopy];
  return copyState;
}

#pragma mark - State

- (instancetype)initWithCoder:(NSCoder *)coder {
  if (self = [super init]) {
    _data = [coder decodeObjectOfClass:[NSArray class] forKey:@"data"];
    _mapItems = [coder decodeObjectOfClass:[NSArray class] forKey:@"mapItem"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:self.data forKey:@"data"];
  [coder encodeObject:self.data forKey:@"mapItem"];
}
@end
