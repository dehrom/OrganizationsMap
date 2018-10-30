#import "ListTableViewController.h"
#import "ListCellModel.h"
#import "ListSectionModel.h"
#import "MainState.h"
#import "Store.h"
#import "StoreSubscriber.h"
#import "UIApplication+Accessor.h"
#import "ListOrganizationSelectAction.h"
#import "Action.h"

@interface ListTableViewController () <StoreSubscriber>
@property (strong, nonatomic, nonnull) NSArray<ListSectionModel *> *models;
@end

@implementation ListTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _models = [NSArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Events";
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [[[UIApplication sharedApplication] mainStore] subscribeWith:self];
}

#pragma mark - StoreSubscriber

- (void)newState:(MainState *)state {
    switch (state.status) {
        case StateLoading:
            NSLog(@"Loading");
            break;
        case StateOrganizationLoadedSuccess:
            self.models = state.data;
            [self.tableView reloadData];
            break;
        case StateMapItemSelect:
            [self.tableView
                scrollToRowAtIndexPath:
                    [NSIndexPath indexPathForRow:0
                                       inSection:state.selectedOrganizationIndex]
                      atScrollPosition:UITableViewScrollPositionTop
                              animated:YES];
            break;
        case StateFailure:
            NSLog(@"List Failure");
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView
    titleForHeaderInSection:(NSInteger)section {
    return self.models[section].title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return self.models[section].visits.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __auto_type *cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])
                                        forIndexPath:indexPath];
    cell.textLabel.text = self.models[indexPath.section].visits[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __auto_type organizationName = self.models[indexPath.section].title;
    __auto_type action = [[ListOrganizationSelectAction alloc] initWith:organizationName];
    [[[UIApplication sharedApplication] mainStore] dispatchAction:action];
}

@end
