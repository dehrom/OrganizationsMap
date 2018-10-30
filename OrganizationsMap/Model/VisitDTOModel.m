#import "VisitDTOModel.h"
#import <Mantle/MTLValueTransformer.h>

@implementation VisitDTOModel
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return [super copyWithZone:zone];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"organizationId" : @"organizationId",
        @"title" : @"title",
        @"latitude" : @"latitude",
        @"longitude" : @"longitude",
    };
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionaryValue
                              error:(NSError *__autoreleasing *)error {
    return [super modelWithDictionary:dictionaryValue error:error];
}

+ (NSSet *)propertyKeys {
    NSArray<NSString *> *keys = [[self JSONKeyPathsByPropertyKey] allKeys];
    return [NSSet setWithArray:keys];
}

+ (NSValueTransformer *)organizationIdJSONTransformer {
    return [MTLValueTransformer
        transformerUsingForwardBlock:^NSNumber *(NSString *value, BOOL *success,
                                                 NSError *__autoreleasing *error) {
          return @(value.doubleValue);
        }];
}

+ (NSValueTransformer *)latitudeJSONTransformer {
    return [MTLValueTransformer
        transformerUsingForwardBlock:^NSNumber *(NSString *value, BOOL *success,
                                                 NSError *__autoreleasing *error) {
          return @(value.doubleValue);
        }];
}

+ (NSValueTransformer *)longitudeJSONTransformer {
    return [MTLValueTransformer
        transformerUsingForwardBlock:^NSNumber *(NSString *value, BOOL *success,
                                                 NSError *__autoreleasing *error) {
          return @(value.doubleValue);
        }];
}

- (BOOL)validate:(NSError *__autoreleasing *)error {
    return YES;
}
@end
