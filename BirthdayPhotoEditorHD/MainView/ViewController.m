//
//  ViewController.m
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/12/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = RGBE(254, 251, 239);
    [self setUpperView];
    [self setLowerView];
    //[self setPurchaseScrollView];
    [self setPhotoGalleryScrollView];
    [self setSubEditorView];
    [self showPermissionView];
}
-(void)showPermissionView
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"PermissionInfo"];
    if(savedValue == nil)
    {
        permissionView = [[PermissionView alloc] initWithFrame: CGRectMake(
                                                                           0,
                                                                           0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:permissionView];
        
        
    }
}
-(void)setSubEditorView
{
    subEditorView = [[UIView alloc] init];
    subEditorView.backgroundColor = [UIColor yellowColor];
    subEditorView.frame = self.view.bounds;
    [self.view addSubview:subEditorView];
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        subEditorView.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        //always fill the view
        blurEffectView.frame = subEditorView.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [subEditorView addSubview:blurEffectView]; //if you have more UIViews, use an insertSubview API to place it where needed
    } else {
        subEditorView.backgroundColor = [UIColor blackColor];
    }
    
    
    subEditorImageView = [[UIImageView alloc] init];
    if(IS_IPAD)
    {
        subEditorImageView.frame = CGRectMake(self.view.frame.size.width/2 - 250,
                                              100,
                                              500, 500);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            subEditorImageView.frame = CGRectMake(self.view.frame.size.width/2 - 150,
                                                  70,
                                                  300, 300);
        }
        else
        {
            subEditorImageView.frame = CGRectMake(self.view.frame.size.width/2 - 150,
                                                  50,
                                                  300, 300);
        }
    }
    
    [subEditorImageView.layer setBorderWidth:6];
    [subEditorImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [subEditorView addSubview:subEditorImageView];
    
    innerSubView = [[UIView alloc] init];
    innerSubView.backgroundColor = [UIColor whiteColor];
    
    [innerSubView.layer setCornerRadius:20];
    innerSubView.clipsToBounds = YES;
    [subEditorView addSubview:innerSubView];
    
    UIImageView *filterButtonBack = [[UIImageView alloc] init];
    [filterButtonBack setImage:[UIImage imageNamed:@"filter.png"]];
    [innerSubView addSubview:filterButtonBack];
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setTitle:@"Filter" forState:UIControlStateNormal];
    [filterButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    filterButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    filterButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [innerSubView addSubview:filterButton];
    [filterButton addTarget:self
                    action:@selector(filterButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *saveButtonBack = [[UIImageView alloc] init];
    [saveButtonBack setImage:[UIImage imageNamed:@"save.png"]];
    [innerSubView addSubview:saveButtonBack];
    
    UIButton *saveToGalleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveToGalleryButton setTitle:@"Save To Library" forState:UIControlStateNormal];
    saveToGalleryButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    saveToGalleryButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [saveToGalleryButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[saveButton setImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    [innerSubView addSubview:saveToGalleryButton];
    
    [saveToGalleryButton addTarget:self
                    action:@selector(saveToGalleryButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *shareLabelBack = [[UIImageView alloc] init];
    [shareLabelBack setImage:[UIImage imageNamed:@"share.png"]];
    [innerSubView addSubview:shareLabelBack];
    
    UIButton *shareLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareLabelButton setTitle:@"Share On" forState:UIControlStateNormal];
    shareLabelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    shareLabelButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [shareLabelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [innerSubView addSubview:shareLabelButton];
    
    UIButton *instaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [instaButton setImage:[UIImage imageNamed:@"instagram.png"] forState:UIControlStateNormal];
    [innerSubView addSubview:instaButton];
    
    [instaButton addTarget:self
                    action:@selector(instaButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[facebookButton setTitle:@"Facebook" forState:UIControlStateNormal];
    //[facebookButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fbButton setImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
    [innerSubView addSubview:fbButton];
    
    [fbButton addTarget:self
                    action:@selector(fbButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [twitterButton setImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
    [innerSubView addSubview:twitterButton];
    [twitterButton addTarget:self
                    action:@selector(twitterButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"mClose.png"] forState:UIControlStateNormal];
    //[closeButton setImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
    [innerSubView addSubview:closeButton];
    
    [closeButton addTarget:self
                       action:@selector(closeButtonAction:)
             forControlEvents:UIControlEventTouchUpInside];
    
    if(IS_IPAD)
    {
        filterButton.titleLabel.font = [UIFont systemFontOfSize:28];
        saveToGalleryButton.titleLabel.font = [UIFont systemFontOfSize:28];
        shareLabelButton.titleLabel.font = [UIFont systemFontOfSize:28];
        
        innerSubView.frame = CGRectMake(10,
                                        self.view.frame.size.height,
                                        self.view.frame.size.width-20, 300);
        
        filterButtonBack.frame = CGRectMake(15, 10, 46, 38);
        filterButton.frame = CGRectMake(65,10,100,38);
        //[filterButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
        
        saveButtonBack.frame = CGRectMake(15, 70, 46, 38);
        saveToGalleryButton.frame = CGRectMake(65,70,250,38);
        //[saveToGalleryButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
        
        shareLabelBack.frame = CGRectMake(15, 125, 46, 38);
        shareLabelButton.frame = CGRectMake(65,125,200,38);
        //[shareLabelButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
        
        instaButton.frame = CGRectMake(215,119,50,50);
        fbButton.frame = CGRectMake(275,119,50,50);
        twitterButton.frame = CGRectMake(335,119,50,50);
        
        closeButton.frame = CGRectMake(innerSubView.frame.size.width/2 - 35,
                                       innerSubView.frame.size.height - 70,70,70);

    }
    else
    {
        if(IS_IPHONE_X)
        {
            innerSubView.frame = CGRectMake(10,
                                            self.view.frame.size.height,
                                            self.view.frame.size.width-20, 150);
            filterButtonBack.frame = CGRectMake(15, 15, 23, 19);
            filterButton.frame = CGRectMake(42,15,90,19);
            //[filterButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
            
            saveButtonBack.frame = CGRectMake(15, 45, 25, 19);
            saveToGalleryButton.frame = CGRectMake(42,45,150,19);
            //[saveToGalleryButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
            
            shareLabelBack.frame = CGRectMake(15, 75, 23, 19);
            shareLabelButton.frame = CGRectMake(42,75,150,19);
            //[shareLabelButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
            
            instaButton.frame = CGRectMake(150,67.5,30,30);
            fbButton.frame = CGRectMake(190,67.5,30,30);
            twitterButton.frame = CGRectMake(230,67.5,30,30);
            
            closeButton.frame = CGRectMake(innerSubView.frame.size.width/2 - 20,
                                           innerSubView.frame.size.height - 40,40,40);
        }
        else
        {
            innerSubView.frame = CGRectMake(10,
                                            self.view.frame.size.height,
                                            self.view.frame.size.width-20, 150);
            filterButtonBack.frame = CGRectMake(15, 15, 23, 19);
            filterButton.frame = CGRectMake(42,15,90,19);
            //[filterButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
            
            saveButtonBack.frame = CGRectMake(15, 45, 25, 19);
            saveToGalleryButton.frame = CGRectMake(42,45,150,19);
            //[saveToGalleryButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
            
            shareLabelBack.frame = CGRectMake(15, 75, 23, 19);
            shareLabelButton.frame = CGRectMake(42,75,150,19);
            //[shareLabelButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
            
            instaButton.frame = CGRectMake(150,67.5,30,30);
            fbButton.frame = CGRectMake(190,67.5,30,30);
            twitterButton.frame = CGRectMake(230,67.5,30,30);
            
            closeButton.frame = CGRectMake(innerSubView.frame.size.width/2 - 20,
                                           innerSubView.frame.size.height - 40,40,40);
        }
        
    }
    
    subEditorView.hidden = YES;
}
-(void)filterButtonAction:(UIButton*)sender
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:subEditorImageView.image];
    [editor setCustomToolName:@"CLFilterTool"];
    editor.delegate = self;
    [self presentViewController:editor animated:YES completion:nil];
}
-(void)saveToGalleryButtonAction:(UIButton*)sender
{
    UIGraphicsBeginImageContextWithOptions(subEditorImageView.frame.size,
                                           YES,0.0f);
    //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
    [[subEditorImageView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(outputImage, nil, nil, nil);
}
-(void)instaButtonAction:(UIButton*)sender
{
    [self doInstagramShare];
}
-(void)fbButtonAction:(UIButton*)sender
{
    [self doFacebookShare];
}
-(void)twitterButtonAction:(UIButton*)sender
{
    [self doTwitterShare];
}
-(void)closeButtonAction:(UIButton*)sender
{
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         innerSubView.frame = CGRectMake(10,
                                                         self.view.frame.size.height,
                                                         self.view.frame.size.width-20, 150);
                         
                     }completion:^(BOOL finished){
                         UIButton *galleryViewTempButton = (UIButton *)[self.view viewWithTag:(selectedIndexNumber+10000)];
                         [galleryViewTempButton setImage:subEditorImageView.image forState:UIControlStateNormal];
                         
                         UIImage *finalImage =subEditorImageView.image;
                         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                         NSString *documentsDirectory = [paths objectAtIndex:0];
                         if(finalImage != nil)
                         {
                             NSString *imageFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:
                                                        [NSString stringWithFormat:@"Image%ld.jpg",(totalGalleryImages-selectedIndexNumber-1)]];
                             
                             // Save image.
                             UIImage *tempImageFromURL = finalImage;
                             
                             [UIImagePNGRepresentation(tempImageFromURL) writeToFile:imageFilePath atomically:YES];
                         }
                         
                         
                         subEditorView.hidden = YES;
                         
                     }];
    
    
    
}
- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    //[_photo setImage:image];
    //[_dropShadow setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2f]];
    subEditorImageView.image = image;
    [editor dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imageEditor:(CLImageEditor *)editor willDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled
{
    //[self refreshImageView];
    
}
-(void)setUpperView
{
    upperView = [[UIView alloc] init];
    upperView.backgroundColor = RGBE(254, 251, 239);
    [self.view addSubview:upperView];
    
    menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self
                       action:@selector(menuButtonAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [upperView addSubview:menuButton];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.text = @"Birthday Bash";
    [titleLabel setTextColor:RGBE(255, 200, 7)];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //xr[upperView addSubview:titleLabel];
    
    menuShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuShopButton setImage:[UIImage imageNamed:@"menuShop.png"] forState:UIControlStateNormal];
    [menuShopButton addTarget:self
                        action:@selector(menuShopButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
    [upperView addSubview:menuShopButton];
    if (IS_IPAD)
    {
        [titleLabel setFont:[UIFont systemFontOfSize:35]];
        
        upperView.frame = CGRectMake(0, 0, self.view.frame.size.width, 70);
        menuButton.frame = CGRectMake(10, 12.5, 45, 45);
        menuShopButton.frame = CGRectMake(self.view.frame.size.width - 10-45, 12.5, 45, 45);
        titleLabel.frame = CGRectMake(self.view.frame.size.width/2 - 150, 0, 300, 70);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            upperView.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
            menuButton.frame = CGRectMake(15, 12.5, 35, 35);
            menuShopButton.frame = CGRectMake(self.view.frame.size.width - 15-35, 12.5, 35, 35);
            titleLabel.frame = CGRectMake(self.view.frame.size.width/2 - 74, 30, 150, 30);
        }
        else
        {
            upperView.frame = CGRectMake(0, 0, self.view.frame.size.width, 45);
            menuButton.frame = CGRectMake(5, 7.5, 30, 30);
            menuShopButton.frame = CGRectMake(self.view.frame.size.width - 5-30, 7.5, 30, 30);
            titleLabel.frame = CGRectMake(self.view.frame.size.width/2 - 75, 0, 150, 45);
        }
    }
}
-(void)menuButtonAction:(UIButton*)sender
{
    SettingsViewController * vc = [[SettingsViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)menuShopButtonAction:(UIButton*)sender
{
    [Config sharedInstance].purchaseIDType = NoType;
    ShopViewController * vc = [ShopViewController sharedInstance];
    [vc setPackNumber];
    //ShopViewController * vc = [[ShopViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)setPhotoGalleryScrollView
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //2) Create the full file path by appending the desired file name
    NSString *notificationListFilePath = [documentsDirectory stringByAppendingPathComponent:@"notifications.arr"];
    
    //Load the array
    NSMutableArray *notificationList = [[NSMutableArray alloc] initWithContentsOfFile: notificationListFilePath];
    NSInteger arrayCount = notificationList.count;
    
    
    totalGalleryImages = arrayCount;
    NSInteger totalRows = (totalGalleryImages/2) + (totalGalleryImages%2);
    
    UILabel *projectNameLabel = [[UILabel alloc] init];
    if(IS_IPAD)
    {
        [projectNameLabel setFont:[UIFont boldSystemFontOfSize:40]];
        projectNameLabel.frame = CGRectMake(5,80,
                                            250, 50);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            [projectNameLabel setFont:[UIFont boldSystemFontOfSize:25]];
            projectNameLabel.frame = CGRectMake(5,70,
                                                250, 30);
        }
        else
        {
            [projectNameLabel setFont:[UIFont boldSystemFontOfSize:25]];
            projectNameLabel.frame = CGRectMake(5,55,
                                                250, 30);
        }
    }
    
    [projectNameLabel setText:@"My Projects"];
    
    //[projectNameLabel setTextColor:RGBE(255, 200, 7)];
    [projectNameLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:projectNameLabel];
    
    UIScrollView *topScrollview=[[UIScrollView alloc] init];
    if(IS_IPAD)
    {
        topScrollview.frame = CGRectMake(0,140,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height - 140 - 200);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            topScrollview.frame = CGRectMake(0,110,
                                             self.view.frame.size.width,
                                             self.view.frame.size.height - 110 - 120);
        }
        else
        {
            topScrollview.frame = CGRectMake(0,95,
                                             self.view.frame.size.width,
                                             self.view.frame.size.height - 95 - 100);
        }
    }
    
    
    topScrollview.showsHorizontalScrollIndicator=NO;
    topScrollview.showsVerticalScrollIndicator=NO;
    //topScrollview.backgroundColor = [UIColor grayColor];
    topScrollview.scrollEnabled=YES;
    topScrollview.userInteractionEnabled=YES;
    //topScrollview.pagingEnabled = YES;
    [self.view addSubview:topScrollview];
    
    int widthCount = self.view.frame.size.width/2;
    int counter = 0;
    //int yMergin = 10;
    for(int i=0;i<totalGalleryImages;i++)
    {
        UIButton *miniFrameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [miniFrameButton addTarget:self
                            action:@selector(miniFrameButtonAction:)
                  forControlEvents:UIControlEventTouchUpInside];
        miniFrameButton.tag = 10000+i;
        NSString *imageNameFromFile = [NSString stringWithFormat:@"Image%ld.jpg",(totalGalleryImages-i-1)];
        NSString *imageFilePath = [paths[0] stringByAppendingPathComponent:imageNameFromFile];
        UIImage *imageFromCache = [UIImage imageWithContentsOfFile:imageFilePath];
        [miniFrameButton setImage:imageFromCache forState:UIControlStateNormal];
        [miniFrameButton setContentMode:UIViewContentModeCenter];
        [[miniFrameButton imageView] setContentMode: UIViewContentModeScaleAspectFill];
        [miniFrameButton.layer setBorderWidth:3];
        [miniFrameButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        if(i%2 == 0)
        {
            if(IS_IPAD)
            {
                miniFrameButton.frame = CGRectMake(self.view.frame.size.width/4 - (self.view.frame.size.width/2-50)/2,
                                                   counter*(self.view.frame.size.width/2),
                                                   self.view.frame.size.width/2-50,
                                                   self.view.frame.size.width/2-50);
            }
            else
            {
                miniFrameButton.frame = CGRectMake(self.view.frame.size.width/4 - (self.view.frame.size.width/2-15)/2,
                                                   counter*(self.view.frame.size.width/2),
                                                   self.view.frame.size.width/2-15,
                                                   self.view.frame.size.width/2-15);
            }
            
            
        }
        else
        {
            if(IS_IPAD)
            {
                miniFrameButton.frame = CGRectMake(self.view.frame.size.width/2 + self.view.frame.size.width/4 - (self.view.frame.size.width/2-50)/2,
                                                   counter*(self.view.frame.size.width/2),
                                                   self.view.frame.size.width/2-50,
                                                   self.view.frame.size.width/2-50);
            }
            else
            {
                miniFrameButton.frame = CGRectMake(self.view.frame.size.width/2 + self.view.frame.size.width/4 - (self.view.frame.size.width/2-15)/2,
                                                   counter*(self.view.frame.size.width/2),
                                                   self.view.frame.size.width/2-15,
                                                   self.view.frame.size.width/2-15);
            }
            
            
            counter += 1;
            //widthCount += self.view.frame.size.width/2;
        }
        [topScrollview addSubview:miniFrameButton];
    }
    topScrollview.contentSize = CGSizeMake(self.view.frame.size.width,(widthCount*totalRows));
}
-(void)miniFrameButtonAction:(UIButton*)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    selectedIndexNumber = sender.tag - 10000;
    NSString *imageNameFromFile = [NSString stringWithFormat:@"Image%ld.jpg",(totalGalleryImages-selectedIndexNumber-1)];
    NSString *imageFilePath = [paths[0] stringByAppendingPathComponent:imageNameFromFile];
    UIImage *imageFromCache = [UIImage imageWithContentsOfFile:imageFilePath];
    
    [self showSubEditorView:imageFromCache];
    //[self showSubEditorView];
}
-(void)showSubEditorView:(UIImage*)_image
//-(void)showSubEditorView
{
    subEditorImageView.image = _image;
    subEditorView.hidden = NO;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if(IS_IPAD)
                         {
                             innerSubView.frame = CGRectMake(10,
                                                             self.view.frame.size.height - 300,
                                                             self.view.frame.size.width-20, 300);
                         }
                         else
                         {
                             if(IS_IPHONE_X)
                             {
                                 innerSubView.frame = CGRectMake(10,
                                                                 self.view.frame.size.height - 170,
                                                                 self.view.frame.size.width-20, 150);
                             }
                             else
                             {
                                 innerSubView.frame = CGRectMake(10,
                                                                 self.view.frame.size.height - 150,
                                                                 self.view.frame.size.width-20, 150);
                             }
                         }
                         
                         
                     }completion:^(BOOL finished){
                         
                         
                     }];
    
    
    //subEditorImageView.image = [UIImage imageNamed:@"bghome.png"];
    
}
-(void)setPurchaseScrollView
{
    purchaserScrollView = [[UIScrollView alloc] init];
    
    if(IS_IPAD)
    {
        purchaserScrollView.frame = CGRectMake(0,71,
                                        self.view.frame.size.width,
                                            300);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            purchaserScrollView.frame = CGRectMake(0,61,
                                                   self.view.frame.size.width,
                                                   150);
        }
        else
        {
            purchaserScrollView.frame = CGRectMake(0,46,
                                                   self.view.frame.size.width,
                                                   150);
        }
    }
    
    purchaserScrollView.showsHorizontalScrollIndicator=NO;
    //purchaserScrollView.backgroundColor = [UIColor grayColor];
    purchaserScrollView.scrollEnabled=YES;
    purchaserScrollView.userInteractionEnabled=YES;
    purchaserScrollView.pagingEnabled = YES;
    [self.view addSubview:purchaserScrollView];
    
    int widthCount = 0;
    for(int i=0;i<1;i++)
    {
        UIButton *purchaserButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [purchaserButton addTarget:self
                            action:@selector(purchaserButtonAction:)
                  forControlEvents:UIControlEventTouchUpInside];
        [purchaserButton.layer setCornerRadius:15.0f];
        purchaserButton.clipsToBounds = YES;
        [[purchaserButton imageView] setContentMode: UIViewContentModeScaleToFill];
        //[miniFrameButton  setBackgroundColor:[UIColor brownColor]];
        if(i==0)
            [purchaserButton setImage:[UIImage imageNamed:@"inAppImage1.png"]
                             forState:UIControlStateNormal];
        else if(i==1)
            [purchaserButton setImage:[UIImage imageNamed:@"inAppImage2.png"] forState:UIControlStateNormal];
        else if(i==2)
            [purchaserButton setImage:[UIImage imageNamed:@"inAppImage3.png"] forState:UIControlStateNormal];
        else if(i==3)
            [purchaserButton setImage:[UIImage imageNamed:@"inAppImage5.png"] forState:UIControlStateNormal];
        else if(i==4)
            [purchaserButton setImage:[UIImage imageNamed:@"inAppImage4.png"] forState:UIControlStateNormal];
        else if(i==5)
            [purchaserButton setImage:[UIImage imageNamed:@"inAppImage6.png"] forState:UIControlStateNormal];
        if(IS_IPAD)
        {
            purchaserButton.frame = CGRectMake((i * self.view.frame.size.width)+10,
                                               10,
                                               self.view.frame.size.width-20,
                                               280);
        }
        else
        {
            if(IS_IPHONE_X)
            {
                purchaserButton.frame = CGRectMake((i * self.view.frame.size.width)+10,
                                                   5,
                                                   self.view.frame.size.width-20,
                                                   140);
            }
            else
            {
                purchaserButton.frame = CGRectMake((i * self.view.frame.size.width)+10,
                                                   5,
                                                   self.view.frame.size.width-20,
                                                   140);
            }
        }
        
        //miniFrameButton1.tag = i;
        widthCount += self.view.frame.size.width;
        [purchaserScrollView addSubview:purchaserButton];
    }
    if(IS_IPAD)
    {
        purchaserScrollView.contentSize = CGSizeMake(widthCount,280);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            purchaserScrollView.contentSize = CGSizeMake(widthCount,140);
        }
        else
        {
            purchaserScrollView.contentSize = CGSizeMake(widthCount,140);
        }
    }
    
    
    //[NSTimer scheduledTimerWithTimeInterval:5
    //                                 target:self
    //                               selector:@selector(onPurchaserButtonChange)
    //                               userInfo:nil repeats:YES];
    
}
-(void)purchaserButtonAction:(UIButton*)sender
{
    int page = purchaserScrollView.contentOffset.x / purchaserScrollView.frame.size.width;
    if(page==0)
        [Config sharedInstance].purchaseIDType = pack2;
    else if(page==1)
        [Config sharedInstance].purchaseIDType = pack3;
    else if(page==2)
        [Config sharedInstance].purchaseIDType = pack2;
    else if(page==3)
        [Config sharedInstance].purchaseIDType = pack4;
    else if(page==4)
        [Config sharedInstance].purchaseIDType = pack5;
    else if(page==5)
        [Config sharedInstance].purchaseIDType = pack6;
    
    ShopViewController * vc = [ShopViewController sharedInstance];
    [vc setPackNumber];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)onPurchaserButtonChange
{
    int page = purchaserScrollView.contentOffset.x / purchaserScrollView.frame.size.width;
    int nextPage;
    if(page == 5)
        nextPage = 0;
    else
        nextPage = page+1;
    //NSLog(@"scroller Current Page->>>%d",page);
    [UIView animateWithDuration:1.0 animations:^{
        [purchaserScrollView setContentOffset:CGPointMake(purchaserScrollView.frame.size.width*nextPage, 0.0f)];
    }];
}

-(void)setLowerView
{
    lowerView = [[UIView alloc] init];
    
    lowerView.backgroundColor = RGBE(207, 201, 201);
    
    [self.view addSubview:lowerView];
    
    
    
    galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [galleryButton setImage:[UIImage imageNamed:@"mgallery.png"] forState:UIControlStateNormal];
    //[galleryButton setTitle:@"Gallery" forState:UIControlStateNormal];
    [galleryButton addTarget:self action:@selector(galleryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //[galleryButton setBackgroundColor:RGBE(255, 200, 7)];
    galleryButton.clipsToBounds = YES;
    [lowerView addSubview:galleryButton];
    
    cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cameraButton setImage:[UIImage imageNamed:@"mcamera.png"] forState:UIControlStateNormal];
    //[cameraButton setTitle:@"Camera" forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(cameraButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //[cameraButton setBackgroundColor:RGBE(255, 200, 7)];
    cameraButton.clipsToBounds = YES;
    [lowerView addSubview:cameraButton];
    
    giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [giftButton setImage:[UIImage imageNamed:@"mgift.png"] forState:UIControlStateNormal];
    //[giftButton setTitle:@"Camera" forState:UIControlStateNormal];
    [giftButton addTarget:self action:@selector(giftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //[giftButton setBackgroundColor:RGBE(255, 200, 7)];
    giftButton.clipsToBounds = YES;
    [lowerView addSubview:giftButton];
    
    
    if(IS_IPAD)
    {
        [galleryButton.layer setCornerRadius:20];
        [cameraButton.layer setCornerRadius:20];
        [giftButton.layer setCornerRadius:20];
        
        lowerView.frame = CGRectMake(0, self.view.frame.size.height-200,
                                     self.view.frame.size.width, 200);
        galleryButton.frame = CGRectMake(lowerView.frame.size.width/6 - 69.5, 15, 139, 170);
        cameraButton.frame = CGRectMake(galleryButton.frame.origin.x + lowerView.frame.size.width/3,
                                        15, 139, 170);
        giftButton.frame = CGRectMake(cameraButton.frame.origin.x + lowerView.frame.size.width/3,
                                      15, 139, 170);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            //lowerView.backgroundColor = [UIColor whiteColor];
            [galleryButton.layer setCornerRadius:10];
            [cameraButton.layer setCornerRadius:10];
            [giftButton.layer setCornerRadius:10];
            lowerView.frame = CGRectMake(0, self.view.frame.size.height-120,
                                         self.view.frame.size.width, 120);
            galleryButton.frame = CGRectMake(lowerView.frame.size.width/6 - 32.5, 10, 65, 80);
            cameraButton.frame = CGRectMake(galleryButton.frame.origin.x + lowerView.frame.size.width/3,
                                            10, 65, 80);
            giftButton.frame = CGRectMake(cameraButton.frame.origin.x + lowerView.frame.size.width/3,
                                          10, 65, 80);
        }
        else
        {
            [galleryButton.layer setCornerRadius:10];
            [cameraButton.layer setCornerRadius:10];
            [giftButton.layer setCornerRadius:10];
            lowerView.frame = CGRectMake(0, self.view.frame.size.height-100,
                                         self.view.frame.size.width, 100);
            galleryButton.frame = CGRectMake(lowerView.frame.size.width/6 - 32.5, 10, 65, 80);
            cameraButton.frame = CGRectMake(galleryButton.frame.origin.x + lowerView.frame.size.width/3,
                                            10, 65, 80);
            giftButton.frame = CGRectMake(cameraButton.frame.origin.x + lowerView.frame.size.width/3,
                                          10, 65, 80);
        }
    }
    
    
}
-(void)cameraButtonAction:(UIButton*)sender
{
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.allowsEditing = NO;
    picker.delegate   = self;
    picker.sourceType = type;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    //EditorViewController * vc = [[EditorViewController alloc] init];
    //[self presentViewController:vc animated:YES completion:nil];
    
}
-(void)galleryButtonAction:(UIButton*)sender
{
    DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
    cont.delegate = self;
    cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
    cont.nMaxCount = 1;
    cont.nColumnCount = 1 + 2;
    [self presentViewController:cont animated:YES completion:nil];
    
}
-(void)giftButtonAction:(UIButton*)sender
{
    GiftBoxView * vc = [[GiftBoxView alloc] init];
    //[vc setImage:aSelected[0]];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    
    
    //tempImage = aSelected[0];
    
    
    
    //[self markFaces:[CIImage imageWithCGImage:mainImageView.image.CGImage]];
    [self dismissViewControllerAnimated:YES completion:^
     {
 
         EditorViewController * vc = [[EditorViewController alloc] init];
         [vc setImage:aSelected[0]];
         [self presentViewController:vc animated:YES completion:nil];
     }];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //tempImage = image1;
    //tempImage = image1;
    UIImage *image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^
     {
         EditorViewController * vc = [[EditorViewController alloc] init];
         [vc setImage:image1];
         [self presentViewController:vc animated:YES completion:nil];
     }];
}
-(void)doInstagramShare
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
    
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        
        NSURL *url;
        docFile.delegate = self;
        
        UIImage *tempImage = subEditorImageView.image;
        
        
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
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //  NSString *str=[NSString stringWithFormat:@"%@   \n Author : %@",textview1.text,author.text];
        //  [controller setInitialText:str];
        
        //[controller addURL:[NSURL URLWithString:rateLink]];
        //[controller setInitialText:appleName];
        [controller addImage:subEditorImageView.image];
        //[controller addImage:self.tempImage];
        
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
        
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        //  NSString *str=[NSString stringWithFormat:@"%@   \n Author : %@",textview1.text,author.text];
        //  [tweetSheet setInitialText:str];
        [tweetSheet addImage:subEditorImageView.image];
        //[self presentViewController:tweetSheet animated:YES completion:nil];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
