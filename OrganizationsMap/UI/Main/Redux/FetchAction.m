#import "FetchAction.h"
#import <ReactiveObjC.h>
#import "ListFetchService.h"
#import "MainStore.h"
#import "PresentListAction.h"
#import "UIApplication+Accessor.h"

@interface FetchAction ()
@property(nonatomic, strong, nullable) id payload;
@property(strong, nonatomic) ListFetchService *fetchService;
@property(strong, nonatomic) Store *store;
@end

@implementation FetchAction
@synthesize identifier;
@synthesize payload;

- (instancetype)init {
  if (self = [super init]) {
    identifier = NSStringFromClass([self class]);
    _store = [[UIApplication sharedApplication] mainStore];
    _fetchService = [ListFetchService new];
  }
  return self;
}

- (void)start {
  [[[[self.fetchService fetch]
      map:^NSArray<ListCellModel *> *_Nullable(NSArray<ListDTOModel *> *_Nullable value) {
        NSLog(@"%@", value);
        return @[];
      }] deliverOn:[RACScheduler mainThreadScheduler]]
      subscribeNext:^(NSArray<ListCellModel *> *_Nullable x) {
        [self.store dispatchAction:[[PresentListAction alloc] initWith:x]];
      }];
}

@end
