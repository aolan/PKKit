//
//  PKMapViewController.h
//  Pods
//
//  Created by lawn.cao on 16/9/20.
//  Copyright © 2016年 lawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


/**
 *  显示点的类型
 */
typedef NS_ENUM(NSInteger, PKAnnotationType) {
    /**
     *  GPS原始轨迹点
     */
    PKAnnotationType_History_GPS = 0,
    /**
     *  算法推算的轨迹点
     */
    PKAnnotationType_History_Result = 1,
    /**
     *  GPS当前显示点
     */
    PKAnnotationType_Current_GPS = 2,
    /**
     *  算法推算的当前点
     */
    PKAnnotationType_Current_Result = 3
};



@interface PKMapViewController : UIViewController

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UILabel *debugLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *cancelButton;

// Override by subClass
- (void)start;
- (void)stop;
- (void)cancel;

// Invoke by subClass
- (void)addPoint:(CLLocationCoordinate2D)coordinate title:(NSString *)title type:(PKAnnotationType)type;


@end


#pragma mark - PKAnnotation

@interface PKAnnotation : MKPointAnnotation


/**
 *  显示点的类型
 */
@property (nonatomic, assign) PKAnnotationType type;


/**
 *  初始化点
 *
 *  @param coordinates 经纬度
 *  @param type        点的显示类型
 *  @param title       标题
 *  @param subTitle    子标题
 *
 *  @return 返回QXWZAnnotationType对象
 */
- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordinates
                               type:(PKAnnotationType)type
                              title:(NSString *)title
                           subTitle:(NSString *)subTitle;

@end

