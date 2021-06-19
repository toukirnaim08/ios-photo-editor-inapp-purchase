//
//  EditorViewController.h
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/12/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//
//@import GoogleMobileAds;
#import <UIKit/UIKit.h>
#import <AppLovinSDK/AppLovinSDK.h>
#import "MoreEditorViewController.h"
#import "Config.h"
#import "PaymentManager.h"
#import "ShopViewController.h"
#import "CLImageEditor.h"
#import "SVProgressHUD.h"

@interface EditorViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate,
ALAdLoadDelegate,ALAdDisplayDelegate,EditorViewProtocol,CLImageEditorDelegate, CLImageEditorTransitionDelegate, CLImageEditorThemeDelegate>
{
    BOOL isLoadForFirstTime;
    UIView *captureView;
    UIView *backView;
    
    UIView *pictureView;
    UIImageView *pictureImageView;
    
    UIView *frameView;
    UIImageView *frameImageView;
    
    UIView *tabBarView;
    UIButton *backButton;
    UIButton *frameButton;
    UIButton *borderButton;
    UIButton *filtersButton;
    UIButton *nextButton;
    
    UIPanGestureRecognizer* panRecognizer;
    UIRotationGestureRecognizer* rotationRecognizer;
    UIPinchGestureRecognizer* pinchRecognizer;
    
    CGFloat firstX;
    CGFloat firstY;
    CGFloat transitonY;
    CGFloat lastRotation;
    
    UIView *framesContainerView;
    UIView *framesContainerHeaderView;
    UIScrollView *framesContainerscrollView;
    
    UIView *borderContainerView;
    UIScrollView *borderContainerscrollView;
    
    
    UIView *leftOpenView;
    UIView *rightOpenView;
    UIView *upperOpenView;
    UIView *lowerOpenView;
    
    UILabel *upLabel;
    
    NSArray *tabItems;
    
    UIButton * removeAdButton;
    UIView *bannerViewBack;
    //GADBannerView *adMobBannerView;
    
    UIImage *currentImage;
    
    BOOL tipsViewStatus;
    UIView *tipsViewBlurBack;
    UIView *tipsView;
    UIButton *tipsCloseButton;
    
    BOOL isAShowFirstTime;
    
   
}
@property (nonatomic, strong) ALAd *ad;
//@property(nonatomic, strong) GADInterstitial *adInterstitial;
-(void)setImage:(UIImage*)image;

@end
