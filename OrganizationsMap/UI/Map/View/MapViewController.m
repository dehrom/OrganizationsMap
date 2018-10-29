#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "MainState.h"
#import "Store.h"
#import "StoreSubscriber.h"
#import "UIApplication+Accessor.h"

@interface MapViewController () <StoreSubscriber, MKMapViewDelegate>
@property(strong, nonatomic) MKMapView *mapView;
@end

@implementation MapViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
  }
  return self;
}

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
      NSLog(@"Failure");
      break;
    default:
      break;
  }
}

#pragma mark - Private functions

- (void)configureMapWith:(NSArray<MKPointAnnotation *> *)points {
  [self.mapView addAnnotations:points];
  [self.mapView showAnnotations:points animated:YES];
    [self.mapView setCenterCoordinate:[points firstObject].coordinate animated:YES];
  __auto_type camera = [MKMapCamera cameraLookingAtCenterCoordinate:[points firstObject].coordinate
                                                       fromDistance:12000
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
}

@end
