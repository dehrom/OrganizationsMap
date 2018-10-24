#import "ListTableViewController.h"
#import "OrganizationCell.h"

@interface ListTableViewController ()

@end

@implementation ListTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:NSStringFromClass([OrganizationCell class])];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(
                                                       [OrganizationCell class])
                                      forIndexPath:indexPath];

  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
