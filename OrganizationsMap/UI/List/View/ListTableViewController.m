#import "ListTableViewController.h"
#import "FetchAction.h"
#import "OrganizationCell.h"
#import "Store.h"
#import "StoreSubscriber.h"
#import "UIApplication+Accessor.h"

@interface ListTableViewController () <StoreSubscriber>

@end

@implementation ListTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:NSStringFromClass([OrganizationCell class])];
  [[[UIApplication sharedApplication] mainStore] subscribeWith:self];
  [[[UIApplication sharedApplication] mainStore] dispatchAction:[FetchAction new]];
}

#pragma mark - StoreSubscriber

- (void)newState:(id<State>)state {
  NSLog(@"%@", state);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrganizationCell class])
                                      forIndexPath:indexPath];

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
