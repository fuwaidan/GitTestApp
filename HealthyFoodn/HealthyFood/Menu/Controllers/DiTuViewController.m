//
//  DiTuViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "DiTuViewController.h"

#import "InterFace.h"
#import "MyTabbar.h"
#import "MyNavigationItem.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface DiTuViewController ()<BMKRouteSearchDelegate,BMKMapViewDelegate,UISearchBarDelegate,BMKPoiSearchDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate>
{
    UISearchBar *_searchBar;//搜索条
    
    BMKMapManager *_mapManager;
    BMKMapView *_mapView;
    NSInteger _permissionState;
    
    BMKLocationService *_locationService;//定位服务
    UIButton *_locationButton;//定位button
    
    BMKPoiSearch *_poiSearch;
    NSArray *_poiAnnotations;
    BMKRouteSearch *_routeSearch;
    
    CLLocationCoordinate2D _userLocationCoordinate2D;
}
@end

@implementation DiTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self loadMyNavigationBar];
    
    
    _permissionState=-1;
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager=[[BMKMapManager alloc]init];
    
    //com.qianfeng.findfood
    //17XB2kDhzyQCYI6HMveGq7kH
    // nUq8IkwQGVjeHH2vRn36nLcG
    
    // 如果要关注网络及授权验证事件，请设定 generalDelegate参数
    BOOL ret=[_mapManager start:@"2vPrANrK2QTKyx2yGBsxaDTE" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    //创建 BMKMapView
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenBounds.size.width, ScreenBounds.size.height-64)];
    
    _mapView.delegate=self;
    [self.view addSubview:_mapView];
    
    
    //搜索条
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, ScreenBounds.size.width, 40)];
    _searchBar.delegate=self;
    _searchBar.placeholder=@"搜饭店，小吃";
    // _searchBar.showsCancelButton=YES;//显示取消按钮
    
    [self.view bringSubviewToFront:_searchBar];
    
    [self.view addSubview:_searchBar];
    
    
    _locationButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _locationButton.frame=CGRectMake(0, ScreenBounds.size.height-80, 20, 20);
    [_locationButton setImage:[UIImage imageNamed:@"register_lbs@2x.png"] forState:UIControlStateNormal];
    [_locationButton addTarget:self action:@selector(beginLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_locationButton];
    
    
    _userLocationCoordinate2D=CLLocationCoordinate2DMake(39.915, 116.404);
}
#pragma mark - 导航条
-(void)loadMyNavigationBar
{
    MyNavigationItem *leftItem=[[MyNavigationItem alloc]init];
    leftItem.itemImageName=@"back@2x.png";
    [self createMyNavigationBarTitle:@"搜周边" andTitleView:nil andLeftItems:@[leftItem] andRightItems:nil andSEL:@selector(fanhuiBtn:) andClass:nil];
}

-(void)fanhuiBtn:(UIButton *)btn
{
    
    for (id obj in [self.tabBarController.view subviews])
    {
        if ([obj isKindOfClass:[MyTabbar class]])
        {
            ((MyTabbar *)obj).hidden=NO;
            
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *array = self.tabBarController.view.subviews;
    NSLog(@"%@",array);
    for (id obj in array) {
        if ([obj isKindOfClass:[UITabBar class]]) {
            ((UITabBar *)obj).hidden = YES;
        }
        else if ( [obj isKindOfClass:[MyTabbar class]]) {
            ((MyTabbar *)obj).hidden = YES;
        }
    }
    
    
    [_mapView viewWillAppear];
    _mapView.delegate=self;// 此处记得不用的时候需要置nil，否则影响内存的释放
    
    _locationService.delegate=self;
    
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate=nil;// 不用时，置nil
    _locationService.delegate=nil;
    
    _poiSearch.delegate=nil;
    
}

#pragma mark - 定位
-(void)beginLocation
{
    NSLog(@"普通定位");
    [_locationService startUserLocationService];
    _mapView.showsUserLocation=NO;//先关闭显示的定位图层
    _mapView.userTrackingMode=BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation=YES;//显示定位图层
    
}
//在地图View将要启动定位时，会调用此函数
-(void)willStartLocatingUser
{
    NSLog(@"start locate");
}
//用户方向更新后，会调用此函数
-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"head is %@",userLocation.heading);
}
//在地图View停止定位后，会调用此函数
-(void)didStopLocatingUser
{
    NSLog(@"stop location");
    
}
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"%f",userLocation.location.altitude);

}


-(void)onGetPermissionState:(int)iError
{
    NSLog(@"获取授权状态%d",iError);
    _permissionState=iError;
    if (iError==0) {
        
        //初始化poi检索对象
        _poiSearch=[[BMKPoiSearch alloc]init];
        _poiSearch.delegate=self;
        
        
        //路径规划 初始化
        _routeSearch=[[BMKRouteSearch alloc]init];
        _routeSearch.delegate=self;
        
        
    }
}

