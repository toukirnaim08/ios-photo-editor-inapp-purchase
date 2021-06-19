//
//  SettingsViewController.h
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 3/7/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Config.h"

@interface SettingsViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    UIButton *rateUsButton;
    UIButton *feedbackButton;
    
    UILabel *imageQualityLabel;
    
    UIView *imageQualityView;
    
    UIButton *tipsButton;
    UIButton *removeAdsButton;
    UIButton *restoreButton;
    
    UIButton *closeButton;
    UILabel *settingsLabel;
    
    UILabel *exportLabel;
    UILabel *purchaseLabel;
    
    
    CGRect screenSizeXY;
    
    UISegmentedControl *imageQualitySegment;
    
    UIColor *customButtonColor;
    CGFloat fontSize;
    
    BOOL isImageQuslityHighStatus;
    
    UIView *tipsView;
    UIButton *tipsCloseButton;
}

@end
