#import "MainState.h"

@implementation MainState
- (instancetype)init {
    if (self = [super init]) {
        _data = [NSArray new];
    }
    return self;
}

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
