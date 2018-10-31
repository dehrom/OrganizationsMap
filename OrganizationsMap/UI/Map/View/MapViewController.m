#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "MainState.h"
#import "MainStore.h"
#import "MapSelectAction.h"
#import "MapState.h"
#import "StoreSubscriber.h"
#import "UIApplication+Accessor.h"

@interface MapViewController () <StoreSubscriber, MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@end

@implementation MapViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Organizations";
    [self createViews];
    [self addSubviews];
    [[[UIApplication sharedApplication] mainStore] subscribeWith:self
                                                stateSelectBlock:^id<State>(MainState *_Nonnull state) {
                                                  return state.mapState;
                                                }];
}

#pragma mark - StoreSubscriber

- (void)newState:(MapState *)state {
    switch (state.status) {
        case StateVisitsLoadedSuccess:
            [self configureMapWith:state.models];
            break;
        case StateFailure:
            [self showError];
            break;
        case StateListItemSelect:
            [self selectAnnotation:state.selectedOrganizationPoint];
            break;
        default:
            break;
    }
}

#pragma mark - Private functions

- (void)showError {
    __auto_type vc = [UIAlertController alertControllerWithTitle:nil
                                                         message:@"Ошибка отображения карты"
                                                  preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)selectAnnotation:(MKPointAnnotation *)annotation {
    self.mapView.camera.centerCoordinate = annotation.coordinate;
    self.mapView.camera.altitude = 5000;
    self.mapView.camera.pitch = 0;
    self.mapView.camera.heading = 0;
    [self.mapView selectAnnotation:annotation animated:YES];
}

- (void)configureMapWith:(NSArray<MKPointAnnotation *> *)points {
    [self.mapView addAnnotations:points];
    [self.mapView showAnnotations:points animated:YES];
    __auto_type camera = [MKMapCamera cameraLookingAtCenterCoordinate:[points firstObject].coordinate
                                                         fromDistance:5000
                                                                pitch:0
                                                              heading:0];
    [self.mapView setCamera:camera animated:NO];
}

- (void)createViews {
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate = self;
}

- (void)addSubviews {
    [self.view addSubview:self.mapView];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    [[[UIApplication sharedApplication] mainStore] dispatchAction:[[MapSelectAction alloc] initWith:view.annotation.title]];
}
@end
