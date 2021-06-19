//
//  ViewController.h
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/12/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import "DoImagePickerController.h"
#import "EditorViewController.h"
#import "SettingsViewController.h"
//#import "ShopTableViewController.h"
#import "ShopViewController.h"
#import "Config.h"
#import "CLImageEditor.h"
#import "PermissionView.h"
#import "GiftBoxView.h"

@interface ViewController : UIViewController<CLImageEditorDelegate, CLImageEditorTransitionDelegate, CLImageEditorThemeDelegate,UIDocumentInteractionControllerDelegate,UIPopoverControllerDelegate>
{
    UIDocumentInteractionController *docFile;
    NSInteger totalGalleryImages;
    
    UIView *upperView;
    UIView *lowerView;
    
    UIScrollView *purchaserScrollView;
    UIScrollView *photoGalleryView;
    
    
    UIButton *menuButton;
    UIButton *menuShopButton;
    
    UIButton *galleryButton;
    UIButton *cameraButton;
    UIButton *giftButton;
    
    UIButton *selectedGalleryButton;
    
    UIView *subEditorView;
    UIImageView *subEditorImageView;
    UIView *innerSubView;
    
    NSInteger selectedIndexNumber;
    
    PermissionView *permissionView;
}


@end

