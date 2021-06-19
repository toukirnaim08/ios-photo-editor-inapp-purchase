//
//  EditorViewController.m
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/12/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()

@end

@implementation EditorViewController
@synthesize ad;

- (void)viewDidLoad {
    [super viewDidLoad];
    isAShowFirstTime = YES;
    tipsViewStatus = [[NSUserDefaults standardUserDefaults] boolForKey:@"TipsViewStatus"];
    isLoadForFirstTime = YES;
    [ShopViewController sharedInstance].editorViewDelegate = self;
    self.view.backgroundColor = RGBE(254, 251, 239);
    [SVProgressHUD showWithStatus:@"Loading.."];
    // Do any additional setup after loading the view.
    [self setUpperView];
    [self setEditingView];
    

    [self setFramePosition:@"0.png"];
    pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
    //pictureImageView.image = [UIImage imageNamed:@"familly2.png"];
    pictureImageView.image = currentImage;
    [self setAllGestureRecognizer];
    
    [self setFramesScroller];
    [self setBordersView];
    [self setLowerView];
    //if(![[PaymentManager sharedInstance] isAdRemoved])
    //{
    //    [self loadALInterstitialAd];
    //}
    [self setAdmobBanner];
    //currentImage = pictureImageView.image;
    if(!tipsViewStatus)
        [self setTipsView];
    
}
-(void)setImage:(UIImage*)image
{
    currentImage = image;
}
-(void)setTipsView
{
    tipsViewBlurBack = [[UIView alloc] init];
    tipsViewBlurBack.frame = self.view.bounds;
    [self.view addSubview:tipsViewBlurBack];
    
    tipsView = [[UIView alloc] init];
    tipsView.backgroundColor = [UIColor grayColor];
    tipsView.layer.cornerRadius = 10;
    tipsView.layer.borderWidth = 2;
    tipsView.layer.borderColor = [UIColor whiteColor].CGColor;
    tipsView.clipsToBounds = YES;
    [self.view addSubview:tipsView];
    
    UILabel *tipsViewTitle = [[UILabel alloc] init];
    tipsViewTitle.text = @"Tips";
    tipsViewTitle.textColor = [UIColor whiteColor];
    tipsViewTitle.textAlignment = NSTextAlignmentCenter;
    //rateViewLabel.numberOfLines = 0;
    [tipsView addSubview:tipsViewTitle];
    
    UIImageView *tipsImageView = [[UIImageView alloc] init];
    tipsImageView.image = [UIImage imageNamed:@"Tips.png"];
    [tipsView addSubview:tipsImageView];
    
    tipsCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tipsCloseButton setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [tipsCloseButton addTarget:self
                        action:@selector(crossButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
    [tipsView addSubview:tipsCloseButton];
    //tipsView.hidden = YES;
    if(IS_IPAD)
    {
        tipsViewTitle.font = [UIFont fontWithName:@"Arial" size:30.0f];
        tipsView.frame = CGRectMake(self.view.frame.size.width/2 - 250,
                                    self.view.frame.size.height/2 - 340,
                                    500, 680);
        tipsViewTitle.frame = CGRectMake(0,
                                         15,
                                         tipsView.frame.size.width, 50);
        tipsCloseButton.frame = CGRectMake(10,
                                           10,
                                           60, 60);
        tipsImageView.frame = CGRectMake(50,
                                         80,
                                         400, 600);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            tipsView.frame = CGRectMake(self.view.frame.size.width/2 - 100,
                                        self.view.frame.size.height/2 - 180,
                                        200, 340);
            tipsViewTitle.frame = CGRectMake(0,
                                             0,
                                             tipsView.frame.size.width, 30);
            tipsCloseButton.frame = CGRectMake(5,
                                               5,
                                               30, 30);
            tipsImageView.frame = CGRectMake(0,
                                             40,
                                             200, 300);
        }
        else
        {
            tipsView.frame = CGRectMake(self.view.frame.size.width/2 - 150,
                                        self.view.frame.size.height/2 - 242.5,
                                        300, 485);
            tipsViewTitle.frame = CGRectMake(0,
                                            0,
                                            tipsView.frame.size.width, 30);
            tipsCloseButton.frame = CGRectMake(5,
                                               2.5,
                                               30, 30);
            tipsImageView.frame = CGRectMake(0,
                                             35,
                                             300, 450);
        }
    }
    
}
-(void)crossButtonAction:(UIButton*)sender
{
    tipsView.hidden = YES;
    tipsViewBlurBack.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TipsViewStatus"];
}
-(void)setAdmobBanner
{
    /*if(![[PaymentManager sharedInstance] isAdRemoved])
    {
        //[self loadALInterstitialAd];
        //[self createAndLoadInterstitial];
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
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
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
- (void)editorViewCompletePurchase:(NSString *)purchaseID
{
    if([purchaseID  isEqual: iapId_removeAds] || [purchaseID  isEqual: iapId_allPacks])
    {
        [removeAdButton removeFromSuperview];
        //[adMobBannerView removeFromSuperview];
        [bannerViewBack removeFromSuperview];
    }
    //else if([purchaseID  isEqual: iapId_allPacks])
   // {
        //[self clearHeader];
        [self loadMiniFrames];
        int page = framesContainerscrollView.contentOffset.x / framesContainerscrollView.frame.size.width;
        [self setFrameHeaderBorder:page];
   // }
}

- (void)editorViewCompleteRestoring
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
    //[Config sharedInstance].adShowingType = NoAd;
    [Config sharedInstance].applovinAdStatus = HideAd;
}
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    //[Config sharedInstance].adShowingType = NoAd;
    [Config sharedInstance].applovinAdStatus = HideAd;
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    //if([Config sharedInstance].applovinAdStatus != ShowingAd)
    if([Config sharedInstance].adShowingType != ViewingAd)
    {
        [self.adInterstitial presentFromRootViewController:self];
        //[Config sharedInstance].adShowingType = ViewingAd;
        [Config sharedInstance].applovinAdStatus = ShowingAd;
    }
}*/
/*- (void)loadALInterstitialAd
{
    // Load an interstitial ad and be notified when the ad request is finished.
    [ALInterstitialAd shared].adDisplayDelegate = self;
    [[ALSdk shared].adService loadNextAd: [ALAdSize sizeInterstitial] andNotify: self];
}
#pragma mark - Ad Load Delegate

- (void)adService:(nonnull ALAdService *)adService didLoadAd:(nonnull ALAd *)ad
{
    // We now have an interstitial ad we can show!
    if([Config sharedInstance].adShowingType != ViewingAd)
    {
        self.ad = ad;
        [[ALInterstitialAd shared] showOver: [UIApplication sharedApplication].keyWindow andRender: self.ad];
        [Config sharedInstance].applovinAdStatus = ShowingAd;
    }
}

- (void)adService:(nonnull ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for the list of error codes.
}
#pragma mark - Ad Display Delegate

- (void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    //[self log: @"Interstitial displayed"];
    [Config sharedInstance].applovinAdStatus = ShowingAd;
    NSLog(@"Interstitial displayed");
    
}

- (void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    //[self log: @"Interstitial dismissed"];
    [Config sharedInstance].applovinAdStatus = HideAd;
    NSLog(@"Interstitial dismissed");
    
}

- (void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [Config sharedInstance].applovinAdStatus = HideAd;
    //[self log: @"Interstitial clicked"];
    NSLog(@"Interstitial clicked");
   
}*/

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(isLoadForFirstTime)
    {
        isLoadForFirstTime = NO;
        /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            // Do lengthy stuff here
            //[self loadMiniFrames];
            // Dispatch back on the main thread (mandatory for UI updates)
            dispatch_async(dispatch_get_main_queue(), ^{
        
                [self loadMiniFrames];
            });
        });*/
        if(![[PaymentManager sharedInstance] isAdRemoved])
        {
            [self createAndLoadInterstitial];
        }
        [self loadViewMiniFramesBack];
        [self loadMiniFrames];
        [self setFrameHeaderBorder:0];
        
    }
    [SVProgressHUD dismiss];
    //framesContainerView.hidden = YES;
}

