#import <UIKit/UIKit.h>
#import "Action.h"
#import "ListFetchServiceProtocol.h"

@class ListFetchService;

NS_ASSUME_NONNULL_BEGIN

@interface FetchAction : NSObject <Action>
+ (instancetype)new;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWith:(id<ListFetchServiceProtocol>)service;
@end

NS_ASSUME_NONNULL_END
