//
//  AppDelegate.h
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/12/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//
@import GoogleMobileAds;
#import <UIKit/UIKit.h>
#import <AppLovinSDK/AppLovinSDK.h>
#import "PaymentManager.h"
#import "Config.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableData* responseData;
}

@property (strong, nonatomic) UIWindow *window;


@end

