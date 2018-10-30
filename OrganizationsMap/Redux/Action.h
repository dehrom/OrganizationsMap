#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Action <NSObject>
@property (nonatomic, strong, readonly, nullable) id payload;

@optional
- (void)start;
@end

NS_ASSUME_NONNULL_END
