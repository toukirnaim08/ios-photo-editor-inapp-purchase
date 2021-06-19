//
//  MoreEditorViewController.m
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/16/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import "MoreEditorViewController.h"

@interface MoreEditorViewController ()

@end

@implementation MoreEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ShopViewController sharedInstance].moreViewDelegate = self;
    self.view.backgroundColor = RGBE(216, 216, 216);
    [self setLowerView];
    [self setImageIntoPosition];
    [self setAdmobBanner];
    // Do any additional setup after loading the view.
}
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
- (void)moreViewCompletePurchase:(NSString*)purchaseID
{
    if([purchaseID  isEqual: iapId_removeAds] || [purchaseID  isEqual: iapId_allPacks])
    {
        [removeAdButton removeFromSuperview];
        //[adMobBannerView removeFromSuperview];
        [bannerViewBack removeFromSuperview];
    }
}
- (void)moreViewCompleteRestoring
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
-(void)setImageIntoPosition
{
    finalImageView = [[UIImageView alloc] init];
    if(IS_IPAD)
    {
        finalImageView.frame = CGRectMake(150, 100,
                                          self.view.frame.size.width-300,
                                          self.view.frame.size.width-300);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            finalImageView.frame = CGRectMake(10, 100,
                                              self.view.frame.size.width-20,
                                              self.view.frame.size.width-20);
        }
        else
        {
            finalImageView.frame = CGRectMake(10, 100,
                                              self.view.frame.size.width-20,
                                              self.view.frame.size.width-20);
        }
    }
    
    finalImageView.contentMode = UIViewContentModeScaleAspectFit;
    finalImageView.image = finalImage;
    currentImage = finalImage;
    [self.view addSubview:finalImageView];
}
-(void)setImage:(UIImage*)image
{
    finalImage = image;
    currentImage = image;
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
    
    stickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [stickerButton setImage:[UIImage imageNamed:@"tabStickers.png"] forState:UIControlStateNormal];
    [stickerButton addTarget:self
                   action:@selector(stickerButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:stickerButton];
    
    textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [textButton setImage:[UIImage imageNamed:@"tabText.png"] forState:UIControlStateNormal];
    [textButton addTarget:self
                    action:@selector(textButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:textButton];
    
    splashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [splashButton setImage:[UIImage imageNamed:@"tabSplash.png"] forState:UIControlStateNormal];
    [splashButton addTarget:self
                     action:@selector(splashButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:splashButton];
    
    effectsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [effectsButton setImage:[UIImage imageNamed:@"tabEffects.png"] forState:UIControlStateNormal];
    [effectsButton addTarget:self
                   action:@selector(filterButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:effectsButton];
    
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"tabShare.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self
                   action:@selector(shareButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:shareButton];
    
    if(IS_IPAD)
    {
        tabBarView.frame = CGRectMake(0,  self.view.frame.size.height-100, self.view.frame.size.width, 100);
        backButton.frame = CGRectMake(rectWidth/12 - 32, 12, 64, 76);
        stickerButton.frame = CGRectMake(backButton.frame.origin.x + rectWidth/6
                                         , 12, 64, 76);
        textButton.frame = CGRectMake(stickerButton.frame.origin.x + rectWidth/6
                                      , 12, 64, 76);
        splashButton.frame = CGRectMake(textButton.frame.origin.x + rectWidth/6
                                        , 12, 64, 76);
        effectsButton.frame = CGRectMake(splashButton.frame.origin.x + rectWidth/6
                                         , 12, 64, 76);
        shareButton.frame = CGRectMake(effectsButton.frame.origin.x + rectWidth/6
                                       , 12, 64, 76);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            tabBarView.frame = CGRectMake(0,  self.view.frame.size.height-70, self.view.frame.size.width, 70);
            backButton.frame = CGRectMake(rectWidth/12 - 16, 3.5, 32, 38);
            stickerButton.frame = CGRectMake(backButton.frame.origin.x + rectWidth/6
                                             , 3.5, 32, 38);
            textButton.frame = CGRectMake(stickerButton.frame.origin.x + rectWidth/6
                                          , 3.5, 32, 38);
            splashButton.frame = CGRectMake(textButton.frame.origin.x + rectWidth/6
                                            , 3.5, 32, 38);
            effectsButton.frame = CGRectMake(splashButton.frame.origin.x + rectWidth/6
                                             , 3.5, 32, 38);
            shareButton.frame = CGRectMake(effectsButton.frame.origin.x + rectWidth/6
                                           , 3.5, 32, 38);
        }
        else
        {
            tabBarView.frame = CGRectMake(0,  self.view.frame.size.height-45, self.view.frame.size.width, 45);
            backButton.frame = CGRectMake(rectWidth/12 - 16, 3.5, 32, 38);
            stickerButton.frame = CGRectMake(backButton.frame.origin.x + rectWidth/6
                                             , 3.5, 32, 38);
            textButton.frame = CGRectMake(stickerButton.frame.origin.x + rectWidth/6
                                          , 3.5, 32, 38);
            splashButton.frame = CGRectMake(textButton.frame.origin.x + rectWidth/6
                                            , 3.5, 32, 38);
            effectsButton.frame = CGRectMake(splashButton.frame.origin.x + rectWidth/6
                                             , 3.5, 32, 38);
            shareButton.frame = CGRectMake(effectsButton.frame.origin.x + rectWidth/6
                                           , 3.5, 32, 38);
        }
    }
    
}
-(void) backButtonAction:(UIButton*) sender
{
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void) stickerButtonAction:(UIButton*) sender
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:finalImageView.image];
    [editor setCustomToolName:@"sticker"];
    editor.delegate = self;
    [self presentViewController:editor animated:YES completion:nil];
}
-(void) textButtonAction:(UIButton*) sender
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:finalImageView.image];
    [editor setCustomToolName:@"text"];
    editor.delegate = self;
    [self presentViewController:editor animated:YES completion:nil];
}
-(void) splashButtonAction:(UIButton*) sender
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:finalImage];
    [editor setCustomToolName:@"splash"];
    editor.delegate = self;
    [self presentViewController:editor animated:YES completion:nil];
}
-(void) filterButtonAction:(UIButton*) sender
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:finalImage];
    [editor setCustomToolName:@"filter"];
    editor.delegate = self;
    [self presentViewController:editor animated:YES completion:nil];
}
-(void) shareButtonAction:(UIButton*) sender
{
    UIGraphicsBeginImageContextWithOptions(finalImageView.frame.size,
                                           YES,0.0f);
    //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
    [[finalImageView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    ShareViewController * vc = [[ShareViewController alloc] init];
    [vc setImage:outputImage];
    
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.8;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFade;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:vc animated:false completion:nil];
}

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    finalImageView.contentMode = UIViewContentModeScaleAspectFit;
    finalImageView.image = image;
    finalImage = image;
    currentImage = image;
    //[_photo setImage:image];
    //[_dropShadow setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2f]];
    [editor dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imageEditor:(CLImageEditor *)editor willDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled
{
    //[self refreshImageView];
    
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
