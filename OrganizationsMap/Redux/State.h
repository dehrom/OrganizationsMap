#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    StateNoChanges,
    StateVisitsLoadedSuccess,
    StateOrganizationLoadedSuccess,
    StateMapItemSelect,
    StateListItemSelect,
    StateFailure,
} StateStatus;

@protocol State
@property (assign, nonatomic, readonly) StateStatus status;
@end

NS_ASSUME_NONNULL_END
