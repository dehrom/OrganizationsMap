#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Action <NSObject>
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly, nullable) id payload;
@end

NS_ASSUME_NONNULL_END