-(void)setUpperView
{
    
}
-(void)setEditingView
{
    captureView = [[UIView alloc] init];
    captureView.backgroundColor = RGBE(254, 251, 239);
    [self.view addSubview:captureView];
    
    backView = [[UIView alloc] init];
    //backView.frame = CGRectMake(10, 200, 300, 300);
    backView.backgroundColor = [UIColor clearColor];
    [captureView addSubview:backView];
    
    
    pictureView = [[UIView alloc] init];
    //backView.frame = CGRectMake(10, 200, 300, 300);
    pictureView.backgroundColor = [UIColor clearColor];
    [captureView addSubview:pictureView];
    
    pictureImageView = [[UIImageView alloc] init];
    //backView.frame = CGRectMake(10, 200, 300, 300);
    //pictureImageView.backgroundColor = [UIColor clearColor];
    [pictureView addSubview:pictureImageView];
    
    
    frameView = [[UIView alloc] init];
    //backView.frame = CGRectMake(10, 200, 300, 300);
    frameView.backgroundColor = [UIColor clearColor];
    [captureView addSubview:frameView];
    
    frameImageView = [[UIImageView alloc] init];
    //backView.frame = CGRectMake(10, 200, 300, 300);
    //frameImageView.backgroundColor = [UIColor clearColor];
    [frameView addSubview:frameImageView];
    
}
-(void)setLowerView
{
    CGSize rect = self.view.frame.size;
    CGFloat rectWidth = self.view.frame.size.width;
    
    tabBarView = [[UIView alloc] init];
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarView];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"tabBack.png"] forState:UIControlStateNormal];
    [backButton addTarget:self
                          action:@selector(backButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:backButton];
    
    frameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [frameButton setImage:[UIImage imageNamed:@"tabFrames.png"] forState:UIControlStateNormal];
    [frameButton addTarget:self
                          action:@selector(frameButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:frameButton];
    
    borderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [borderButton setImage:[UIImage imageNamed:@"tabBorder.png"] forState:UIControlStateNormal];
    [borderButton addTarget:self
                          action:@selector(borderButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:borderButton];
    
    filtersButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filtersButton setImage:[UIImage imageNamed:@"tabFilters.png"] forState:UIControlStateNormal];
    [filtersButton addTarget:self
                          action:@selector(filtersButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:filtersButton];
    
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"tabNext.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self
                      action:@selector(nextButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:nextButton];
    
    
    if(IS_IPAD)
    {
        tabBarView.frame = CGRectMake(0,  self.view.frame.size.height-100, self.view.frame.size.width, 100);
        backButton.frame = CGRectMake(rectWidth/10 - 35, 8, 70, 84);
        frameButton.frame = CGRectMake(backButton.frame.origin.x + rectWidth/5
                                       , 8, 70, 84);
        borderButton.frame = CGRectMake(frameButton.frame.origin.x + rectWidth/5
                                        , 8, 70, 84);
        filtersButton.frame = CGRectMake(borderButton.frame.origin.x + rectWidth/5
                                         , 8, 70, 84);
        nextButton.frame = CGRectMake(filtersButton.frame.origin.x + rectWidth/5
                                      , 8, 70, 84);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            tabBarView.frame = CGRectMake(0,  self.view.frame.size.height-70, self.view.frame.size.width, 70);
            backButton.frame = CGRectMake(rectWidth/10 - 17.5, 3, 35, 42);
            frameButton.frame = CGRectMake(backButton.frame.origin.x + rectWidth/5
                                           , 3, 35, 42);
            borderButton.frame = CGRectMake(frameButton.frame.origin.x + rectWidth/5
                                            , 3, 35, 42);
            filtersButton.frame = CGRectMake(borderButton.frame.origin.x + rectWidth/5
                                             , 3, 35, 42);
            nextButton.frame = CGRectMake(filtersButton.frame.origin.x + rectWidth/5
                                          , 3, 35, 42);
        }
        else
        {
            tabBarView.frame = CGRectMake(0,  self.view.frame.size.height-45, self.view.frame.size.width, 45);
            backButton.frame = CGRectMake(rectWidth/10 - 17.5, 2, 35, 42);
            frameButton.frame = CGRectMake(backButton.frame.origin.x + rectWidth/5
                                           , 2, 35, 42);
            borderButton.frame = CGRectMake(frameButton.frame.origin.x + rectWidth/5
                                            , 2, 35, 42);
            filtersButton.frame = CGRectMake(borderButton.frame.origin.x + rectWidth/5
                                             , 2, 35, 42);
            nextButton.frame = CGRectMake(filtersButton.frame.origin.x + rectWidth/5
                                          , 2, 35, 42);
        }
    }
    
}
-(void) backButtonAction:(UIButton*) sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void) frameButtonAction:(UIButton*) sender
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         borderContainerView.frame = CGRectMake(
                                                                borderContainerView.frame.origin.x,
                                                                self.view.frame.size.height,
                                                                borderContainerView.frame.size.width,
                                                                borderContainerView.frame.size.height );
                         
                     }completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5
                                               delay:0
                                             options:UIViewAnimationOptionTransitionNone
                                          animations:^{
                                              if(IS_IPAD)
                                              {
                                                  framesContainerView.frame = CGRectMake(
                                                                                         framesContainerView.frame.origin.x,
                                                                                         self.view.frame.size.height-350,
                                                                                         framesContainerView.frame.size.width,
                                                                                         framesContainerView.frame.size.height );
                                              }
                                              else
                                              {
                                                  if(IS_IPHONE_X)
                                                  {
                                                      framesContainerView.frame = CGRectMake(
                                                                                             framesContainerView.frame.origin.x,
                                                                                             self.view.frame.size.height-230,
                                                                                             framesContainerView.frame.size.width,
                                                                                             framesContainerView.frame.size.height );
                                                  }
                                                  else
                                                  {
                                                      framesContainerView.frame = CGRectMake(
                                                                                             framesContainerView.frame.origin.x,
                                                                                             self.view.frame.size.height-205,
                                                                                             framesContainerView.frame.size.width,
                                                                                             framesContainerView.frame.size.height );
                                                  }
                                              }
                                              
                                              
                                          }completion:^(BOOL finished){
                                              
                                          }];
                         
                     }];
}
-(void) borderButtonAction:(UIButton*) sender
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
    framesContainerView.frame = CGRectMake(
    framesContainerView.frame.origin.x,
    self.view.frame.size.height,
    framesContainerView.frame.size.width,
    framesContainerView.frame.size.height );
                     }completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5
                                               delay:0
                                             options:UIViewAnimationOptionTransitionNone
                                          animations:^{
                                              if(IS_IPAD)
                                              {
                                                  borderContainerView.frame = CGRectMake(
                                                                                         borderContainerView.frame.origin.x,
                                                                                         self.view.frame.size.height-300,
                                                                                         borderContainerView.frame.size.width,
                                                                                         borderContainerView.frame.size.height );
                                              }
                                              else
                                              {
                                                  if(IS_IPHONE_X)
                                                  {
                                                      borderContainerView.frame = CGRectMake(
                                                                                             borderContainerView.frame.origin.x,
                                                                                             self.view.frame.size.height-200,
                                                                                             borderContainerView.frame.size.width,
                                                                                             borderContainerView.frame.size.height );
                                                  }
                                                  else
                                                  {
                                                      borderContainerView.frame = CGRectMake(
                                                                                             borderContainerView.frame.origin.x,
                                                                                             self.view.frame.size.height-175,
                                                                                             borderContainerView.frame.size.width,
                                                                                             borderContainerView.frame.size.height );
                                                  }
                                              }
                     
                                          }completion:^(BOOL finished){
                                              
                                          }];
                         
                     }];
}
-(void) filtersButtonAction:(UIButton*) sender
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:currentImage];
    [editor setCustomToolName:@"CLFilterTool"];
    editor.delegate = self;
    [self presentViewController:editor animated:YES completion:nil];
}
-(void)nextButtonAction:(UIButton*)sender
{
    UIGraphicsBeginImageContextWithOptions(captureView.frame.size,
                                           YES,0.0f);
    //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
    [[captureView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    /*MoreEditorViewController * vc = [[MoreEditorViewController alloc] init];
     [vc setImage:outputImage];
     [self presentViewController:vc animated:YES completion:nil];*/
    
    MoreEditorViewController * vc = [[MoreEditorViewController alloc] init];
    [vc setImage:outputImage];
    
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:vc animated:false completion:nil];
}
- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    currentImage = image;
    pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
    pictureImageView.image = image;
    [editor dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imageEditor:(CLImageEditor *)editor willDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled
{
    //[self refreshImageView];
    
}
-(void)setSelectedFrame:(NSString*)frameName
{
    [frameImageView.layer setBorderWidth:0];
    [frameImageView.layer setBorderColor:[UIColor clearColor].CGColor];
    frameImageView.contentMode = UIViewContentModeScaleAspectFit;
    frameImageView.image = [UIImage imageNamed:frameName];
}
-(void)setFramePosition: (NSString*)imagename
{
    [frameImageView.layer setBorderWidth:0];
    [frameImageView.layer setBorderColor:[UIColor clearColor].CGColor];
    frameImageView.contentMode = UIViewContentModeScaleAspectFit;
    frameImageView.image = [UIImage imageNamed:imagename];
    
    CGRect Rect=[[UIScreen mainScreen] bounds];
    float tempWidth = frameImageView.image.size.width;
    float tempHeigt = frameImageView.image.size.height;
    float tempX = 0;
    float tempY = 0;
    
    
    if(IS_IPAD)
    {
        tempWidth = Rect.size.width - 200;
        tempHeigt = tempWidth;
        tempX = (Rect.size.width/2) - (tempWidth/2);
        tempY = 100;
        
        transitonY = tempY+tempHeigt - 100;
    }
    else
    {
        if(IS_IPHONE_X)
        {
            tempWidth = Rect.size.width - 10;
            tempHeigt = (frameImageView.image.size.height/frameImageView.image.size.width) * tempWidth;
            tempX = (Rect.size.width/2) - (tempWidth/2);
            tempY = 110;
            
            transitonY = tempY+tempHeigt - 50;
        }
        else
        {
            tempWidth = Rect.size.width - 10;
            tempHeigt = (frameImageView.image.size.height/frameImageView.image.size.width) * tempWidth;
            tempX = (Rect.size.width/2) - (tempWidth/2);
            tempY = 60;
            
            transitonY = tempY+tempHeigt - 50;
        }
    }
    
    
    captureView.frame = CGRectMake(tempX, tempY, tempWidth, tempHeigt);
    backView.frame = CGRectMake(0, 0, tempWidth-1, tempHeigt-1);
    frameView.frame = CGRectMake(0, 0, tempWidth, tempHeigt);
    frameImageView.frame = CGRectMake(0, 0, tempWidth, tempHeigt);
    pictureView.frame = CGRectMake(0, 0, tempWidth, tempHeigt);
    pictureImageView.frame = CGRectMake(0, 0, tempWidth, tempHeigt);
    
    ///side bars
    
    upperOpenView = [[UIView alloc] init];
    [self.view addSubview:upperOpenView];
    leftOpenView = [[UIView alloc] init];
    [self.view addSubview:leftOpenView];
    rightOpenView = [[UIView alloc] init];
    [self.view addSubview:rightOpenView];
    lowerOpenView = [[UIView alloc] init];
    [self.view addSubview:lowerOpenView];
    
    upperOpenView.backgroundColor = RGBE(254, 251, 239);
    leftOpenView.backgroundColor = RGBE(254, 251, 239);
    rightOpenView.backgroundColor = RGBE(254, 251, 239);
    lowerOpenView.backgroundColor = RGBE(254, 251, 239);
    
    
    
    upperOpenView.frame = CGRectMake(0,0,Rect.size.width,
                                     captureView.frame.origin.y);
    leftOpenView.frame = CGRectMake(0,tempY,
                                    tempX,
                                    tempHeigt);
    rightOpenView.frame = CGRectMake(tempX+tempWidth,
                                     tempY,
                                     Rect.size.width -
                                     tempWidth - tempX,
                                     tempHeigt);
    lowerOpenView.frame = CGRectMake(0,tempY+tempHeigt,
                                     Rect.size.width,
                                     self.view.frame.size.height -
                                     tempY-tempHeigt);
}
-(void)setBordersView
{
    CGRect Rect=[[UIScreen mainScreen] bounds];
    
    borderContainerView = [[UIView alloc] init];
    
    //borderContainerView.backgroundColor = RGBE(216, 216, 216);
    borderContainerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:borderContainerView];
    
    borderContainerscrollView = [[UIScrollView alloc] init];
    
    if(IS_IPAD)
    {
        borderContainerView.frame = CGRectMake(0,
                                               self.view.frame.size.height,
                                               self.view.frame.size.width,
                                               200);
        borderContainerscrollView.frame = CGRectMake(0,0,
                                                     self.view.frame.size.width,200);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            borderContainerView.frame = CGRectMake(0,
                                                   self.view.frame.size.height,
                                                   self.view.frame.size.width,
                                                   130);
            borderContainerscrollView.frame = CGRectMake(0,0,
                                                         self.view.frame.size.width,130);
        }
        else
        {
            borderContainerView.frame = CGRectMake(0,
                                                   self.view.frame.size.height,
                                                   self.view.frame.size.width,
                                                   130);
            borderContainerscrollView.frame = CGRectMake(0,0,
                                                         self.view.frame.size.width,130);
        }
    }
    
    
    borderContainerscrollView.showsHorizontalScrollIndicator=NO;
    //framesContainerscrollView.backgroundColor = [UIColor grayColor];
    borderContainerscrollView.scrollEnabled=YES;
    borderContainerscrollView.userInteractionEnabled=YES;
    borderContainerscrollView.pagingEnabled = YES;
    [borderContainerView addSubview:borderContainerscrollView];
    
    int widthCount = 0;
    int count = 0;
    int pageNumber = 0;
    int offsetPosition = 0;
    int offsetValue = self.view.frame.size.width/5;
    int buttonTag = 0;
    for(int i=0;i<1;i++)
    {
        pageNumber = i*self.view.frame.size.width;
        if(IS_IPAD)
        {
            offsetPosition = self.view.frame.size.width/10 - 40;
        }
        else
        {
            if(IS_IPHONE_X)
            {
                offsetPosition = self.view.frame.size.width/10 - 25;
            }
            else
            {
                offsetPosition = self.view.frame.size.width/10 - 25;
            }
        }
        
        for(int k=0 ;k<10;k++)
        {
            UIButton *miniBorderButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [miniBorderButton addTarget:self
                                action:@selector(miniBorderButtonAction:)
                      forControlEvents:UIControlEventTouchUpInside];
            [miniBorderButton.layer setCornerRadius:15.0f];
            [miniBorderButton setBackgroundColor:[UIColor clearColor]];
            [miniBorderButton.layer setBorderWidth:3];
            miniBorderButton.clipsToBounds = YES;
            
            if(k==0)
                [miniBorderButton.layer setBorderColor:[UIColor redColor].CGColor];
            else if(k==1)
                [miniBorderButton.layer setBorderColor:[UIColor grayColor].CGColor];
            else if(k==2)
                [miniBorderButton.layer setBorderColor:[UIColor greenColor].CGColor];
            else if(k==3)
                [miniBorderButton.layer setBorderColor:[UIColor blueColor].CGColor];
            else if(k==4)
                [miniBorderButton.layer setBorderColor:[UIColor cyanColor].CGColor];
            else if(k==5)
                [miniBorderButton.layer setBorderColor:RGBE(90, 184, 163).CGColor];
            else if(k==6)
                [miniBorderButton.layer setBorderColor:[UIColor magentaColor].CGColor];
            else if(k==7)
                [miniBorderButton.layer setBorderColor:[UIColor orangeColor].CGColor];
            else if(k==8)
                [miniBorderButton.layer setBorderColor:[UIColor purpleColor].CGColor];
            else if(k==9)
                [miniBorderButton.layer setBorderColor:[UIColor brownColor].CGColor];
            
            miniBorderButton.tag = 20000 + buttonTag;
            buttonTag++;
            if(k<5)
            {
                if(IS_IPAD)
                {
                    [miniBorderButton.layer setBorderWidth:5];
                    miniBorderButton.frame = CGRectMake(pageNumber + offsetPosition + (k*offsetValue),
                                                       13.3,
                                                       80,
                                                       80);
                }
                else
                {
                    if(IS_IPHONE_X)
                    {
                        miniBorderButton.frame = CGRectMake(pageNumber + offsetPosition + (k*offsetValue),
                                                           10,
                                                           50,
                                                           50);
                    }
                    else
                    {
                        miniBorderButton.frame = CGRectMake(pageNumber + offsetPosition + (k*offsetValue),
                                                           10,
                                                           50,
                                                           50);
                    }
                }
                
            }
            else
            {
                if(IS_IPAD)
                {
                    [miniBorderButton.layer setBorderWidth:5];
                    miniBorderButton.frame = CGRectMake(pageNumber + offsetPosition + ((k-5)*offsetValue),
                                                       106.6,
                                                       80,
                                                       80);
                }
                else
                {
                    if(IS_IPHONE_X)
                    {
                        miniBorderButton.frame = CGRectMake(pageNumber + offsetPosition + ((k-5)*offsetValue),
                                                           70,
                                                           50,
                                                           50);
                    }
                    else
                    {
                        miniBorderButton.frame = CGRectMake(pageNumber + offsetPosition + ((k-5)*offsetValue),
                                                           70,
                                                           50,
                                                           50);
                    }
                }
                
                count++;
            }
            [borderContainerscrollView addSubview:miniBorderButton];
        }
    }
    if(IS_IPAD)
    {
        borderContainerscrollView.contentSize = CGSizeMake(self.view.frame.size.width*1,200);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            borderContainerscrollView.contentSize = CGSizeMake(self.view.frame.size.width*1,130);
        }
        else
        {
            borderContainerscrollView.contentSize = CGSizeMake(self.view.frame.size.width*1,130);
        }
    }
    
}
-(void)miniBorderButtonAction:(UIButton*)sender
{
    NSInteger indextag = sender.tag - 20000;
    frameImageView.image = [UIImage imageNamed:@"transparent.png"];
    if(IS_IPAD)
        [frameImageView.layer setBorderWidth:15];
    else
        [frameImageView.layer setBorderWidth:8];
    if(indextag==0)
    {
        [frameImageView.layer setBorderColor:[UIColor redColor].CGColor];
        
    }
    else if(indextag==1)
        [frameImageView.layer setBorderColor:[UIColor grayColor].CGColor];
    else if(indextag==2)
        [frameImageView.layer setBorderColor:[UIColor greenColor].CGColor];
    else if(indextag==3)
        [frameImageView.layer setBorderColor:[UIColor blueColor].CGColor];
    else if(indextag==4)
        [frameImageView.layer setBorderColor:[UIColor cyanColor].CGColor];
    else if(indextag==5)
        [frameImageView.layer setBorderColor:RGBE(90, 184, 163).CGColor];
    else if(indextag==6)
        [frameImageView.layer setBorderColor:[UIColor magentaColor].CGColor];
    else if(indextag==7)
        [frameImageView.layer setBorderColor:[UIColor orangeColor].CGColor];
    else if(indextag==8)
        [frameImageView.layer setBorderColor:[UIColor purpleColor].CGColor];
    else if(indextag==9)
        [frameImageView.layer setBorderColor:[UIColor brownColor].CGColor];
}
-(void)setFramesScroller
{
    CGRect Rect=[[UIScreen mainScreen] bounds];
    framesContainerView = [[UIView alloc] init];
    framesContainerView.backgroundColor = RGBE(216, 216, 216);
    [self.view addSubview:framesContainerView];
    
    
    framesContainerHeaderView = [[UIView alloc] init];
    
    framesContainerHeaderView.backgroundColor = [UIColor whiteColor];
    [framesContainerView addSubview:framesContainerHeaderView];
    
    framesContainerscrollView = [[UIScrollView alloc] init];
    framesContainerscrollView.showsHorizontalScrollIndicator=NO;
    //framesContainerscrollView.backgroundColor = [UIColor grayColor];
    framesContainerscrollView.scrollEnabled=YES;
    framesContainerscrollView.userInteractionEnabled=YES;
    framesContainerscrollView.pagingEnabled = YES;
    framesContainerscrollView.delegate = self;
    [framesContainerView addSubview:framesContainerscrollView];
    
    
    if(IS_IPAD)
    {
        framesContainerView.frame = CGRectMake(0,
                                               self. view.frame.size.height-350,
                                               self.view.frame.size.width,
                                               250);
        framesContainerHeaderView.frame = CGRectMake(0,  0,
                                                     self.view.frame.size.width, 50);
        framesContainerscrollView.frame = CGRectMake(0,50,
                                                     self.view.frame.size.width,200);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            framesContainerView.frame = CGRectMake(0,
                                                   self. view.frame.size.height-230,
                                                   self.view.frame.size.width,
                                                   160);
            framesContainerHeaderView.frame = CGRectMake(0,  0,
                                                         self.view.frame.size.width, 30);
            framesContainerscrollView.frame = CGRectMake(0,30,
                                                         self.view.frame.size.width,130);
        }
        else
        {
            framesContainerView.frame = CGRectMake(0,
                                                   self. view.frame.size.height-205,
                                                   self.view.frame.size.width,
                                                   160);
            framesContainerHeaderView.frame = CGRectMake(0,  0,
                                                         self.view.frame.size.width, 30);
            framesContainerscrollView.frame = CGRectMake(0,30,
                                                         self.view.frame.size.width,130);
        }
    }
    
    
}
-(void)loadViewMiniFramesBack
{
    CGRect Rect=[[UIScreen mainScreen] bounds];
    NSString *imageName;
    for (int c=0; c<6; c++)
    {
        UIImageView *frameHeaderBack = [[UIImageView alloc] init];
        //NSString *imageName = [NSString stringWithFormat:@"%d.png" , c];
        if(c==0)
        {
            imageName = @"header9.png";
            //[frameHeaderBack.layer setBorderColor: [[UIColor blackColor] CGColor]];
            //[frameHeaderBack.layer setBorderWidth: 2.0];
        }
        else if(c==1)
            imageName = @"header0.png";
        else if(c==2)
            imageName = @"header1.png";
        else if(c==3)
            imageName = @"header2.png";
        else if(c==4)
            imageName = @"header3.png";
        else if(c==5)
            imageName = @"header4.png";
        frameHeaderBack.tag = 3000+c;
        
        frameHeaderBack.clipsToBounds = YES;
        frameHeaderBack.image =[UIImage imageNamed:imageName];
        [framesContainerView addSubview:frameHeaderBack];
        if(IS_IPAD)
        {
            [frameHeaderBack.layer setCornerRadius:4];
            frameHeaderBack.frame = CGRectMake((Rect.size.width/12 - 23) + (c * (Rect.size.width/6)),
                                               2,
                                               46,
                                               46);
            
        }
        else
        {
            if(IS_IPHONE_X)
            {
                [frameHeaderBack.layer setCornerRadius:2];
                frameHeaderBack.frame = CGRectMake((Rect.size.width/12 - 14) + (c * (Rect.size.width/6)),
                                                   1,
                                                   28,
                                                   28);
                
            }
            else
            {
                [frameHeaderBack.layer setCornerRadius:2];
                frameHeaderBack.frame = CGRectMake((Rect.size.width/12 - 14) + (c * (Rect.size.width/6)),
                                                   1,
                                                   28,
                                                   28);
                
            }
        }
        
        UIButton *frameHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        frameHeaderButton.tag = 1000 + c;
        [framesContainerView addSubview:frameHeaderButton];
    }
}
-(void)loadMiniFrames
{
    CGRect Rect=[[UIScreen mainScreen] bounds];
    
    for (int c=0; c<6; c++)
    {
        //UIButton *frameHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *frameHeaderButton = (UIButton *)[self.view viewWithTag:(c+1000)];
        [frameHeaderButton addTarget:self
                              action:@selector(frameHeaderButtonAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        //[miniFrameButton.layer setCornerRadius:15.0f];
        frameHeaderButton.clipsToBounds = YES;
        [[frameHeaderButton imageView] setContentMode: UIViewContentModeScaleToFill];
        //NSString *imageName = [NSString stringWithFormat:@"%d.png" , c];
        if([[PaymentManager sharedInstance] isPackPuchased:c])
        {
            [frameHeaderButton setImage:[UIImage imageNamed:@"normal.png"]
                               forState:UIControlStateNormal];
        }
        else
        {
            [frameHeaderButton setImage:[UIImage imageNamed:@"locked.png"]
                               forState:UIControlStateNormal];
        }
        
        //[framesContainerView addSubview:frameHeaderButton];
        
        
        if(IS_IPAD)
        {
            
            frameHeaderButton.frame = CGRectMake((Rect.size.width/12 - 23) + (c * (Rect.size.width/6)),
                                                 2,
                                                 46,
                                                 46);
        }
        else
        {
            if(IS_IPHONE_X)
            {
                
                frameHeaderButton.frame = CGRectMake((Rect.size.width/12 - 14) + (c * (Rect.size.width/6)),
                                                     1,
                                                     28,
                                                     28);
            }
            else
            {
                
                frameHeaderButton.frame = CGRectMake((Rect.size.width/12 - 14) + (c * (Rect.size.width/6)),
                                                     1,
                                                     28,
                                                     28);
            }
        }
        
    }
    
    int widthCount = 0;
    int count = 0;
    int pageNumber = 0;
    int offsetPosition = 0;
    int offsetValue = self.view.frame.size.width/5;
    int buttonTag = 0;
    for(int i=0;i<6;i++)
    {
        pageNumber = i*self.view.frame.size.width;
        if(IS_IPAD)
        {
            offsetPosition = self.view.frame.size.width/10 - 40;
        }
        else
        {
            if(IS_IPHONE_X)
            {
                offsetPosition = self.view.frame.size.width/10 - 25;
            }
            else
            {
                offsetPosition = self.view.frame.size.width/10 - 25;
            }
        }
        
        for(int k=0 ;k<10;k++)
        {
            UIButton *miniFrameButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [miniFrameButton addTarget:self
                                action:@selector(miniFrameButtonAction:)
                      forControlEvents:UIControlEventTouchUpInside];
            //[miniFrameButton.layer setCornerRadius:15.0f];
            miniFrameButton.clipsToBounds = YES;
            [[miniFrameButton imageView] setContentMode: UIViewContentModeScaleToFill];
            NSString *imageName = [NSString stringWithFormat:@"%d.png" , buttonTag];
            [miniFrameButton setImage:[UIImage imageNamed:imageName]
                             forState:UIControlStateNormal];
            miniFrameButton.tag = 2000+buttonTag;
            buttonTag++;
            if(k<5)
            {
                if(IS_IPAD)
                {
                    miniFrameButton.frame = CGRectMake(pageNumber + offsetPosition + (k*offsetValue),
                                                       13.3,
                                                       80,
                                                       80);
                }
                else
                {
                    if(IS_IPHONE_X)
                    {
                        miniFrameButton.frame = CGRectMake(pageNumber + offsetPosition + (k*offsetValue),
                                                           10,
                                                           50,
                                                           50);
                    }
                    else
                    {
                        miniFrameButton.frame = CGRectMake(pageNumber + offsetPosition + (k*offsetValue),
                                                           10,
                                                           50,
                                                           50);
                    }
                }
                
            }
            else
            {
                if(IS_IPAD)
                {
                    miniFrameButton.frame = CGRectMake(pageNumber + offsetPosition + ((k-5)*offsetValue),
                                                       106.6,
                                                       80,
                                                       80);
                }
                else
                {
                    if(IS_IPHONE_X)
                    {
                        miniFrameButton.frame = CGRectMake(pageNumber + offsetPosition + ((k-5)*offsetValue),
                                                           70,
                                                           50,
                                                           50);
                    }
                    else
                    {
                        miniFrameButton.frame = CGRectMake(pageNumber + offsetPosition + ((k-5)*offsetValue),
                                                           70,
                                                           50,
                                                           50);
                    }
                }
                
                count++;
            }
            [framesContainerscrollView addSubview:miniFrameButton];
        }
    }
    if(IS_IPAD)
    {
        framesContainerscrollView.contentSize = CGSizeMake(self.view.frame.size.width*6,200);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            framesContainerscrollView.contentSize = CGSizeMake(self.view.frame.size.width*6,130);
        }
        else
        {
            framesContainerscrollView.contentSize = CGSizeMake(self.view.frame.size.width*6,130);
        }
    }
    
    
}
-(void)frameHeaderButtonAction:(UIButton*)sender
{
    NSInteger tagIndex = sender.tag - 1000;
    [UIView animateWithDuration:0.5 animations:^{
        [framesContainerscrollView setContentOffset:CGPointMake(framesContainerscrollView.frame.size.width*tagIndex, 0.0f)];
    }];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self setFrameHeaderBorder:page];
    //NSLog(@"scroller Current Page->>>%d",page);
}
-(void)setFrameHeaderBorder:(NSInteger)index
{
    UIImageView *imageViewTemp0 = (UIImageView *)[self.view viewWithTag:(0+3000)];
    [imageViewTemp0.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [imageViewTemp0.layer setBorderWidth: 0.0];
    
    UIImageView *imageViewTemp1 = (UIImageView *)[self.view viewWithTag:(1+3000)];
    [imageViewTemp1.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [imageViewTemp1.layer setBorderWidth: 0.0];
    
    UIImageView *imageViewTemp2 = (UIImageView *)[self.view viewWithTag:(2+3000)];
    [imageViewTemp2.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [imageViewTemp2.layer setBorderWidth: 0.0];
    
    UIImageView *imageViewTemp3 = (UIImageView *)[self.view viewWithTag:(3+3000)];
    [imageViewTemp3.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [imageViewTemp3.layer setBorderWidth: 0.0];
    
    UIImageView *imageViewTemp4 = (UIImageView *)[self.view viewWithTag:(4+3000)];
    [imageViewTemp4.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [imageViewTemp4.layer setBorderWidth: 0.0];
    
    UIImageView *imageViewTemp5 = (UIImageView *)[self.view viewWithTag:(5+3000)];
    [imageViewTemp5.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [imageViewTemp5.layer setBorderWidth: 0.0];
    
    UIImageView *imageViewTemp = (UIImageView *)[self.view viewWithTag:(index+3000)];
    [imageViewTemp.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [imageViewTemp.layer setBorderWidth: 2.0];
}
-(void)clearHeader
{
    UIImageView *imageViewTemp0 = (UIImageView *)[self.view viewWithTag:(0+3000)];
    [imageViewTemp0 removeFromSuperview];
    
    UIImageView *imageViewTemp1 = (UIImageView *)[self.view viewWithTag:(1+3000)];
    [imageViewTemp0 removeFromSuperview];
    
    UIImageView *imageViewTemp2 = (UIImageView *)[self.view viewWithTag:(2+3000)];
    [imageViewTemp0 removeFromSuperview];
    
    UIImageView *imageViewTemp3 = (UIImageView *)[self.view viewWithTag:(3+3000)];
    [imageViewTemp0 removeFromSuperview];
    
    UIImageView *imageViewTemp4 = (UIImageView *)[self.view viewWithTag:(4+3000)];
    [imageViewTemp0 removeFromSuperview];
    
    UIImageView *imageViewTemp5 = (UIImageView *)[self.view viewWithTag:(5+3000)];
    [imageViewTemp0 removeFromSuperview];
}
-(void)miniFrameButtonAction:(UIButton*) sender
{
    NSString *frameName;
    NSInteger i = sender.tag - 2000;
    NSInteger packNumber = i/10;
    NSInteger frameNumber = i%10;
    frameName = [NSString stringWithFormat:@"%ld.png",(long)i];;
    if(packNumber == 0)
    {
        [self setSelectedFrame:frameName];
    }
    else
    {
        [self setPackState:packNumber];
        if([[PaymentManager sharedInstance] isPackPuchased:packNumber])
        {
            [self setSelectedFrame:frameName];
        }
        else
        {
            ShopViewController * vc = [ShopViewController sharedInstance];
            //ShopViewController * vc = [[ShopViewController alloc] init];
            [vc setPackNumber];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
    int b = 0;
}
-(void)setPackState:(NSUInteger)packIndex
{
    if(packIndex==1)
    {
        [Config sharedInstance].purchaseIDType = pack2;
    }
    if(packIndex==2)
    {
        [Config sharedInstance].purchaseIDType = pack3;
    }
    if(packIndex==3)
    {
        [Config sharedInstance].purchaseIDType = pack4;
    }
    if(packIndex==4)
    {
        [Config sharedInstance].purchaseIDType = pack5;
    }
    if(packIndex==5)
    {
        [Config sharedInstance].purchaseIDType = pack6;
    }
    if(packIndex==6)
    {
        [Config sharedInstance].purchaseIDType = removeAd;
    }
    if(packIndex==7)
    {
        [Config sharedInstance].purchaseIDType = removeMark;
    }
}
-(void)setAllGestureRecognizer
{
    //[Config sharedInstance].effectTypeState = Frame;
    lastRotation = 0.0;
    
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:2];
    [panRecognizer setDelegate:self];
    [frameView addGestureRecognizer:panRecognizer];
    
    rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [rotationRecognizer setDelegate:self];
    [frameView addGestureRecognizer:rotationRecognizer];
    
    pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [pinchRecognizer setDelegate:self];
    [frameView addGestureRecognizer:pinchRecognizer];
}
-(void)move:(id)sender
{
    
    [self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan)
    {
        firstX = [pictureView center].x;
        firstY = [pictureView center].y;
    }
    translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY+translatedPoint.y);
    if(translatedPoint.y >= 25 && translatedPoint.y <= transitonY)
        [pictureView setCenter:translatedPoint];
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        CGFloat finalX = translatedPoint.x + (0*[(UIPanGestureRecognizer*)sender velocityInView:frameView].x);
        CGFloat finalY = translatedPoint.y + (0*[(UIPanGestureRecognizer*)sender velocityInView:frameView].y);
        
    }
}
-(void)rotate:(id)sender
{
    
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = pictureView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [pictureView setTransform:newTransform];
    //lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
    lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
}
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    
    pictureView.transform = CGAffineTransformScale(pictureView.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // if the gesture recognizers are on different views, don't allow simultaneous recognition
    if (gestureRecognizer.view != otherGestureRecognizer.view)
        return NO;
    
    // if either of the gesture recognizers is the long press, don't allow simultaneous recognition
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
        return NO;
    
    return YES;
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
