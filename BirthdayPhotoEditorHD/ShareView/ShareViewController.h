//
//  ShareViewController.h
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/19/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ViewController.h"
#import "ShopViewController.h"
#import "NYAlertViewController.h"
#import "Config.h"

@interface ShareViewController : UIViewController<ShareViewProtocol,UIDocumentInteractionControllerDelegate,UIPopoverControllerDelegate,MFMailComposeViewControllerDelegate>
{
    UIDocumentInteractionController *docFile;
    BOOL isImageSaved;
    UIImage *finalImage;
    UIView *finalImageBackView;
    UIImageView *finalImageView;
    
    UIView *tabBarView;
    UIButton *backButton;
    UIButton *saveButton;
    UIButton *mailButton;
    UIButton *fbButton;
    UIButton *instaButton;
    UIButton *twitterButton;
    UIButton *finishButton;
    
    UIButton *waterMarkButton;
    UIImageView *waterMarkImageView;
    
    UIButton * removeAdButton;
    UIView *bannerViewBack;
    //GADBannerView *adMobBannerView;
    
    BOOL isAShowFirstTime;
    
    UIView *rateBlurView;
    UIView *rateView;
    UIButton *rateViewRateButton;
    UIButton *rateViewCancelButton;
    UIButton *rateViewButton;
    
}
//@property(nonatomic, strong) GADInterstitial *adInterstitial;
-(void)setImage:(UIImage*)image;

@end
