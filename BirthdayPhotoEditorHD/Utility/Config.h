//
//  Config.h
//  ContactEyeLanse
//
//  Created by Toukir Naim on 12/26/17.
//  Copyright © 2017 Toukir Naim. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#define IS_IPHONE_X (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)812) < DBL_EPSILON)


#define UIColorFromRGB(rgbValue)\[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \blue:((float)(rgbValue & 0xFF))/255.0 \alpha:1.0]

#define RGB(r, g, b) \[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBE(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a) \[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//Apple app ID and IAP IDs
#define appleAppId @"1365753269"
#define appName @"Birthday Photo Frames Stickers"
#define SubAppName @"Birthday Design"
#define BundleId @"com.birthday.frame.hd"


#define AppWebID    @"1365753269"
#define StoreStatusWebLink @"http://1labgames.com/editorapps.html"

//admob
//#define admobBanner @""
//#define admobInterstital @""
#define admobBanner @"ca-app-pub-7420765399335412/9399781170"
#define admobInterstital @"ca-app-pub-7420765399335412/2076180141"

#define frequesncyTimer @"110"
#define packCount 6
#define appVersion @"1.0"
#define RateFileName @"rateCounter" appVersion

//MoreGameLink
#define moreAppLink @"https://itunes.apple.com/us/developer/shukla-debnath/id1194724416?l=es"
//#define moreAppLink @"http://itunes.apple.com/app/id" appleAppId
//#define rateLink @"http://itunes.apple.com/app/id" appleAppId
//#define rateLink @"itms-apps://itunes.apple.com/app/viewContentsUserReviews?id=" appleAppId
#define rateLink @"itms-apps://itunes.apple.com/gb/app/id" appleAppId "?action=write-review&mt=8"

//#define iapId_removeAds @"xmas.beard.id2.removeAdd"
//#define iapId_allPacks @"xmas.beard.id2.unlock_all_packs"
#define iapId_removeAds BundleId @".removeAdd"
#define iapId_waterMark BundleId @".removeMark"
#define iapId_allPacks BundleId @".unlock_all_packs"

#define iapId_pack2 BundleId @".pack2"
#define iapId_pack3 BundleId @".pack3"
#define iapId_pack4 BundleId @".pack4"
#define iapId_pack5 BundleId @".pack5"
#define iapId_pack6 BundleId @".pack6"

#define iapId_genericPack BundleId @".pack"

#define webSeriviceFileName @"WebServiceStatus"

//custom links
#define supportEmail @"contact@1labgames.com"
#define termsOfUseLink @"http://1labgames.com"

#define shortAppStoreLink @"http://itunes.apple.com/app/id" appleAppId

enum PurchaseIDType
{
    NoType,
    pack2,
    pack3,
    pack4,
    pack5,
    pack6,
    removeAd,
    removeMark,
    unlockAll
};

enum ApplovinAdStatus
{
    HideAd,
    ShowingAd
};

enum AdShowingType
{
    NoAd,
    ViewingAd
};

@interface Config : NSObject

@property (nonatomic,assign) enum PurchaseIDType purchaseIDType;
@property (nonatomic,assign) enum ApplovinAdStatus applovinAdStatus;
@property (nonatomic,assign) enum AdShowingType adShowingType;
+(Config *)sharedInstance;

@end
