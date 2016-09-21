//
//  PKMapViewController.m
//  Pods
//
//  Created by lawn.cao on 16/9/20.
//  Copyright © 2016年 lawn. All rights reserved.
//

#import "PKMapViewController.h"
#import "Masonry.h"
#import "CLLocation+PKExtension.h"

static double const kDefaultLatitude = 31.205542;
static double const kDefaultLongtitude = 121.467903;
static double const kDefaultZoomLevel = 14;

@interface PKMapViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) PKAnnotation *gpsAnnotation;
@property (nonatomic, strong) PKAnnotation *resultAnnotation;

@end

@implementation PKMapViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.debugLabel];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.stopButton];
    [self.view addSubview:self.cancelButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 200, 0));
    }];
    
    [self.debugLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mapView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view);
        make.width.mas_equalTo(@(100));
        make.height.mas_equalTo(@(20));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-30);
    }];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.top.mas_equalTo(self.statusLabel.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [self.stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.startButton.mas_trailing);
        make.top.mas_equalTo(self.statusLabel.mas_bottom);
        make.width.mas_equalTo(self.startButton.mas_width);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.stopButton.mas_trailing);
        make.trailing.mas_equalTo(self.view);
        make.width.mas_equalTo(self.stopButton.mas_width);
        make.top.mas_equalTo(self.statusLabel.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
}

// Override by subClass
- (void)start{}
- (void)stop{}
- (void)cancel{}

- (void)addPoint:(CLLocationCoordinate2D)coordinate title:(NSString *)title type:(PKAnnotationType)type{
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude].pk_mars;
    
    if (type == PKAnnotationType_Current_GPS) {
        if (_gpsAnnotation == nil) {
            _gpsAnnotation = [[PKAnnotation alloc] initWithCoordinates:location.coordinate
                                                                  type:type
                                                                 title:title
                                                              subTitle:@""];
            [self.mapView addAnnotation:_gpsAnnotation];
        }else{
            [_gpsAnnotation setCoordinate:location.coordinate];
        }
        return;
    }
    
    if (type == PKAnnotationType_Current_Result) {
        if (_resultAnnotation == nil) {
            _resultAnnotation = [[PKAnnotation alloc] initWithCoordinates:location.coordinate
                                                                     type:type
                                                                    title:title
                                                                 subTitle:@""];
            [self.mapView addAnnotation:_resultAnnotation];
        }else{
            [_resultAnnotation setCoordinate:location.coordinate];
        }
        return;
    }
    
    PKAnnotation *historyAnnotation = [[PKAnnotation alloc] initWithCoordinates:location.coordinate
                                                                           type:type
                                                                          title:title
                                                                       subTitle:@""];
    [self.mapView addAnnotation:historyAnnotation];
}


#pragma mark MKAnnotationViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"identifier"];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"identifier"];
        [annotationView setCanShowCallout:YES];
    }
    
    if ([annotation isKindOfClass:[PKAnnotation class]]) {
        PKAnnotation *anno = (PKAnnotation *)annotation;
        if (anno.type == PKAnnotationType_History_GPS) {
            annotationView.image = [UIImage imageNamed:@"QXWZBundle.bundle/Contents/Resources/QXWZAnnotationType_History_GPS"];
        }else if (anno.type == PKAnnotationType_History_Result){
            annotationView.image = [UIImage imageNamed:@"QXWZBundle.bundle/Contents/Resources/QXWZAnnotationType_History_Result"];
        }else if (anno.type == PKAnnotationType_Current_GPS){
            annotationView.image = [UIImage imageNamed:@"QXWZBundle.bundle/Contents/Resources/QXWZAnnotationType_Current_GPS"];
        }else{
            annotationView.image = [UIImage imageNamed:@"QXWZBundle.bundle/Contents/Resources/QXWZAnnotationType_Current_Result"];
        }
    }
    return annotationView;

}


#pragma mark  Property Methods

- (MKMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(kDefaultLatitude, kDefaultLongtitude);
    }
    return _mapView;
}

- (UILabel *)debugLabel{
    if (_debugLabel == nil) {
        _debugLabel = [[UILabel alloc] init];
        _debugLabel.numberOfLines = 0;
        _debugLabel.backgroundColor = [UIColor lightGrayColor];
        _debugLabel.font = [UIFont systemFontOfSize:9];
    }
    return _debugLabel;
}

- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.numberOfLines = 0;
        _statusLabel.font = [UIFont systemFontOfSize:10];
        _statusLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    }
    return _statusLabel;
}

- (UIButton *)startButton{
    if (_startButton == nil) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton.backgroundColor = [UIColor blueColor];
        [_startButton setTitle:@"开始" forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UIButton *)stopButton{
    if (_stopButton == nil) {
        _stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stopButton.backgroundColor = [UIColor blueColor];
        [_stopButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopButton;
}

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor blueColor];
        [_cancelButton setTitle:@"内存释放" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

@end


#pragma mark - PKAnnotation

@implementation PKAnnotation

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordinates
                               type:(PKAnnotationType)type
                              title:(NSString *)title
                           subTitle:(NSString *)subTitle{
    
    self = [super init];
    if (self) {
        self.coordinate = coordinates;
        self.title = title;
        self.subtitle = subTitle;
        self.type = type;
    }
    return self;
}

@end
