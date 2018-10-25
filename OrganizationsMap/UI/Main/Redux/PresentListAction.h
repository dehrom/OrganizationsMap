#import <Foundation/Foundation.h>
#import "Action.h"

@class ListCellModel;

NS_ASSUME_NONNULL_BEGIN

@interface PresentListAction : NSObject <Action>
@property(strong, nonatomic, nonnull, readonly) NSArray<ListCellModel *> *models;
- (instancetype)initWith:(NSArray<ListCellModel *> *)models;
@end

NS_ASSUME_NONNULL_END
