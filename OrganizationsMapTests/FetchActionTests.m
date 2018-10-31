#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "FetchAction.h"
#import "ListFetchService_Local.h"
#import "UIApplication+Accessor.h"
#import "MainStore.h"
#import "MainState.h"
#import "StoreSubscriber.h"
#import "ListState.h"
#import "MapState.h"
#import "MockSubscriber.h"

@interface FetchActionTests : XCTestCase
@property (strong) MainStore *store;
@property (strong, nonatomic) FetchAction *action;
@property (strong) MockSubscriber *subscriber;
@end

@implementation FetchActionTests
- (void)setUp {
    self.store = [[UIApplication sharedApplication] mainStore];
    self.action = [[FetchAction alloc] initWith:[ListFetchService_Local new]];
    self.subscriber = [MockSubscriber new];
}

- (void)tearDown {
    [self.store unsubscribeAll];
}

- (void)testFetchOrganizations {
    // when
    [self.store subscribeWith:self.subscriber stateSelectBlock:^id<State> _Nonnull(MainState * _Nonnull state) {
        return state.listState;
    }];
    [self.store dispatchAction:self.action];
    // then
    expect(self.subscriber.state).willNot.beNil();
}

- (void)testFetchMapItems {
    // when
    [self.store subscribeWith:self.subscriber stateSelectBlock:^id<State> _Nonnull(MainState * _Nonnull state) {
        return state.mapState;
    }];
    [self.store dispatchAction:self.action];
    // then
    expect(self.subscriber.state).willNot.beNil();
}
@end
