#import "MainState.h"
#import "ListState.h"
#import "MapState.h"

@implementation MainState
@synthesize status;

+ (instancetype)new {
    return [[MainState alloc] initWithListState:[ListState new] MapState:[MapState new]];
}

- (instancetype)initWithListState:(ListState *)listState MapState:(MapState *)mapState {
    if (self = [super init]) {
        _listState = listState;
        _mapState = mapState;
        status = StateNoChanges;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[MainState alloc] initWithListState:self.listState MapState:self.mapState];
}
@end
