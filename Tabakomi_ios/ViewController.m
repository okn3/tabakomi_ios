//
//  ViewController.m
//  Tabakomi_ios
//
//  Created by 奥野遼 on 2015/07/01.
//  Copyright (c) 2015年 奥野遼. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *gps_view;
@property (weak, nonatomic) IBOutlet UILabel *gps_view2;
@end

@implementation ViewController
@synthesize locationManager;
double reacent_lat;
double reacent_lng;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //GPSの設定
    if (nil == locationManager){
        locationManager = [[CLLocationManager alloc] init];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            // NSLocationWhenInUseUsageDescriptionに設定したメッセージでユーザに確認
            //            [locationManager requestWhenInUseAuthorization];
            // NSLocationAlwaysUsageDescriptionに設定したメッセージでユーザに確認
            [locationManager requestAlwaysAuthorization];
        }
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; //誤差1
    locationManager.pausesLocationUpdatesAutomatically = NO; //15分以上でGPSログ停止を防ぐ
    //    locationManager.distanceFilter = kCLDistanceFilterNone; // 更新間隔
    [locationManager startUpdatingLocation];
    
    //適期的にGPSの情報を取得
    _timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(postGps:) userInfo:nil repeats:YES]; //テスト用60m

}

-(void)postGps:(NSTimer *)theTimer{
    
//    int user_id = 1;
    int count;
    count++;
//    
//    [postGPS sendRequestGPS:(NSString *)user_id
//                               data2:(float)reacent_lat
//                               data3:(float)reacent_lng]; //DBにデータ送信
    _gps_view2.text = [NSString stringWithFormat: @"定期的に呼び出されてます! %d",count];
    NSLog(@"定期的に呼び出されてます! %d",count);
    NSLog(@"(定期GPS) lat:%.6f,lng:%.6f", reacent_lat, reacent_lng);
    
}

// 常時GPS更新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation* location = [locations lastObject];
    
    reacent_lat = location.coordinate.latitude;
    reacent_lng = location.coordinate.longitude;

    _gps_view.text = [NSString stringWithFormat:@"lat: %.6f lng: %.6f", reacent_lat,reacent_lng];

    //    NSLog(@"speed----%@",speed_ary);
    //    NSLog(@" 緯度 %+.6f, 経度 %+.6f ,速度 %@ \n", location.coordinate.latitude, location.coordinate.longitude,reacent_speed);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
