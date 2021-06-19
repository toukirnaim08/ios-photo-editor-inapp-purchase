
#import "GiftBoxView.h"
//#import "SavedViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
//#import "ALAssetsLibrary+CustomPhotoAlbum.h"
//#import "Configuration.h"

@interface GiftBoxView ()
{
    UIView *proView;
    CGRect screenSizeXY;
    
    UILabel *upLabel;
    UILabel *lowLabel;
    
    UIImageView *cardImageView;
    
    UIButton *saveButton;
    UIButton *shareButton;
    
    UIColor *customTitleColor;
    
}

@end

@implementation GiftBoxView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //customTitleColor = [UIColor colorWithRed:32/255.0
    //                                   green:33/255.0 blue:37/255.0 alpha:1];
    
    customTitleColor = [UIColor whiteColor];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIImageView *bgImageVIew = [[UIImageView alloc] initWithFrame: self.view.bounds];
    bgImageVIew.image = [UIImage imageNamed: @"GiftBoxBackImage.png"];
    [self.view addSubview: bgImageVIew];
    screenSizeXY = [[UIScreen mainScreen] bounds];
    
    UIButton *giftBoxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [giftBoxButton addTarget:self
                      action:@selector(onShowGift:)
            forControlEvents:UIControlEventTouchUpInside];
    //[closeButton setTitle:@"Show View" forState:UIControlStateNormal];
    [giftBoxButton setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        giftBoxButton.frame = CGRectMake(20, 20, 50.0, 50.0);
    }
    else
        giftBoxButton.frame = CGRectMake(10, 10, 25.0, 25.0);
    [self.view addSubview:giftBoxButton];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50,
                                                            screenSizeXY.size.width,
                                                            30)];
        [upLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24]];
    }
    else
    {
        upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30,
                                                            screenSizeXY.size.width,
                                                            15)];
        [upLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    }
    [upLabel setText:@"Todays Gift"];
    
    [upLabel setTextColor: customTitleColor];
    upLabel.textAlignment = NSTextAlignmentCenter;
    //upLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.view addSubview:upLabel];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        lowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 82,
                                                             screenSizeXY.size.width,
                                                             30)];
        [lowLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24]];
    }
    else
    {
        lowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 46,
                                                        screenSizeXY.size.width,
                                                        15)];
        [lowLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    }
    [lowLabel setText:@"Came back tomorrow you will get another"];
    
    [lowLabel setTextColor: customTitleColor];
    lowLabel.textAlignment = NSTextAlignmentCenter;
    //lowLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.view addSubview:lowLabel];
    
    
    float tempWidth ;
    float tempHeight ;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         tempWidth = screenSizeXY.size.width/2;
         tempHeight = screenSizeXY.size.height/2;
    }
    else
    {
         tempWidth = (screenSizeXY.size.width*2)/3;
         tempHeight = (screenSizeXY.size.height*2)/3;
    }
    cardImageView = [[UIImageView alloc]
                 initWithFrame:CGRectMake(screenSizeXY.size.width/2 - tempWidth/2,
                                          screenSizeXY.size.height/2 - tempHeight/2,
                                          tempWidth, tempHeight)];
    [cardImageView setImage:[UIImage imageNamed:@"Card1.png"]];
    [cardImageView setContentMode:UIViewContentModeScaleAspectFill];
    //cardImageView.layer.masksToBounds = YES;
    //cardImageView.layer.borderColor = customTitleColor.CGColor;
    //cardImageView.layer.borderWidth = 3;
    //cardImageView.layer.cornerRadius = 15;
    
    //cardImageView.layer.shadowRadius  = 2.0f;
    cardImageView.layer.shadowColor   = [UIColor blackColor].CGColor;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cardImageView.layer.shadowOffset = CGSizeMake(20, 20);
        cardImageView.layer.shadowRadius = 10.0;
        cardImageView.layer.shadowOpacity = 0.12;
    }
    else
    {
        cardImageView.layer.shadowOffset = CGSizeMake(10, 10);
        cardImageView.layer.shadowRadius = 5.0;
        cardImageView.layer.shadowOpacity = 0.6;
    }
    
    cardImageView.layer.masksToBounds = NO;
    
    [self.view addSubview:cardImageView];
    
    float tempX ;
    float tempY ;
    float offset ;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         tempX = screenSizeXY.size.width/4 - 80;
         //tempY = cardImageView.frame.origin.y + tempHeight + 40;
        tempY = cardImageView.frame.origin.y + tempHeight + 130;
         offset = screenSizeXY.size.width/2;
    }
    else
    {
         tempX = screenSizeXY.size.width/4 - 40;
         tempY = cardImageView.frame.origin.y + tempHeight + 20;
         offset = screenSizeXY.size.width/2;
    }
    
    
    saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton addTarget:self
                     action:@selector(onSave:)
           forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    
    //saveButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    saveButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    saveButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [saveButton setBackgroundColor:[UIColor grayColor]];
    [saveButton.layer setCornerRadius:10.0f];
    //buttonGoPro.layer.borderWidth = 10.0;
    saveButton.layer.masksToBounds = YES;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        saveButton.frame = CGRectMake(self.view.frame.size.width/2 - 80, tempY, 160, 80);
        saveButton.titleLabel.font = [UIFont systemFontOfSize:30];
    }
    else
    {
        saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
        saveButton.frame = CGRectMake(self.view.frame.size.width/2 - 40, tempY, 80, 40);
    }
    //[flipHorizontal setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:saveButton];
    
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton addTarget:self
                   action:@selector(onShare:)
         forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitle:@"Share" forState:UIControlStateNormal];
    
    //saveButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    shareButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    shareButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [shareButton setBackgroundColor:[UIColor grayColor]];
    [shareButton.layer setCornerRadius:10.0f];
    //buttonGoPro.layer.borderWidth = 10.0;
    shareButton.layer.masksToBounds = YES;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        shareButton.titleLabel.font = [UIFont systemFontOfSize:30];
        shareButton.frame = CGRectMake(tempX + offset, tempY, 160, 80);
    }
    else
    {
        shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
        shareButton.frame = CGRectMake(tempX + offset, tempY, 80, 40);
    }
    //[flipHorizontal setBackgroundColor:[UIColor lightGrayColor]];
    //[self.view addSubview:shareButton];
    
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(swipeDown:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeRecognizer];
    
}
- (void)swipeDown:(UIGestureRecognizer *)sender
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)onShowGift: (id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void) onShare: (id)sender
{
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    SavedViewController *sfvc = [storyboard instantiateViewControllerWithIdentifier:@"savePage"];
    [sfvc gimmePhoto:cardImageView];
    [sfvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:sfvc animated:YES completion:nil];*/
}
-(void) onSave: (id)sender
{
    /*UIImage *photo = [UIImage imageNamed:@"Card1.png"];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
 
    [library saveImage:photo
               toAlbum:[Configuration appName]
   withCompletionBlock:^(NSError *error) {
       if (error!=nil)
       {
           NSLog(@"Big error: %@", [error description]);
       }
   }];*/
    
    UIGraphicsBeginImageContextWithOptions(cardImageView.frame.size,
                                           YES,0.0f);
    //[[tempImageView layer] drawInContext:UIGraphicsGetCurrentContext()];
    [[cardImageView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(outputImage, nil, nil, nil);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card Saved Successfully"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil,nil];
    //alert.tag=1001;
    
    [alert show];
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
