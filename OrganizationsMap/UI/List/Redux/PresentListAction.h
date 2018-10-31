#import <Foundation/Foundation.h>
#import "Action.h"

@class ListSectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface PresentListAction : NSObject <Action>
- (instancetype)initWith:(NSArray<ListSectionModel *> *)models;
@end

NS_ASSUME_NONNULL_END
