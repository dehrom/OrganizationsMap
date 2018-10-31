#import <Foundation/Foundation.h>
#import "Action.h"

@class MKPointAnnotation;

NS_ASSUME_NONNULL_BEGIN

@interface PresentMapAction : NSObject <Action>
- (instancetype)initWith:(NSArray<MKPointAnnotation *> *)points;
@end

NS_ASSUME_NONNULL_END
