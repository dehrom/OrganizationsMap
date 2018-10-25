#import <UIKit/UIKit.h>
#import "State.h"

@class ListCellModel;

NS_ASSUME_NONNULL_BEGIN

@interface MainState : NSObject <State>
@property(strong, nonatomic, nonnull) NSArray<ListCellModel *> *data;
@end

NS_ASSUME_NONNULL_END
