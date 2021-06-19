//
//  SettingsViewController.m
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 3/7/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isImageQuslityHighStatus = [[NSUserDefaults standardUserDefaults] boolForKey:@"isImageQualityHigh"];
    screenSizeXY = [[UIScreen mainScreen] bounds];
    customButtonColor = [UIColor colorWithRed:14/255.0
                                        green:18/255.0 blue:23/255.0 alpha:1];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        fontSize = 26;
    }
    else
    {
        fontSize = 13;
    }
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self setButtons];
    [self setTipsView];
}
-(void)setTipsView
{
    tipsView = [[UIView alloc] init];
    tipsView.backgroundColor = [UIColor grayColor];
    tipsView.layer.cornerRadius = 10;
    tipsView.layer.borderWidth = 2;
    tipsView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:tipsView];
    
    UIImageView *tipsImageView = [[UIImageView alloc] init];
    tipsImageView.image = [UIImage imageNamed:@"Tips.png"];
    [tipsView addSubview:tipsImageView];
    
    tipsCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tipsCloseButton setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [tipsCloseButton addTarget:self
                    action:@selector(crossButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [tipsView addSubview:tipsCloseButton];
    tipsView.hidden = YES;
    if(IS_IPAD)
    {
        tipsView.frame = CGRectMake(self.view.frame.size.width/2 - 250,
                                    self.view.frame.size.height/2 - 340,
                                    500, 680);
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
}
-(UIImage *)setBackgroundImageByColor:(UIColor *)backgroundColor withFrame:(CGRect )rect cornerRadius:(float)radius{
    
    UIView *tcv = [[UIView alloc] initWithFrame:rect];
    [tcv setBackgroundColor:backgroundColor];
    
    CGSize gcSize = tcv.frame.size;
    UIGraphicsBeginImageContext(gcSize);
    [tcv.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    const CGRect RECT = CGRectMake(0, 0, image.size.width, image.size.height);;
    [[UIBezierPath bezierPathWithRoundedRect:RECT cornerRadius:radius] addClip];
    [image drawInRect:RECT];
    UIImage* imageNew = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageNew;
}
-(void) setButtons
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                                  screenSizeXY.size.width,
                                                                  60)];
        [settingsLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else
    {
        settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                                  screenSizeXY.size.width,
                                                                  30)];
        [settingsLabel setFont:[UIFont systemFontOfSize:15]];
    }
    [settingsLabel setText:@"Settings"];
    
    [settingsLabel setTextColor: [UIColor whiteColor]];
    settingsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:settingsLabel];
    
    
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self
                    action:@selector(onClose:)
          forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"Done" forState:UIControlStateNormal];
    
    //closeButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    closeButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[rateUsButton setImage:[UIImage imageNamed:@"giftBox.png"] forState:UIControlStateNormal];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        closeButton.titleLabel.font = [UIFont systemFontOfSize:30];
        closeButton.frame = CGRectMake(screenSizeXY.size.width-100, 0,
                                       100, 60);
    }
    else
    {
        closeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        closeButton.frame = CGRectMake(screenSizeXY.size.width-50, 0,
                                       50, 30);
    }
    [self.view addSubview:closeButton];
    
    
    rateUsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rateUsButton addTarget:self
                     action:@selector(onRateUs:)
           forControlEvents:UIControlEventTouchUpInside];
    [rateUsButton setTitle:@"Rate US" forState:UIControlStateNormal];
    rateUsButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    rateUsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rateUsButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [rateUsButton setBackgroundColor:customButtonColor];
    //[rateUsButton setImage:[UIImage imageNamed:@"giftBox.png"] forState:UIControlStateNormal];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        rateUsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        rateUsButton.frame = CGRectMake(0, 100, screenSizeXY.size.width, 60);
    }
    else
    {
        rateUsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        rateUsButton.frame = CGRectMake(0, 50, screenSizeXY.size.width, 30);
    }
    
    [rateUsButton setBackgroundImage:[self setBackgroundImageByColor:[UIColor grayColor]
                                                           withFrame:rateUsButton.frame cornerRadius:0] forState:UIControlStateHighlighted];
    [self.view addSubview:rateUsButton];
    
    
    feedbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [feedbackButton addTarget:self
                       action:@selector(onFeedBack:)
             forControlEvents:UIControlEventTouchUpInside];
    [feedbackButton setTitle:@"Send Feedback" forState:UIControlStateNormal];
    feedbackButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    feedbackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    feedbackButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[rateUsButton setImage:[UIImage imageNamed:@"giftBox.png"] forState:UIControlStateNormal];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        feedbackButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        feedbackButton.frame = CGRectMake(0, 162, screenSizeXY.size.width, 60);
    }
    else
    {
        feedbackButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        feedbackButton.frame = CGRectMake(0, 81, screenSizeXY.size.width, 30);
    }
    [feedbackButton setBackgroundColor:customButtonColor];
    
    [feedbackButton setBackgroundImage:[self setBackgroundImageByColor:[UIColor grayColor]
                                                             withFrame:feedbackButton.frame cornerRadius:0] forState:UIControlStateHighlighted];
    [self.view addSubview:feedbackButton];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        exportLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 240,
                                                                screenSizeXY.size.width,
                                                                60)];
    }
    else
    {
        exportLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120,
                                                                screenSizeXY.size.width,
                                                                30)];
    }
    [exportLabel setText:@"EXPORT"];
    [exportLabel setFont:[UIFont systemFontOfSize:fontSize]];
    [exportLabel setTextColor: [UIColor grayColor]];
    exportLabel.textAlignment = NSTextAlignmentLeft;
    //settingsLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.view addSubview:exportLabel];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        imageQualityView=[[UIView alloc]initWithFrame:CGRectMake(0,
                                                                 302,
                                                                 screenSizeXY.size.width,60)];
    }
    else
    {
        imageQualityView=[[UIView alloc]initWithFrame:CGRectMake(0,
                                                                 151,
                                                                 screenSizeXY.size.width,30)];
    }
    [imageQualityView setBackgroundColor:customButtonColor];
    //imageQualityView.layer.borderWidth = 2;
    //imageQualityView.layer.cornerRadius = 20;
    //imageQualityView.layer.borderColor = [UIColor brownColor].CGColor;
    [self.view addSubview:imageQualityView];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        imageQualityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,
                                                                      screenSizeXY.size.width,
                                                                      60)];
    }
    else
    {
        imageQualityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,
                                                                      screenSizeXY.size.width,
                                                                      30)];
    }
    [imageQualityLabel setText:@"Image Quality"];
    [imageQualityLabel setFont:[UIFont systemFontOfSize:fontSize]];
    [imageQualityLabel setTextColor: [UIColor whiteColor]];
    imageQualityLabel.textAlignment = NSTextAlignmentLeft;
    //settingsLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [imageQualityView addSubview:imageQualityLabel];
    
    
    imageQualitySegment = [[UISegmentedControl alloc]
                           initWithItems:[NSArray
                                          arrayWithObjects:@"high", @"low", nil]];
    //[imageQualitySegment setSegmentedControlStyle:UISegmentedControlStyleBar];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        imageQualitySegment.frame = CGRectMake(screenSizeXY.size.width/2 + 40,8,
                                               screenSizeXY.size.width/3 - 20, 44);
    }
    else
    {
        imageQualitySegment.frame = CGRectMake(screenSizeXY.size.width/2 + 20,4,
                                               screenSizeXY.size.width/3 - 10, 22);
    }
    //self.navigationItem.titleView = mainSegment;
    if(isImageQuslityHighStatus == NO)
        imageQualitySegment.selectedSegmentIndex = 1;
    if(isImageQuslityHighStatus == YES)
        imageQualitySegment.selectedSegmentIndex = 0;
    [imageQualitySegment addTarget:self action:@selector(imageQualitySegmentControl:) forControlEvents: UIControlEventValueChanged];
    [imageQualityView addSubview:imageQualitySegment];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        purchaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 380,
                                                                  screenSizeXY.size.width,
                                                                  60)];
    }
    else
    {
        purchaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 190,
                                                                  screenSizeXY.size.width,
                                                                  30)];
    }
    [purchaseLabel setText:@"HELP"];
    [purchaseLabel setFont:[UIFont systemFontOfSize:fontSize]];
    [purchaseLabel setTextColor: [UIColor grayColor]];
    purchaseLabel.textAlignment = NSTextAlignmentLeft;
    //settingsLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.view addSubview:purchaseLabel];
    
    tipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tipsButton addTarget:self
                  action:@selector(tipsButtonAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [tipsButton setTitle:@"Tips" forState:UIControlStateNormal];
    tipsButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    tipsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    tipsButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[rateUsButton setImage:[UIImage imageNamed:@"giftBox.png"] forState:UIControlStateNormal];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        tipsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        tipsButton.frame = CGRectMake(0, 442, screenSizeXY.size.width, 60);
    }
    else
    {
        tipsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        tipsButton.frame = CGRectMake(0, 221, screenSizeXY.size.width, 30);
    }
    [tipsButton setBackgroundColor:customButtonColor];
    [tipsButton setBackgroundImage:[self setBackgroundImageByColor:[UIColor grayColor]
                                                        withFrame:tipsButton.frame cornerRadius:0] forState:UIControlStateHighlighted];
    [self.view addSubview:tipsButton];
    
    
}
- (void)onRateUs:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL
                                                URLWithString:rateLink]];
}
- (void)onFeedBack: (id)sender
{
    NSString *emailTitle;
    NSMutableString *emailHTML;
    
    emailTitle = @"Merry Christmass";
    
    emailHTML = [NSMutableString string];
    [emailHTML appendString:@"<html><body><p>"];
    [emailHTML appendString:rateLink];
    [emailHTML appendString:@"</p></body></html>"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    
    
    [mc setSubject:emailTitle];
    [mc setMessageBody:emailHTML isHTML:YES];
    
    [self presentViewController:mc animated:YES completion:nil];
}
- (void)tipsButtonAction: (id)sender
{
    tipsView.hidden = NO;
}

- (void)imageQualitySegmentControl:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isImageQualityHigh"];
    }
    else if(segment.selectedSegmentIndex == 1)
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isImageQualityHigh"];
    }
}
- (void)onClose: (id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

# pragma Mail Compose Delegate

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"Saved");
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Sent");
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Error: %@", [error localizedDescription]);
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
