#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "FetchAction.h"
#import "ListOrganizationSelectAction.h"
#import "ListFetchService_Local.h"
#import "UIApplication+Accessor.h"
#import "MainStore.h"
#import "MainState.h"
#import "StoreSubscriber.h"
#import "MapState.h"
#import "MockSubscriber.h"

@interface ListOrganizationSelectActionTests : XCTestCase
@property (strong) MainStore *store;
@property (strong) FetchAction *fetchAction;
@property (strong) ListOrganizationSelectAction *action;
@property (strong) MockSubscriber *subscriber;
@end

@implementation ListOrganizationSelectActionTests
- (void)setUp {
    self.store = [[UIApplication sharedApplication] mainStore];
    self.fetchAction = [[FetchAction alloc] initWith:[ListFetchService_Local new]];
    self.action = [[ListOrganizationSelectAction alloc] initWith:@"Google HQ"];
    self.subscriber = [MockSubscriber new];
}

- (void)tearDown {
    [self.store unsubscribeAll];
}

- (void)testMapSelect {
    // when
    [self.store subscribeWith:self.subscriber stateSelectBlock:^id<State> _Nonnull(MainState * _Nonnull state) {
        return state.mapState;
    }];
    [self.store dispatchAction:self.fetchAction];
    [self.store dispatchAction:self.action];
    // then
    expect(((MapState *)self.subscriber.state).selectedOrganizationPoint).willNot.beNil();
}
@end