#pragma mark - searchBardelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",searchBar.text);
    //放弃第一响应者
    [searchBar resignFirstResponder];
    
    //发起检索
    BMKNearbySearchOption *option=[[BMKNearbySearchOption alloc]init];
    
    option.pageIndex=1;
    option.pageCapacity=10;
    option.location=CLLocationCoordinate2DMake(39.915, 116.404);
    option.keyword=searchBar.text;
    
    BOOL flag=[_poiSearch poiSearchNearBy:option];
    if (flag) {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    
}


//实现PoiSearchDeleage处理回调结果
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (errorCode==BMK_SEARCH_NO_ERROR)
    {
        //在此处理正常结果
        [self addPoisToMap:poiResult.poiInfoList];
        
    }
    else if (errorCode==BMK_SEARCH_AMBIGUOUS_KEYWORD)
    {
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        NSLog(@"起始点有歧义");
    }
    else
    {
        NSLog(@"抱歉,未找到结果");
    }
}
-(void)addPoisToMap:(NSArray  *)pois
{
    [_mapView removeAnnotations:_mapView.annotations];
    for (BMKPoiInfo *info in pois) {
        // 添加一个PointAnnotation
        BMKPointAnnotation *annotation=[[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude=info.pt.latitude;//纬度
        coor.longitude=info.pt.longitude;//经度
        annotation.coordinate=coor;
        annotation.title=info.name;
        [_mapView addAnnotation:annotation];
        
    }
    _poiAnnotations=_mapView.annotations;
    [_mapView showAnnotations:_poiAnnotations animated:YES];
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        //提供类似大头针效果的annotation view
        BMKPinAnnotationView *newAnnotationView=[[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor=BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop=YES;//设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

//com.qianfeng.findfood
//路径规划发起检索
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"%@",view.annotation.title);
    if ([_poiAnnotations containsObject:view.annotation])
    {
        //线路检索节点信息
        BMKPlanNode *start=[[BMKPlanNode alloc]init];
        //pt 节点坐标
        start.pt=_userLocationCoordinate2D;
        
        BMKPlanNode *end=[[BMKPlanNode alloc]init];
        end.pt=view.annotation.coordinate;
        //路线查询基础信息类
        BMKWalkingRoutePlanOption *walkingRouteSearchOption=[[BMKWalkingRoutePlanOption alloc]init];
        
        walkingRouteSearchOption.from=start;
        walkingRouteSearchOption.to=end;
        //步行路线检索
        bool flag=[_routeSearch walkingSearch:walkingRouteSearchOption];
        
        if (flag) {
            NSLog(@"walk 检索发送成功");
        }
        else
        {
            NSLog(@"walk 检索发送失败");
        }
        
    }
}

//实现delegate 处理回调结果
-(void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error==BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        if (result.routes.count>0) {
            BMKWalkingRouteLine *line=result.routes[0];
            [self showWalkingRoute:line];
            
        }
    }
    else if (error==BMK_SEARCH_AMBIGUOUS_ROURE_ADDR)
    {
        //当路线起终点有歧义时，获取建议检索起终点
        
    }
    else
    {
        NSLog(@"抱歉,未找到结果");
        
    }
}
-(void)showWalkingRoute:(BMKWalkingRouteLine *)line
{
    // 删除当前mapView中已经添加的Overlay数组
    [_mapView removeOverlays:_mapView.overlays];
    for (BMKPointAnnotation *annotation in _mapView.annotations) {
        // 当前地图View的已经添加的标注数组
        if (![_poiAnnotations containsObject:annotation]) {
            //移除标注
            [_mapView removeAnnotation:annotation];
        }
    }
    for (BMKWalkingStep *step in line.steps)
    {
        // 添加一个PointAnnotation
        BMKPointAnnotation *annotation=[[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        //路段入口信息
        coor.latitude=step.entrace.location.latitude;
        coor.longitude=step.entrace.location.longitude;
        //该点坐标
        annotation.coordinate=coor;
        //要显示的标题是该路段换成说明
        annotation.title=step.entraceInstruction;
        //像地图窗口添加标注
        [_mapView addAnnotation:annotation];
        
    }
    if (line.steps.count>0 && line.steps.count<500) {
        //添加折线覆盖物
        CLLocationCoordinate2D coors[500]={0};
        for (NSInteger i=0 ;i<line.steps.count;i++) {
            BMKWalkingStep *step=line.steps[i];
            coors[i].latitude=step.entrace.location.latitude;
            coors[i].longitude=step.entrace.location.longitude;
            
        }
        BMKPolyline *polyline=[BMKPolyline polylineWithCoordinates:coors count:line.steps.count];
        //向地图添加overlay,需要实现BMKMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View
        [_mapView addOverlay:polyline];
        
    }
    
}
/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polylineView=[[BMKPolylineView alloc]initWithOverlay:overlay];
        polylineView.strokeColor=[[UIColor purpleColor]colorWithAlphaComponent:1];
        polylineView.lineWidth=5.0;
        
        return polylineView;
    }
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
