//
//  MoreEditorViewController.h
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/16/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareViewController.h"
#import "ShopViewController.h"
#import "Config.h"
#import "CLImageEditor.h"
@interface MoreEditorViewController : UIViewController<MoreViewProtocol,CLImageEditorDelegate, CLImageEditorTransitionDelegate, CLImageEditorThemeDelegate>
{
    UIImage *finalImage;
    UIImageView *finalImageView;
    
    UIView *tabBarView;
    UIButton *backButton;
    UIButton *stickerButton;
    UIButton *textButton;
    UIButton *splashButton;
    UIButton *effectsButton;
    UIButton *shareButton;
    
    UIButton * removeAdButton;
    UIView *bannerViewBack;
    //GADBannerView *adMobBannerView;
    
    UIImage *currentImage;
}
-(void)setImage:(UIImage*)image;

@end
