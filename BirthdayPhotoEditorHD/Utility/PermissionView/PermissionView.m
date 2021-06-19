//
//  PermissionView.m
//  HalloweenMakeupHD
//
//  Created by Toukir Naim on 10/25/17.
//  Copyright © 2017 Bright Newt. All rights reserved.
//

#import "PermissionView.h"
#import "UIView+DCAnimationKit.h"
#import "Config.h"
//#import "secrets.h"
#import <Photos/Photos.h>

@implementation PermissionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        //self.backgroundColor = [UIColor grayColor];
        
        notDeterminedColor = RGBE(31, 193, 151);
        authorizedColor = RGBE(27, 118, 194);
        accessDeniedColor = RGBE(215, 191, 31);
        
        UIView *transparentView = [[UIView alloc] initWithFrame:
                                        CGRectMake(0, 0, frame.size.width, frame.size.height)];
        transparentView.backgroundColor = [UIColor blackColor];
        transparentView.alpha = 0.6f;
        [self addSubview:transparentView];
        
        
        backView = [[UIView alloc] initWithFrame:
                                   CGRectMake(frame.size.width/2 - 300/2,
                                              -frame.size.height,
                                              300,
                                              500)];
        backView.layer.cornerRadius = 10.0;
        backView.backgroundColor = RGBE(247, 247, 247);
        [self addSubview:backView];
        
        self.btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnClose setTitle:@"close" forState:UIControlStateNormal];
        self.btnClose.frame = CGRectMake(230, 4, 60, 28);
        [self.btnClose setBackgroundColor:[UIColor clearColor]];
        // self.btnClose.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        UIColor *tempColor = RGBE(29, 175, 217);
        [self.btnClose setTitleColor:tempColor forState:UIControlStateNormal];
        [self.btnClose addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchDown];
        [backView addSubview:self.btnClose];
        
        UILabel *title1 = [[UILabel alloc] init];
        [title1 setFrame:CGRectMake(0, 30, backView.frame.size.width, 20)];
        //title1.backgroundColor=[UIColor greenColor];
        title1.textColor=[UIColor blackColor];
        title1.font=[UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        
        title1.textAlignment = NSTextAlignmentCenter;
        title1.lineBreakMode = NSLineBreakByWordWrapping;
        title1.numberOfLines = 0;
        title1.userInteractionEnabled=NO;
        //[self.msgBody sizeToFit];
        title1.text= @"Hey, Listen!";
        [backView addSubview:title1];
        
        UILabel *title2 = [[UILabel alloc] init];
        [title2 setFrame:CGRectMake(0, 70, backView.frame.size.width, 40)];
        //title1.backgroundColor=[UIColor greenColor];
        title2.textColor=[UIColor blackColor];
        title2.font=[UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        
        title2.textAlignment = NSTextAlignmentCenter;
        title2.lineBreakMode = NSLineBreakByWordWrapping;
        title2.numberOfLines = 0;
        title2.userInteractionEnabled=NO;
        //[title2 sizeToFit];
        title2.text= @"We need a couple things \r\n before you get started.";
        [backView addSubview:title2];
        
        
        self.allowPhotos = [UIButton buttonWithType:UIButtonTypeCustom];
        self.allowPhotos.frame = CGRectMake(50, 140, 200, 50);
        // self.btnClose.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        
        //self.btnClose.layer.borderWidth = 1.0;
        //[self.btnClose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //self.btnClose.layer.borderColor = UIColorFromRGB(DEFAULT_APP_THEME_COLOR_DARK).CGColor;
        //self.btnClose.layer.cornerRadius = self.btnAccess.frame.size.height / 4;
        self.allowPhotos.layer.cornerRadius = 10.0;
        [self.allowPhotos addTarget:self action:@selector(onAllowPhoto:) forControlEvents:UIControlEventTouchDown];
        [backView addSubview:self.allowPhotos];
        [self setPhotoSettings];
        
        UILabel *photoTitle = [[UILabel alloc] init];
        [photoTitle setFrame:CGRectMake(0, 210, backView.frame.size.width, 55)];
        //title1.backgroundColor=[UIColor greenColor];
        photoTitle.textColor=[UIColor blackColor];
        photoTitle.font=[UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        
        photoTitle.textAlignment = NSTextAlignmentCenter;
        photoTitle.lineBreakMode = NSLineBreakByWordWrapping;
        photoTitle.numberOfLines = 0;
        photoTitle.userInteractionEnabled=NO;
        //[title2 sizeToFit];
        photoTitle.text= @"You need to allow Gallery access \r\n to save & retrieve photos \r\n from Gallery.";
        [backView addSubview:photoTitle];
        
        
        self.allowCamera = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.allowCamera.frame = CGRectMake(50, 315, 200, 50);
        //[self.allowCamera setBackgroundColor:[UIColor redColor]];
        // self.btnClose.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        
        //self.btnClose.layer.borderWidth = 1.0;
        //[self.btnClose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //self.btnClose.layer.borderColor = UIColorFromRGB(DEFAULT_APP_THEME_COLOR_DARK).CGColor;
        //self.btnClose.layer.cornerRadius = self.btnAccess.frame.size.height / 4;
        self.allowCamera.layer.cornerRadius = 10.0;
        [self.allowCamera addTarget:self action:@selector(onAllowCamera:) forControlEvents:UIControlEventTouchDown];
        [backView addSubview:self.allowCamera];
        [self setCameraSettings];
        
        UILabel *cameraTitle = [[UILabel alloc] init];
        [cameraTitle setFrame:CGRectMake(0, 385, backView.frame.size.width, 55)];
        //title1.backgroundColor=[UIColor greenColor];
        cameraTitle.textColor=[UIColor blackColor];
        cameraTitle.font=[UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        
        cameraTitle.textAlignment = NSTextAlignmentCenter;
        cameraTitle.lineBreakMode = NSLineBreakByWordWrapping;
        cameraTitle.numberOfLines = 0;
        cameraTitle.userInteractionEnabled=NO;
        //[title2 sizeToFit];
        cameraTitle.text= @"You need to allow Camera access \r\n to take pictures & videos \r\n from Camera.";
        [backView addSubview:cameraTitle];
        
        [UIView animateWithDuration:0.5 animations:^{
            backView.frame = CGRectMake(frame.size.width/2 - 300/2,
                                        frame.size.height/2 - 500/2,
                                        300,
                                        500);
        } completion:^(BOOL finished)
         {
             [backView bounce:NULL];
         }];
        
        
    }
    return self;
}
-(void)savePermissionInfoViewStatus:(NSString*)myString
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myString forKey:@"PermissionInfo"];
        [standardUserDefaults synchronize];
    }
}
-(void) onClose:(UIButton*)sender
{
    
    [UIView animateWithDuration:0.5 animations:^{
        backView.frame = CGRectMake(self.frame.size.width/2 - 300/2,
                                    -self.frame.size.height,
                                    300,
                                    500);
    } completion:^(BOOL finished)
     {
         [self savePermissionInfoViewStatus:@"yes"];
         //[backView bounce:NULL];
         self.hidden = YES;
         [self removeFromSuperview];
     }];
    
}
-(void)setCameraSettings
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status)
    {
        case AVAuthorizationStatusAuthorized:
            
            [self.allowCamera setTitle:@"Camera Allowed" forState:UIControlStateNormal];
            [self.allowCamera setBackgroundColor:authorizedColor];
            cameraAccesStatus = CameraAuthorized;
            break;
        case AVAuthorizationStatusNotDetermined:
            
            [self.allowCamera setTitle:@"Allow Camera Access" forState:UIControlStateNormal];
            [self.allowCamera setBackgroundColor:notDeterminedColor];
            cameraAccesStatus = CameraNotDetermind;
            break;
        case AVAuthorizationStatusDenied:
            
            [self.allowCamera setTitle:@"Camera Denied" forState:UIControlStateNormal];
            [self.allowCamera setBackgroundColor:accessDeniedColor];
            cameraAccesStatus = CameraDenied;
            break;
        case AVAuthorizationStatusRestricted:
            
            [self.allowCamera setTitle:@"Camera Denied" forState:UIControlStateNormal];
            [self.allowCamera setBackgroundColor:accessDeniedColor];
            cameraAccesStatus = CameraDenied;
            break;
        default:
            break;
    }
}
-(void)setPhotoSettings
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status)
    {
        case PHAuthorizationStatusAuthorized:
            
            [self.allowPhotos setTitle:@"Photos Allowed" forState:UIControlStateNormal];
            [self.allowPhotos setBackgroundColor:authorizedColor];
            photoAccesStatus = GalleryAuthorized;
            break;
        case PHAuthorizationStatusNotDetermined:
            
            [self.allowPhotos setTitle:@"Allow Photo Access" forState:UIControlStateNormal];
            [self.allowPhotos setBackgroundColor:notDeterminedColor];
            photoAccesStatus = GalleryNotDetermind;
            
            break;
        case PHAuthorizationStatusDenied:
            [self.allowPhotos setTitle:@"Photos Denied" forState:UIControlStateNormal];
            [self.allowPhotos setBackgroundColor:accessDeniedColor];
            photoAccesStatus = GalleryDenied;
            break;
        case PHAuthorizationStatusRestricted:
            [self.allowPhotos setTitle:@"Photos Denied" forState:UIControlStateNormal];
            [self.allowPhotos setBackgroundColor:accessDeniedColor];
            photoAccesStatus = GalleryDenied;
            break;
        default:
            break;
    }
}
-(void) onAllowCamera:(UIButton*)sender
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if(granted)
        { // Access has been granted ..do something
            dispatch_async(dispatch_get_main_queue(), ^{
            [self.allowCamera setTitle:@"Camera Allowed" forState:UIControlStateNormal];
            [self.allowCamera setBackgroundColor:authorizedColor];
            cameraAccesStatus = CameraAuthorized;
                });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.allowCamera setTitle:@"Camera Denied" forState:UIControlStateNormal];
                [self.allowCamera setBackgroundColor:accessDeniedColor];
                if(cameraAccesStatus == CameraDenied)
                {
                NSString *accessDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSCameraUsageDescription"];
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:accessDescription message:@"To give permissions tap on 'Change Settings' button" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancelAction];
                
                UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Change Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                    {
                        [self savePermissionInfoViewStatus:@"yes"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                [alertController addAction:settingsAction];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    cameraAccesStatus = CameraDenied;
                }
            });
        }
    }];
}
-(void) onAllowPhoto:(UIButton*)sender
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus authorizationStatus)
     {
         if (authorizationStatus == PHAuthorizationStatusAuthorized)
         {
             dispatch_async(dispatch_get_main_queue(),
            ^{
             [self.allowPhotos setTitle:@"Photos Allowed" forState:UIControlStateNormal];
            [self.allowPhotos setBackgroundColor:authorizedColor];
                photoAccesStatus = GalleryAuthorized;
              });
         }
         else
         {
             dispatch_async(dispatch_get_main_queue(), ^{
             [self.allowPhotos setTitle:@"Photos Denied" forState:UIControlStateNormal];
                 [self.allowPhotos setBackgroundColor:accessDeniedColor];
                 if(photoAccesStatus == GalleryDenied)
                 {
                 NSString *accessDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSPhotoLibraryUsageDescription"];
                 UIAlertController * alertController = [UIAlertController alertControllerWithTitle:accessDescription message:@"To give permissions tap on 'Change Settings' button" preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
                 [alertController addAction:cancelAction];
                 
                 UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Change Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                     {
                         [self savePermissionInfoViewStatus:@"yes"];
                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                 }];
                 [alertController addAction:settingsAction];
                 
                 [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
                 }
                 else
                 {
                     photoAccesStatus = GalleryDenied;
                 }
             });
         }
     }];
}

@end
