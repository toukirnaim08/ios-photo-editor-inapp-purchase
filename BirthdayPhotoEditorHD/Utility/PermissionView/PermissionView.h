//
//  PermissionView.h
//  HalloweenMakeupHD
//
//  Created by Toukir Naim on 10/25/17.
//  Copyright © 2017 Bright Newt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    GalleryAuthorized,
    GalleryDenied,
    GalleryNotDetermind
} PhotoAccesStatus;
typedef enum
{
    CameraAuthorized,
    CameraDenied,
    CameraNotDetermind
} CameraAccesStatus;

@interface PermissionView : UIView
{
    UIView *backView;
    PhotoAccesStatus photoAccesStatus;
    CameraAccesStatus cameraAccesStatus;
    UIColor *notDeterminedColor;
    UIColor *authorizedColor;
    UIColor *accessDeniedColor;
}
@property (nonatomic, strong) UIButton *allowPhotos;
@property (nonatomic, strong) UIButton *allowCamera;

@property (nonatomic, strong) UIButton *btnClose;

@end
