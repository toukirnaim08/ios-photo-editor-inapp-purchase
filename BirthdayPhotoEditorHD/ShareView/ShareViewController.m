//
//  ShareViewController.m
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/19/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController
//@synthesize adInterstitial;
- (void)viewDidLoad {
    isImageSaved = NO;
    [super viewDidLoad];
    [ShopViewController sharedInstance].shareViewDelegate = self;
    isAShowFirstTime = YES;
    self.view.backgroundColor = RGBE(216, 216, 216);
    [self setLowerView];
    [self setImageIntoPosition];
    [self setAdmobBanner];
    //[self setRateView];
    if(![[PaymentManager sharedInstance] isWaterMarkRemoved])
    {
        [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(onWaterMarkShakeTimerFired)
                                   userInfo:nil repeats:YES];
    }
    // Do any additional setup after loading the view.
}
-(void)setRateView
{
    rateBlurView = [[UIView alloc] init];
    rateBlurView.backgroundColor = [UIColor blackColor];
    rateBlurView.alpha = 0.3;
    rateBlurView.frame = self.view.bounds;
    [self.view addSubview:rateBlurView];
    
    rateView = [[UIView alloc] init];
    rateView.backgroundColor = [UIColor whiteColor];
    rateView.layer.cornerRadius = 10;
    rateView.layer.borderWidth = 2;
    rateView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:rateView];
    
    UILabel *rateViewLabel = [[UILabel alloc] init];
    rateViewLabel.text = @"If you like this APP please put a good review & 5 star";
    rateViewLabel.textColor = RGBE(75, 81, 115);
    rateViewLabel.textAlignment = NSTextAlignmentCenter;
    rateViewLabel.numberOfLines = 0;
    [rateView addSubview:rateViewLabel];
    
    UIImageView *rateViewImage = [[UIImageView alloc] init];
    rateViewImage.image = [UIImage imageNamed:@"Stars.png"];
    [rateView addSubview:rateViewImage];
    
    rateViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rateViewButton setImage:[UIImage imageNamed:@"transparent.png"] forState:UIControlStateNormal];
    [rateViewButton addTarget:self
                           action:@selector(rateViewButtonAction:)
                 forControlEvents:UIControlEventTouchUpInside];
    [rateView addSubview:rateViewButton];
    
    
    rateViewRateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //[galleryButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [rateViewRateButton setTitle:@"Review" forState:UIControlStateNormal];
    [rateViewRateButton.layer setCornerRadius:8];
    
    [rateViewRateButton addTarget:self action:@selector(rateViewRateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rateViewRateButton setBackgroundColor:RGBE(255, 200, 7)];
    
    [rateView addSubview:rateViewRateButton];
    
    rateViewCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[galleryButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [rateViewCancelButton setTitle:@"No :'(" forState:UIControlStateNormal];
    [rateViewCancelButton addTarget:self action:@selector(rateViewCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rateViewCancelButton setBackgroundColor:RGBE(255, 200, 7)];
    [rateViewCancelButton.layer setCornerRadius:8];
    
    [rateView addSubview:rateViewCancelButton];
    
    //rateView.hidden = YES;
    if(IS_IPAD)
    {
        rateViewRateButton.titleLabel.font = [UIFont systemFontOfSize:40];
        rateViewCancelButton.titleLabel.font = [UIFont systemFontOfSize:40];
        rateViewLabel.font = [UIFont fontWithName:@"Arial" size:30.0f];
        [rateViewRateButton.layer setCornerRadius:16];
        [rateViewCancelButton.layer setCornerRadius:16];
        
        rateView.frame = CGRectMake(self.view.frame.size.width/2 - 250,
                                    self.view.frame.size.height/2 - 175,
                                    500, 350);
        rateViewLabel.frame = CGRectMake(0,
                                         10,
                                         500, 100);
        rateViewImage.frame = CGRectMake(25,
                                         110,
                                         450, 150);
        rateViewButton.frame = CGRectMake(0,
                                          0,
                                          500, 270);
        rateViewRateButton.frame = CGRectMake(500/4 - 100,
                                              255,
                                              200, 80);
        rateViewCancelButton.frame = CGRectMake((3*500)/4 - 100,
                                                255,
                                                200, 80);
        
    }
    else
    {
        if(IS_IPHONE_X)
        {
            rateView.frame = CGRectMake(self.view.frame.size.width/2 - 150,
                                        self.view.frame.size.height/2 - 100,
                                        300, 200);
            rateViewLabel.frame = CGRectMake(0,
                                             10,
                                             300, 50);
            rateViewImage.frame = CGRectMake(25,
                                             60,
                                             250, 80);
            rateViewButton.frame = CGRectMake(0,
                                              0,
                                              300, 155);
            rateViewRateButton.frame = CGRectMake(300/4 - 50,
                                                  155,
                                                  100, 40);
            rateViewCancelButton.frame = CGRectMake((3*300)/4 - 50,
                                                    155,
                                                    100, 40);
        }
        else
        {
            rateView.frame = CGRectMake(self.view.frame.size.width/2 - 150,
                                        self.view.frame.size.height/2 - 100,
                                        300, 200);
            rateViewLabel.frame = CGRectMake(0,
                                             10,
                                             300, 50);
            rateViewImage.frame = CGRectMake(25,
                                             60,
                                             250, 80);
            rateViewButton.frame = CGRectMake(0,
                                                  0,
                                                  300, 155);
            rateViewRateButton.frame = CGRectMake(300/4 - 50,
                                                  155,
                                                  100, 40);
            rateViewCancelButton.frame = CGRectMake((3*300)/4 - 50,
                                                    155,
                                                    100, 40);
        }
    }
}
-(void)rateViewCancelButtonAction:(UIButton*)sender
{
    rateView.hidden = YES;
    rateBlurView.hidden = YES;
    [self doFinish];
}
-(void)rateViewRateButtonAction:(UIButton*)sender
{
    rateView.hidden = YES;
    rateBlurView.hidden = YES;
    [self saveToUserDefaults:@"yes"];
    [[UIApplication sharedApplication] openURL:[NSURL
                                                URLWithString:rateLink]];
}
-(void)rateViewButtonAction:(UIButton*)sender
{
    rateView.hidden = YES;
    rateBlurView.hidden = YES;
    [self saveToUserDefaults:@"yes"];
    [[UIApplication sharedApplication] openURL:[NSURL
                                                URLWithString:rateLink]];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(isAShowFirstTime)
    {
        isAShowFirstTime = NO;
        if(![[PaymentManager sharedInstance] isAdRemoved])
        {
            [self createAndLoadInterstitial];
        }
        [self setLowerViewVisible];
    }
}
- (void)createAndLoadInterstitial
{
    /*self.adInterstitial = [[GADInterstitial alloc] initWithAdUnitID:admobInterstital];
    self.adInterstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    request.testDevices = @[ @""];
    [self.adInterstitial loadRequest:request];*/
}
/*

-(void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
   [Config sharedInstance].adShowingType = NoAd;
}
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    [Config sharedInstance].adShowingType = NoAd;
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    if([Config sharedInstance].applovinAdStatus != ShowingAd)
    {
        [self.adInterstitial presentFromRootViewController:self];
        [Config sharedInstance].adShowingType = ViewingAd;
    }
}*/
-(void)setAdmobBanner
{
    /*if(![[PaymentManager sharedInstance] isAdRemoved])
    {
        
        removeAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //removeAdButton.frame = CGRectMake(self.view.frame.size.width-51, self.view.frame.size.height-146, 50, 25);
        [removeAdButton setImage:[UIImage imageNamed:@"RemoveAds.png"] forState:UIControlStateNormal];
        [removeAdButton addTarget:self action:@selector(removeAdButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (IS_IPAD)
        {
            removeAdButton.frame = CGRectMake(0,
                                              100,
                                              80, 40);
        }
        else
        {
            if(IS_IPHONE_X)
            {
                removeAdButton.frame = CGRectMake(0,
                                                  80,
                                                  40, 20);
            }
            else
            {
                removeAdButton.frame = CGRectMake(0,
                                                  50,
                                                  40, 20);
            }
            
        }
        // buttonRemoveAd.alpha = 5;
        [self.view addSubview:removeAdButton];
        [self shakeAnimation:removeAdButton];
        
        bannerViewBack = [[UIView alloc] init];
        
        [self.view addSubview:bannerViewBack];
        CGRect bannerFrame=CGRectMake(0, 0,
                                      self.view.bounds.size.width,
                                      50);
        
        if (IS_IPAD)
        {
            bannerViewBack.frame = CGRectMake(0, 0,
                                              self.view.bounds.size.width,
                                              100);
            bannerFrame=CGRectMake(0, 0,
                                   self.view.bounds.size.width,
                                   100);
        }
        else
        {
            if(IS_IPHONE_X)
            {
                bannerViewBack.frame = CGRectMake(0, 30,
                                                  self.view.bounds.size.width,
                                                  50);
                bannerFrame=CGRectMake(0, 0,
                                       self.view.bounds.size.width,
                                       50);
            }
            else
            {
                bannerViewBack.frame = CGRectMake(0, 0,
                                                  self.view.bounds.size.width,
                                                  50);
                bannerFrame=CGRectMake(0, 0,
                                       self.view.bounds.size.width,
                                       50);
            }
            
        }
        adMobBannerView =[[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        [bannerViewBack addSubview:adMobBannerView];
        bannerViewBack.clipsToBounds = YES;
        
        adMobBannerView.adUnitID = admobBanner;
        adMobBannerView.frame = bannerFrame;
        adMobBannerView.rootViewController = self;
        adMobBannerView.delegate=(id<GADBannerViewDelegate>)self;
        GADRequest *request = [GADRequest request];
        request.testDevices = @[kGADSimulatorID ];
        request.testDevices = @[ @"d5acc3fa1b33016ef8676e9036aeac9e"];
        [adMobBannerView loadRequest:request];
        [NSTimer scheduledTimerWithTimeInterval:2
                                         target:self
                                       selector:@selector(onShakeTimerFired)
                                       userInfo:nil repeats:YES];
    }*/
}
- (void)shareViewCompletePurchase:(NSString*)purchaseID
{
    if([purchaseID  isEqual: iapId_removeAds] || [purchaseID  isEqual: iapId_allPacks])
    {
        [removeAdButton removeFromSuperview];
        //[adMobBannerView removeFromSuperview];
        [bannerViewBack removeFromSuperview];
    }
    if([purchaseID  isEqual: iapId_waterMark] || [purchaseID  isEqual: iapId_allPacks])
    {
        [waterMarkButton removeFromSuperview];
        [waterMarkImageView removeFromSuperview];
    }
}
- (void)shareViewCompleteRestoring
{
    
}
-(void)removeAdButtonAction:(UIButton *)sender
{
    [Config sharedInstance].purchaseIDType = removeAd;
    ShopViewController * vc = [ShopViewController sharedInstance];
    //ShopViewController * vc = [[ShopViewController alloc] init];
    [vc setPackNumber];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)onShakeTimerFired
{
    
    if(![[PaymentManager sharedInstance] isAdRemoved])
    {
        [self shakeAnimation:removeAdButton];
    }
    
}
-(void)onWaterMarkShakeTimerFired
{
    if(![[PaymentManager sharedInstance] isWaterMarkRemoved])
    {
        [self shakeAnimation:waterMarkButton];
    }
}
-(void)shakeAnimation:(UIButton*) button
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:3];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(button.center.x - 5,button.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(button.center.x + 5, button.center.y)]];
    [button.layer addAnimation:shake forKey:@"position"];
}
-(void)setImageIntoPosition
{
    finalImageBackView = [[UIView alloc] init];
    finalImageBackView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:finalImageBackView];
    
    finalImageView = [[UIImageView alloc] init];
    
    finalImageView.contentMode = UIViewContentModeScaleAspectFill;
    finalImageView.image = finalImage;
    [finalImageBackView addSubview:finalImageView];
    
    CGFloat w  = finalImage.size.width;
    CGFloat h  = finalImage.size.height;
    
    waterMarkImageView = [[UIImageView alloc] init];
    waterMarkImageView.contentMode = UIViewContentModeScaleAspectFit;
    waterMarkImageView.image = [UIImage imageNamed:@"WaterMarImage.png"];
    waterMarkImageView.hidden = YES;
    waterMarkImageView.clipsToBounds = YES;
    
    waterMarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [waterMarkButton setImage:[UIImage imageNamed:@"WaterMarkButton.png"] forState:UIControlStateNormal];
    waterMarkButton.clipsToBounds = YES;
    [waterMarkButton addTarget:self
                     action:@selector(waterMarkButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    if(![[PaymentManager sharedInstance] isWaterMarkRemoved])
    {
        [finalImageBackView addSubview:waterMarkImageView];
        [finalImageBackView addSubview:waterMarkButton];
    }
    
    if(IS_IPAD)
    {
        [waterMarkImageView.layer setCornerRadius:5];
        [waterMarkButton.layer setCornerRadius:5];
        [finalImageView.layer setBorderWidth:6];
        [finalImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        finalImageBackView.frame = CGRectMake(180, 130,
                                              self.view.frame.size.width-360,
                                              self.view.frame.size.width-360);
        finalImageView.frame = CGRectMake(0, 0,
                                          self.view.frame.size.width-360,
                                          self.view.frame.size.width-360);
        waterMarkImageView.frame = CGRectMake(finalImageBackView.frame.size.width - 145,
                                              finalImageBackView.frame.size.height - 75,
                                              140,
                                              70);
        waterMarkButton.frame = CGRectMake(finalImageBackView.frame.size.width - 100
                                           , finalImageBackView.frame.size.height - 50,
                                           100,
                                           50);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            [waterMarkImageView.layer setCornerRadius:5];
            [waterMarkButton.layer setCornerRadius:5];
            finalImageBackView.frame = CGRectMake(10, 110,
                                                  self.view.frame.size.width-20,
                                                  self.view.frame.size.width-20);
            finalImageView.frame = CGRectMake(0, 0,
                                              self.view.frame.size.width-20,
                                              self.view.frame.size.width-20);
            waterMarkImageView.frame = CGRectMake(finalImageBackView.frame.size.width - 105,
                                                  finalImageBackView.frame.size.height - 55,
                                                  100,
                                                  50);
            waterMarkButton.frame = CGRectMake(finalImageBackView.frame.size.width - 80
                                               , finalImageBackView.frame.size.height - 40,
                                               80,
                                               40);
        }
        else
        {
            [waterMarkImageView.layer setCornerRadius:5];
            [waterMarkButton.layer setCornerRadius:5];
            finalImageBackView.frame = CGRectMake(10, 80,
                                                  self.view.frame.size.width-20,
                                                  self.view.frame.size.width-20);
            finalImageView.frame = CGRectMake(0, 0,
                                              self.view.frame.size.width-20,
                                              self.view.frame.size.width-20);
            waterMarkImageView.frame = CGRectMake(finalImageBackView.frame.size.width - 105,
                                                  finalImageBackView.frame.size.height - 55,
                                                  100,
                                                  50);
            waterMarkButton.frame = CGRectMake(finalImageBackView.frame.size.width - 80
                                               , finalImageBackView.frame.size.height - 40,
                                               80,
                                               40);
        }
    }
    
    
}
-(void)waterMarkButtonAction:(UIButton*)sender
{
    [Config sharedInstance].purchaseIDType = removeMark;
    ShopViewController * vc = [ShopViewController sharedInstance];
    //ShopViewController * vc = [[ShopViewController alloc] init];
    [vc setPackNumber];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)setImage:(UIImage*)image
{
    finalImage = image;
}
-(void)setLowerViewVisible
{
    [UIView animateWithDuration:0.9
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if(IS_IPAD)
                         {
                             tabBarView.frame = CGRectMake(0,
                                                           (self.view.frame.size.height*2)/3, self.view.frame.size.width, self.view.frame.size.height/3);
                         }
                         else
                         {
                             if(IS_IPHONE_X)
                             {
                                 tabBarView.frame = CGRectMake(0,
                                                               (self.view.frame.size.height*2)/3 - 15, self.view.frame.size.width, self.view.frame.size.height/3);
                             }
                             else
                             {
                                 tabBarView.frame = CGRectMake(0,
                                                               (self.view.frame.size.height*2)/3, self.view.frame.size.width, self.view.frame.size.height/3);
                             }
                         }
                         
                         
                     }completion:^(BOOL finished){
                         
                         
                     }];
}
-(void)setLowerView
{
    CGSize rect = self.view.frame.size;
    CGFloat rectWidth = rect.width;
    
    tabBarView = [[UIView alloc] init];
    
    tabBarView.layer.cornerRadius = 20;
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarView];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"Sback.png"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:backButton];
    
    saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setImage:[UIImage imageNamed:@"Ssave.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self
                   action:@selector(saveButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:saveButton];
    
    mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mailButton setImage:[UIImage imageNamed:@"Smail.png"] forState:UIControlStateNormal];
    [mailButton addTarget:self
                   action:@selector(mailButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:mailButton];
    
    fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [fbButton setImage:[UIImage imageNamed:@"Sfb.png"] forState:UIControlStateNormal];
    [fbButton addTarget:self
                      action:@selector(fbButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:fbButton];
    
    instaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [instaButton setImage:[UIImage imageNamed:@"Sinsta.png"] forState:UIControlStateNormal];
    [instaButton addTarget:self
                   action:@selector(instaButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:instaButton];
    
    twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [twitterButton setImage:[UIImage imageNamed:@"Stwitter.png"] forState:UIControlStateNormal];
    [twitterButton addTarget:self
                   action:@selector(twitterButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:twitterButton];
    
    
    finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[finishButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [finishButton setBackgroundColor:RGBE(255, 200, 7)];
    //[finishButton.layer setBorderWidth:10];
    
    [finishButton setTitle:@"Finish" forState:UIControlStateNormal];
    [finishButton addTarget:self
                    action:@selector(finishButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:finishButton];
    
    
    
    
    if(IS_IPAD)
    {
        [finishButton.layer setCornerRadius:20];
        finishButton.titleLabel.font = [UIFont systemFontOfSize:50];
        tabBarView.frame = CGRectMake(0,  self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/3);
        finishButton.frame = CGRectMake(tabBarView.frame.size.width/2 - 175
                                        , tabBarView.frame.size.height - 85,
                                        350,
                                        70);
        backButton.frame = CGRectMake(rectWidth/6 - 40,
                                      finishButton.frame.origin.y-200,
                                      80, 80);
        saveButton.frame = CGRectMake(backButton.frame.origin.x + rectWidth/3
                                      , finishButton.frame.origin.y-200,
                                      80, 80);
        mailButton.frame = CGRectMake(saveButton.frame.origin.x + rectWidth/3
                                      , finishButton.frame.origin.y-200,
                                      80, 80);
        fbButton.frame = CGRectMake(rectWidth/6 - 40
                                    , finishButton.frame.origin.y-100,
                                    80, 80);
        instaButton.frame = CGRectMake(fbButton.frame.origin.x + rectWidth/3
                                       , finishButton.frame.origin.y-100,
                                       80, 80);
        twitterButton.frame = CGRectMake(instaButton.frame.origin.x + rectWidth/3
                                         , finishButton.frame.origin.y-100,
                                         80, 80);
        
    }
    else
    {
        if(IS_IPHONE_X)
        {
            [finishButton.layer setCornerRadius:10];
            
            tabBarView.frame = CGRectMake(0,  self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/3);
            finishButton.frame = CGRectMake(tabBarView.frame.size.width/2 - 135
                                            , tabBarView.frame.size.height - 55,
                                            270,
                                            40);
            backButton.frame = CGRectMake(rectWidth/6 - 25,
                                          finishButton.frame.origin.y-150,
                                          50, 50);
            saveButton.frame = CGRectMake(backButton.frame.origin.x + rectWidth/3
                                          , finishButton.frame.origin.y-150,
                                          50, 50);
            mailButton.frame = CGRectMake(saveButton.frame.origin.x + rectWidth/3
                                          , finishButton.frame.origin.y-150,
                                          50, 50);
            fbButton.frame = CGRectMake(rectWidth/6 - 25
                                        , finishButton.frame.origin.y-80,
                                        50, 50);
            instaButton.frame = CGRectMake(fbButton.frame.origin.x + rectWidth/3
                                           , finishButton.frame.origin.y-80,
                                           50, 50);
            twitterButton.frame = CGRectMake(instaButton.frame.origin.x + rectWidth/3
                                             , finishButton.frame.origin.y-80,
                                             50, 50);
        }
        else
        {
            [finishButton.layer setCornerRadius:10];
            
            tabBarView.frame = CGRectMake(0,  self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/3);
            finishButton.frame = CGRectMake(tabBarView.frame.size.width/2 - 135
                                            , tabBarView.frame.size.height - 55,
                                            270,
                                            40);
            backButton.frame = CGRectMake(rectWidth/6 - 25,
                                          finishButton.frame.origin.y-150,
                                          50, 50);
            saveButton.frame = CGRectMake(backButton.frame.origin.x + rectWidth/3
                                          , finishButton.frame.origin.y-150,
                                          50, 50);
            mailButton.frame = CGRectMake(saveButton.frame.origin.x + rectWidth/3
                                          , finishButton.frame.origin.y-150,
                                          50, 50);
            fbButton.frame = CGRectMake(rectWidth/6 - 25
                                        , finishButton.frame.origin.y-80,
                                        50, 50);
            instaButton.frame = CGRectMake(fbButton.frame.origin.x + rectWidth/3
                                           , finishButton.frame.origin.y-80,
                                           50, 50);
            twitterButton.frame = CGRectMake(instaButton.frame.origin.x + rectWidth/3
                                             , finishButton.frame.origin.y-80,
                                             50, 50);
        }
    }
    
    
    
}
-(void) backButtonAction:(UIButton*) sender
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tabBarView.frame = CGRectMake(0,  self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/3);
                         
                     }completion:^(BOOL finished){
                         CATransition *transition = [[CATransition alloc] init];
                         transition.duration = 0.9;
                         transition.type = kCATransitionPush;
                         transition.subtype = kCATransitionFade;
                         [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                         [self.view.window.layer addAnimation:transition forKey:kCATransition];
                         [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                         
                     }];
    
    
    
}
-(void) fbButtonAction:(UIButton*) sender
{
    [self doFacebookShare];
}
-(void) instaButtonAction:(UIButton*) sender
{
    [self doInstagramShare];
}
-(void) twitterButtonAction:(UIButton*) sender
{
    [self doTwitterShare];
}
-(void) saveButtonAction:(UIButton*) sender
{
    waterMarkButton.hidden = YES;
    waterMarkImageView.hidden = NO;
    UIGraphicsBeginImageContextWithOptions(finalImageBackView.frame.size,
                                           YES,0.0f);
    //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
    [[finalImageBackView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(outputImage, nil, nil, nil);
    waterMarkButton.hidden = NO;
    waterMarkImageView.hidden = YES;
    finalImage =outputImage;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved Successfully"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil,nil];
    alert.tag=1001;
    
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag != 1001)
        return;
    NSLog(@"alertviewtag %ld",(long)alertView.tag);
    if (buttonIndex == 0)
    {
        if([self isAppIDOnWeb] == YES)
        {
            if([self isGettingRateAlert] == YES)
            {
                [self showCustomAlertView];
            }
        }
    }
    else if(buttonIndex == 1)
    {
        //Some Implementation
    }
}
-(void) finishButtonAction:(UIButton*) sender
{
    if([self isAppIDOnWeb] == YES)
    {
        
        if([self isGettingRateAlert] == YES)
        {
            [self setRateView];
        }
        else if([self isGettingRateAlert] == NO)
        {
            [self doFinish];
        }
    }
    else if([self isAppIDOnWeb] == NO)
    {
        [self doFinish];
    }
    //[self doFinish];
    
}
-(void)mailButtonAction:(UIButton*)sender
{
    [self doMailShare];
}
-(BOOL)isAppIDOnWeb
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:webSeriviceFileName];
    
    if(savedValue == nil || [savedValue isEqualToString:@"no"])
    {
        return NO;
        
    }
    if([savedValue isEqualToString:@"yes"])
    {
        return YES;
        
    }
    return NO;
}
-(void)saveToUserDefaults:(NSString*)myString
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myString forKey:RateFileName];
        [standardUserDefaults synchronize];
    }
}
-(BOOL)isGettingRateAlert
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:RateFileName];
    
    
    if(savedValue == nil || [savedValue isEqualToString:@"no"])
    {
        return YES;
        
    }
    if([savedValue isEqualToString:@"yes"] || [savedValue isEqualToString:@"done"])
    {
        return NO;
        
    }
    return NO;
}
-(void)doFinish
{
    [self saveImageToFile];
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tabBarView.frame = CGRectMake(0,  self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/3);
                         
                     }completion:^(BOOL finished){
                         ViewController * vc = [[ViewController alloc] init];
                         //[vc setImage:finalImage];
                         
                         CATransition *transition = [[CATransition alloc] init];
                         transition.duration = 0.5;
                         transition.type = kCATransitionPush;
                         transition.subtype = kCATransitionReveal;
                         [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                         [self.view.window.layer addAnimation:transition forKey:kCATransition];
                         [self presentViewController:vc animated:false completion:nil];
                         
                     }];
}
-(void)saveImageToFile
{
    waterMarkButton.hidden = YES;
    waterMarkImageView.hidden = NO;
    UIGraphicsBeginImageContextWithOptions(finalImageBackView.frame.size,
                                           YES,0.0f);
    //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
    [[finalImageBackView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(outputImage, nil, nil, nil);
    waterMarkButton.hidden = NO;
    waterMarkImageView.hidden = YES;
    
    
    UIImage *ttets = outputImage;
    finalImage =outputImage;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //2) Create the full file path by appending the desired file name
    NSString *notificationListFilePath = [documentsDirectory stringByAppendingPathComponent:@"notifications.arr"];
    
    //Load the array
    NSMutableArray *notificationList = [[NSMutableArray alloc] initWithContentsOfFile: notificationListFilePath];
    NSInteger arrayCount = notificationList.count;
    if(notificationList == nil)
    {
        notificationList = [[NSMutableArray alloc] init];
        notificationList[arrayCount] = [NSString stringWithFormat:
                                        @"Image%ld.jpg",(unsigned long)arrayCount];
    }
    else
    {
        notificationList[arrayCount] = [NSString stringWithFormat:
                                        @"Image%ld.jpg",(unsigned long)arrayCount];
    }
    [notificationList writeToFile:notificationListFilePath atomically:YES];
    if(finalImage != nil)
    {
        NSString *imageFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:
                                   [NSString stringWithFormat:@"Image%ld.jpg",(long)arrayCount]];
        
        // Save image.
        UIImage *tempImageFromURL = finalImage;
        
        [UIImagePNGRepresentation(tempImageFromURL) writeToFile:imageFilePath atomically:YES];
    }
}
-(void)doInstagramShare
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
    
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        waterMarkButton.hidden = YES;
        waterMarkImageView.hidden = NO;
        UIGraphicsBeginImageContextWithOptions(finalImageBackView.frame.size,
                                               YES,0.0f);
        //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
        [[finalImageBackView layer] renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        waterMarkButton.hidden = NO;
        waterMarkImageView.hidden = YES;
        
        NSURL *url;
        docFile.delegate = self;
        UIImage *tempImage;
        if([[PaymentManager sharedInstance] isWaterMarkRemoved])
            tempImage = finalImage;
        else
            tempImage = outputImage;
        
        
        
        //Hook it with Instagram
        NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Image.igo"];
        [UIImageJPEGRepresentation(tempImage, 1.0) writeToFile:jpgPath atomically:YES];
        
        
        
        url = [[NSURL alloc] initFileURLWithPath:jpgPath];
        docFile = [UIDocumentInteractionController interactionControllerWithURL:url];
        [docFile setUTI:@"com.instagram.photo"];
        docFile.annotation = @{@"InstagramCaption" : @" #Toive" };
        
        
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
            
            [docFile presentOpenInMenuFromRect:CGRectMake(350, 840, 320, 480) inView:self.view animated:YES];
            
        } else {
            
            [docFile presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
            
        }
        
    }else
    {
        
        UIAlertView *errorToShare = [[UIAlertView alloc] initWithTitle:@"Instagram unavailable " message:@"You need to install Instagram" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [errorToShare show];
        
    }
}
-(void)doFacebookShare
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]])
    {
        waterMarkButton.hidden = YES;
        waterMarkImageView.hidden = NO;
        UIGraphicsBeginImageContextWithOptions(finalImageBackView.frame.size,
                                               YES,0.0f);
        //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
        [[finalImageBackView layer] renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        waterMarkButton.hidden = NO;
        waterMarkImageView.hidden = YES;
        
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //  NSString *str=[NSString stringWithFormat:@"%@   \n Author : %@",textview1.text,author.text];
        //  [controller setInitialText:str];
        
        //[controller addURL:[NSURL URLWithString:rateLink]];
        //[controller setInitialText:appleName];
        if([[PaymentManager sharedInstance] isWaterMarkRemoved])
            [controller addImage:finalImage];
        else
            [controller addImage:outputImage];
        //[controller addImage:self.tempImage];
        [controller setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case 0:
                {
                SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    if([self isAppIDOnWeb] == YES)
                    {
                        if([self isGettingRateAlert] == YES)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                            [self showCustomAlertView];
                                });
                        }
                    }
                    break;
                }
                case 1:
                {
                    
                SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    if([self isAppIDOnWeb] == YES)
                    {
                        if([self isGettingRateAlert] == YES)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self showCustomAlertView];
                            });
                        }
                    }
                    break;
                }
                    
                default:
                    break;
                    
            }
            
        }];
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Facebook Account"
                                                        message:@"go to setting and set account"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil,nil];
        alert.tag=1;
        
        [alert show];
        
        
    }
    
}
-(void)doTwitterShare
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
        // Facebook app is installed
        waterMarkButton.hidden = YES;
        waterMarkImageView.hidden = NO;
        UIGraphicsBeginImageContextWithOptions(finalImageBackView.frame.size,
                                               YES,0.0f);
        //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
        [[finalImageBackView layer] renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        waterMarkButton.hidden = NO;
        waterMarkImageView.hidden = YES;
        
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        //  NSString *str=[NSString stringWithFormat:@"%@   \n Author : %@",textview1.text,author.text];
        //  [tweetSheet setInitialText:str];
        if([[PaymentManager sharedInstance] isWaterMarkRemoved])
            [tweetSheet addImage:finalImage];
        else
            [tweetSheet addImage:outputImage];
        //[tweetSheet addImage:finalImage];
        //[self presentViewController:tweetSheet animated:YES completion:nil];
        
        [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case 0:
                {
                SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    if([self isAppIDOnWeb] == YES)
                    {
                        if([self isGettingRateAlert] == YES)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self showCustomAlertView];
                            });
                        }
                    }
                    break;
                }
                case 1:
                {
                    
                SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    if([self isAppIDOnWeb] == YES)
                    {
                        if([self isGettingRateAlert] == YES)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self showCustomAlertView];
                            });
                        }
                    }
                    break;
                }
                    
                default:
                    break;
                    
            }
            
        }];
        
        [self presentViewController:tweetSheet animated:YES completion:^{
            NSLog(@"Tweet sheet has been presented.");
        }];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Account"
                                                        message:@"go to setting and set account"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil,nil];
        alert.tag=2;
        
        [alert show];
        
    }
    
}
-(void)doMailShare
{
    if ([MFMailComposeViewController canSendMail])
    {
        waterMarkButton.hidden = YES;
        waterMarkImageView.hidden = NO;
        UIGraphicsBeginImageContextWithOptions(finalImageBackView.frame.size,
                                               YES,0.0f);
        //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
        [[finalImageBackView layer] renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        waterMarkButton.hidden = NO;
        waterMarkImageView.hidden = YES;
        
        NSString *emailTitle = appName;
        NSString *messageBody = [NSString stringWithFormat:@"Hey, check this out! %@",shortAppStoreLink];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        
        // Determine the file name and extension
        NSData *myData;
        // Get the resource path and read the file using NSData
        if([[PaymentManager sharedInstance] isWaterMarkRemoved])
            myData = UIImagePNGRepresentation(finalImage);
        else
            myData = UIImagePNGRepresentation(outputImage);
        
        
        // Determine the MIME type
        NSString *mimeType;
        mimeType = @"image/png";
        
        // Add attachment
        [mc addAttachmentData:myData mimeType:mimeType fileName:@"Photo.png"];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No email Account"
                                                        message:@"go to setting and set account"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil,nil];
        alert.tag=2;
        
        [alert show];
        
    }
    
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:^
     {
         if([self isAppIDOnWeb] == YES)
         {
             if([self isGettingRateAlert] == YES)
             {
                 [self showCustomAlertView];
             }
         }
     }];
}
-(void)showCustomAlertView
{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    //alertViewController.title = NSLocalizedString(@"Wanna Save & Share", nil);
    //alertViewController.message = NSLocalizedString(@"If you want to Save & Share please Rate us a 5 star & a good Review", nil);
    
    alertViewController.title = @"Hi!!";
    alertViewController.message = @"If you like this APP please put a good review & 5 star";
    
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0f];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.messageColor = [UIColor colorWithWhite:0.92f alpha:1.0f];
    
    alertViewController.buttonColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.buttonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.cancelButtonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    NYAlertAction *okButton = [NYAlertAction actionWithTitle:@"Review :D"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(NYAlertAction *action) {
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                         [self saveToUserDefaults:@"yes"];
                                                         [[UIApplication sharedApplication] openURL:[NSURL
                                                                                                     URLWithString:rateLink]];
                                                     }];
    
    /*[alertViewController addAction:[NYAlertAction actionWithTitle:@"Rate & Review :D"
     style:UIAlertActionStyleDefault
     handler:^(NYAlertAction *action) {
     [self dismissViewControllerAnimated:YES completion:nil];
     [self saveToUserDefaults:@"yes"];
     [[UIApplication sharedApplication] openURL:[NSURL
     URLWithString:rateLink]];
     }]];*/
    
    // [okButton setValue:[[UIImage imageNamed:@"Down.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    [alertViewController addAction:okButton];
    [alertViewController addAction:[NYAlertAction actionWithTitle:@"No :'("
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                              [self saveToUserDefaults:@"no"];
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
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
