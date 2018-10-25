#import "ListFetchService.h"
#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@implementation ListFetchService
- (RACSignal<NSArray<ListDTOModel *> *> *)fetch {
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        return [RACDisposable disposableWithBlock:^{}];
    }] subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]];
}
@end
