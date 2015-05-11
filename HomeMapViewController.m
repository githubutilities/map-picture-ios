//
//  HomeMapViewController.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/20.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//


#import "HomeMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "CustomAnnotationView.h"
#import "MPAnnotation.h"
#import "NetWorkDAO.h"
#define APIKey  @"ba6a844ea700fd9372d74eac5ae7d528"


@interface HomeMapViewController ()<MAMapViewDelegate, AMapSearchDelegate,NetWorkDAODelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    UIButton *_locationButton;
    CLLocationManager * locationManager;
    
    NSArray *_pois;
    NSMutableArray *_annotations;
    NetWorkDAO *_DAO;
    NSArray *_detailArray;

}
@end

@implementation HomeMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bounds=[[UIScreen mainScreen] bounds];
    // Do any additional setup after loading the view, typically from a nib.
    [self initMapView];
    [self initSearch];
    [self initControls];
    
    _DAO= [[NetWorkDAO alloc]init];
    _DAO.delegate =self;
    _annotations = [NSMutableArray array];
}

- (void)initMapView
{
    [MAMapServices sharedServices].apiKey = APIKey;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    NSString *str = NSStringFromCGRect(self.view.frame);
    NSString *str2 = NSStringFromCGRect(self.view.bounds);
    NSString *str3 = NSStringFromCGRect(_mapView.bounds);
    NSString *str4 = NSStringFromCGRect(_mapView.frame);
    NSLog(@"self.view.frame = %@, slef.view.bounds = %@,mapviewBounds= %@ , mapviewFrame = %@",str,str2,str3,str4);
    
    _mapView.delegate = self;
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
}

- (void)initSearch
{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:APIKey Delegate:self];
}

- (void)initControls
{
    _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationButton.frame = CGRectMake(20, CGRectGetHeight(self.view.bounds) - 80, 40, 40);
    _locationButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    _locationButton.backgroundColor = [UIColor whiteColor];
    _locationButton.layer.cornerRadius = 5;
    [_locationButton addTarget:self action:@selector(locateAction) forControlEvents:UIControlEventTouchUpInside];
    [_locationButton setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    [_mapView addSubview:_locationButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds)- 60 , CGRectGetHeight(self.view.bounds) - 80, 40, 40);
    backButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    backButton.backgroundColor = [UIColor whiteColor];
    [backButton addTarget:self action:@selector(backToTableAction) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:backButton];
    
    
}

#pragma mark - Helpers selector

- (void)locateAction
{
    if (_mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
    [_DAO getDetail:@"ddd"];
   
}
//发起搜索请求
- (void)reGeoAction
{
    if (_currentLocation)
    {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        
        [_search AMapReGoecodeSearch:request];
    }
}
-(void)backToTableAction
{
    [self dismissViewControllerAnimated:NO completion:NULL];
}
#pragma mark - NetWorkDelegate
-(void)getDetailSuccessWithArray:(NSArray *)detailArray
{
    [_annotations removeAllObjects];
    [_mapView removeAnnotations:_annotations];
    _detailArray = detailArray;
    for (NSDictionary *dic in _detailArray) {
        MPAnnotation *annotation = [[MPAnnotation alloc]initWithItem:dic];
        [_annotations addObject:annotation];
    }
    NSLog(@"annotaions%@",_annotations);
    [_mapView addAnnotations:_annotations];
    
}


#pragma mark - AMapSearchDelegate
//搜索回调
- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"request :%@, error :%@", request, error);
}
//搜索回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSString *title = response.regeocode.addressComponent.city;
    if (title.length == 0)
    {
        title = response.regeocode.addressComponent.province;
    }
    
    _mapView.userLocation.title = title;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    
}

#pragma mark - MAMapViewDelegate
//定位模式改变调用该函数
- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    // 修改定位按钮状态
    if (mode == MAUserTrackingModeNone)
    {
        [_locationButton setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    }
    else
    {
        [_locationButton setImage:[UIImage imageNamed:@"location_yes"] forState:UIControlStateNormal];
    }
}
//回调点击标弹出的画面 ，获取当前经纬度
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //NSLog(@"userLocation: %@", userLocation.location);
    _currentLocation = [userLocation.location copy];
}
//在选k用户位置annotation时弹出当前地址
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    // 选中定位annotation的时候进行逆地理编码查询
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        [self reGeoAction];
    }
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"restaurant"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;

        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    
    return nil;
}

#pragma 函数

@end
