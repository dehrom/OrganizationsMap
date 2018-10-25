#import "FetchAction.h"
#import <ReactiveObjC.h>
#import "ListFetchService.h"

@interface FetchAction ()
@property(strong, nonatomic) ListFetchService *fetchService;
@end

@implementation FetchAction
@synthesize identifier;
@synthesize payload;

- (instancetype)init {
    if (self = [super init]) {
        identifier = NSStringFromClass([self class]);
        _fetchService = [ListFetchService new];
    }
    return self;
}

- (void)start {
    [[[[self.fetchService fetch] flattenMap:^__kindof RACSignal * _Nullable(NSArray<ListDTOModel *> * _Nullable value) {
        return [RACSignal return:@"res"];
    }] deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

@end
