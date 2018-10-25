#import <Foundation/Foundation.h>
#import <ReactiveObjC/RACSignal.h>

@class ListDTOModel;

NS_ASSUME_NONNULL_BEGIN

@interface ListFetchService : NSObject
- (RACSignal<NSArray<ListDTOModel *> *> *)fetch;
@end

NS_ASSUME_NONNULL_END
