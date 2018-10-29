#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "MainState.h"
#import "MapSelectAction.h"
#import "Store.h"
#import "StoreSubscriber.h"
#import "UIApplication+Accessor.h"

@interface MapViewController () <StoreSubscriber, MKMapViewDelegate>
@property(strong, nonatomic) MKMapView *mapView;
@end

@implementation MapViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Organizations";
  [self createViews];
  [self addSubviews];
  [[[UIApplication sharedApplication] mainStore] subscribeWith:self];
}

#pragma mark - StoreSubscriber

- (void)newState:(MainState *)state {
  switch (state.status) {
    case StateLoading:
      NSLog(@"Loading");
      break;
    case StateVisitsLoadedSuccess:
      [self configureMapWith:state.mapItems];
      break;
    case StateFailure:
      NSLog(@"Map Failure");
      break;
    default:
      break;
  }
}

#pragma mark - Private functions

- (void)configureMapWith:(NSArray<MKPointAnnotation *> *)points {
  [self.mapView addAnnotations:points];
  [self.mapView showAnnotations:points animated:YES];
  __auto_type camera = [MKMapCamera cameraLookingAtCenterCoordinate:[points firstObject].coordinate
                                                       fromDistance:0
                                                              pitch:0
                                                            heading:0];
  [self.mapView setCamera:camera animated:NO];
  CLLocationDistance regionRadius = 5000;
  __auto_type region = MKCoordinateRegionMakeWithDistance([points firstObject].coordinate,
                                                          regionRadius, regionRadius);
  [self.mapView setRegion:region animated:YES];
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
  [[[UIApplication sharedApplication] mainStore]
      dispatchAction:[[MapSelectAction alloc] initWith:view.annotation.title]];
}
@end
