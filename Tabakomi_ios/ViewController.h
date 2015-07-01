//
//  ViewController.h
//  Tabakomi_ios
//
//  Created by 奥野遼 on 2015/07/01.
//  Copyright (c) 2015年 奥野遼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController<CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic)NSTimer *timer;


@end

