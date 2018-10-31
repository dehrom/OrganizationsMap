#import "ListTableViewController.h"
#import <UIKit/UIViewController.h>
#import "Action.h"
#import "FetchAction.h"
#import "ListCellModel.h"
#import "ListOrganizationSelectAction.h"
#import "ListSectionModel.h"
#import "ListState.h"
#import "MainState.h"
#import "MainStore.h"
#import "StoreSubscriber.h"
#import "UIApplication+Accessor.h"

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
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [[[UIApplication sharedApplication] mainStore] subscribeWith:self
                                                stateSelectBlock:^id<State>(MainState *_Nonnull state) {
                                                  return state.listState;
                                                }];
}

#pragma mark - StoreSubscriber

- (void)newState:(ListState *)state {
    [self.refreshControl endRefreshing];
    switch (state.status) {
        case StateOrganizationLoadedSuccess:
            self.models = state.models;
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
            [self showError];
            break;
        default:
            break;
    }
}

#pragma mark - Private functions

- (void)refresh {
    [[[UIApplication sharedApplication] mainStore] dispatchAction:[FetchAction new]];
}

- (void)showError {
    __auto_type vc = [UIAlertController alertControllerWithTitle:nil
                                                         message:@"Ошибка отображения списка организаций"
                                                  preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:vc animated:YES completion:nil];
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
