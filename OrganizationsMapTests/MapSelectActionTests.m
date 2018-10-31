#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "FetchAction.h"
#import "MapSelectAction.h"
#import "ListFetchService_Local.h"
#import "UIApplication+Accessor.h"
#import "MainStore.h"
#import "MainState.h"
#import "StoreSubscriber.h"
#import "ListState.h"
#import "MapState.h"
#import "MockSubscriber.h"

@interface MapSelectActionTests : XCTestCase
@property (strong) MainStore *store;
@property (strong) FetchAction *fetchAction;
@property (strong, nonatomic) MapSelectAction *action;
@property (strong) MockSubscriber *subscriber;
@end

@implementation MapSelectActionTests
- (void)setUp {
    self.store = [[UIApplication sharedApplication] mainStore];
    self.fetchAction = [[FetchAction alloc] initWith:[ListFetchService_Local new]];
    self.action = [[MapSelectAction alloc] initWith:@"Google HQ"];
    self.subscriber = [MockSubscriber new];
}

- (void)testMapSelect {
    [self.store subscribeWith:self.subscriber stateSelectBlock:^id<State> _Nonnull(MainState * _Nonnull state) {
        return state.listState;
    }];
    [self.store dispatchAction:self.fetchAction];
    [self.store dispatchAction:self.action];
     __auto_type listState = (ListState *)self.subscriber.state;
    expect(listState.selectedOrganizationIndex).willNot.equal(-1);
}
@end
