//
//  TempViewController.m
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/20/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()

@end

@implementation ShopViewController
@synthesize editorViewDelegate,moreViewDelegate,shareViewDelegate;
static ShopViewController *_ShopViewController = nil;

+(ShopViewController *)sharedInstance {
    @synchronized([ShopViewController class]) {
        if (!_ShopViewController)
        {
            _ShopViewController = [[self alloc] init];
            
        }
        return _ShopViewController;
    }
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat tx =  self.view.frame.size.width;
    firstTimeEntry = YES;
    self.view.backgroundColor = RGBE(216, 216, 216);
    //packInedxArr = [NSMutableArray array];
    //packTextArr = [NSMutableArray array];
    [PaymentManager sharedInstance].paymentDelegate = self;
    [self setUpperView];
    [self setTableView];
    [self setParallaxView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[tableView reloadData];
    [UIView transitionWithView: tableView
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [tableView reloadData];
     }
                    completion: nil];
    
    
}
-(void)setPackNumber
{
    NSString *title1,*title2,*title3,*title4,*title5,*title6,*title0;
    title0 = @"PARTY Pack";
    title1 = @"CARNIVAL Pack";
    title2 = @"CELEBRATION Pack";
    title3 = @"REMEMBRANCE pack";
    title4 = @"ETERNAL Pack";
    title5 = @"Remove Ads";
    title6 = @"Remove Watermark";
    
    NSString *des1,*des2,*des3,*des4,*des5,*des6,*des0;
    des0 = @"Unlock premium quality Party frames bundle";
    des1 = @"Unlock premium quality Carnival frames bundle";
    des2 = @"Unlock premium quality Celebration frames bundle";
    des3 = @"Unlock premium quality Remembrance frames bundle";
    des4 = @"Unlock premium quality Eternal frames bundle";
    des5 = @"Remove all types of ads";
    des6 = @"Remove watermark from photo";
    
    packInedxArr = [NSMutableArray array];
    packTextArr =[NSMutableArray array];
    packSubTextArr =[NSMutableArray array];
    if([Config sharedInstance].purchaseIDType==NoType)
    {
        packInedxArr = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",nil];
        packTextArr = [NSMutableArray arrayWithObjects:title0,title1,title2,title3,title4,title5,title6,nil];
        packSubTextArr = [NSMutableArray arrayWithObjects:des0,des1,des2,des3,des4,des5,des6,nil];
    }
    if([Config sharedInstance].purchaseIDType==pack2)
    {
        packInedxArr = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",nil];
        packTextArr = [NSMutableArray arrayWithObjects:title0,title1,title2,title3,title4,title5,title6,nil];
        packSubTextArr = [NSMutableArray arrayWithObjects:des0,des1,des2,des3,des4,des5,des6,nil];
    }
    if([Config sharedInstance].purchaseIDType==pack3)
    {
        packInedxArr = [NSMutableArray arrayWithObjects:@"1",@"0",@"2",@"3",@"4",@"5",@"6",nil];
        packTextArr = [NSMutableArray arrayWithObjects:title1,title0,title2,title3,title4,title5,title6,nil];
        packSubTextArr = [NSMutableArray arrayWithObjects:des1,des0,des2,des3,des4,des5,des6,nil];
    }
    if([Config sharedInstance].purchaseIDType==pack4)
    {
        packInedxArr = [NSMutableArray arrayWithObjects:@"2",@"0",@"1",@"3",@"4",@"5",@"6",nil];
        packTextArr = [NSMutableArray arrayWithObjects:title2,title0,title1,title3,title4,title5,title6,nil];
        packSubTextArr = [NSMutableArray arrayWithObjects:des2,des0,des1,des3,des4,des5,des6,nil];
    }
    if([Config sharedInstance].purchaseIDType==pack5)
    {
        packInedxArr = [NSMutableArray arrayWithObjects:@"3",@"0",@"1",@"2",@"4",@"5",@"6",nil];
        packTextArr = [NSMutableArray arrayWithObjects:title3,title0,title1,title2,title4,title5,title6,nil];
        packSubTextArr = [NSMutableArray arrayWithObjects:des3,des0,des1,des2,des4,des5,des6,nil];
    }
    if([Config sharedInstance].purchaseIDType==pack6)
    {
        packInedxArr = [NSMutableArray arrayWithObjects:@"4",@"0",@"1",@"2",@"3",@"5",@"6",nil];
        packTextArr = [NSMutableArray arrayWithObjects:title4,title0,title1,title2,title3,title5,title6,nil];
        packSubTextArr = [NSMutableArray arrayWithObjects:des4,des0,des1,des2,des3,des5,des6,nil];
    }
    if([Config sharedInstance].purchaseIDType==removeAd)
    {
        packInedxArr = [NSMutableArray arrayWithObjects:@"5",@"0",@"1",@"2",@"3",@"4",@"6",nil];
        packTextArr = [NSMutableArray arrayWithObjects:title5,title0,title1,title2,title3,title4,title6,nil];
        packSubTextArr = [NSMutableArray arrayWithObjects:des5,des0,des1,des2,des3,des4,des6,nil];
    }
    if([Config sharedInstance].purchaseIDType==removeMark)
    {
        /*packInedxArr = [NSMutableArray arrayWithObjects:@"6","0",@"1",@"2",@"3",@"4",@"5",nil];
        packTextArr = [NSMutableArray arrayWithObjects:title6,title0,title1,title2,title3,title4,title5,nil];
        packSubTextArr = [NSMutableArray arrayWithObjects:des6,des0,des1,des2,des3,des4,des5,nil];*/
        packInedxArr = [NSMutableArray arrayWithObjects:@"6",@"0",@"1",@"2",@"3",@"4",@"5",nil];
        packTextArr = [NSMutableArray arrayWithObjects:title6,title0,title1,title2,title3,title4,title5,nil];
        packSubTextArr = [NSMutableArray arrayWithObjects:des6,des0,des1,des2,des3,des4,des5,nil];
    }
    
}
-(void)setUpperView
{
    UIView *upperView = [[UIView alloc] init];
    //upperView.backgroundColor = RGBE(13, 40, 67);
    upperView.backgroundColor = RGBE(255, 200, 7);
    [self.view addSubview:upperView];
    
    crossButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [crossButton setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [crossButton addTarget:self
                      action:@selector(crossButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [upperView addSubview:crossButton];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.text = @"STORE";
    [titleLabel setTextColor:[UIColor whiteColor]];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [upperView addSubview:titleLabel];
    
    restoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    restoreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    //[restoreButton setImage:[UIImage imageNamed:@"menuShop.png"] forState:UIControlStateNormal];
    [restoreButton setTitle:@"Restore" forState:UIControlStateNormal];
    [restoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [restoreButton addTarget:self
                       action:@selector(restoreButtonAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [upperView addSubview:restoreButton];
    
    if(IS_IPAD)
    {
        [titleLabel setFont:[UIFont systemFontOfSize:40]];
        restoreButton.titleLabel.font = [UIFont systemFontOfSize:40];
        
        upperView.frame = CGRectMake(0, 0, self.view.frame.size.width, 90);
        crossButton.frame = CGRectMake(10, 20, 50 , 50);
        titleLabel.frame = CGRectMake(self.view.frame.size.width/2 - 90, 0, 180, 90);
        restoreButton.frame = CGRectMake(self.view.frame.size.width -150, 0, 150, 90);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            [titleLabel setFont:[UIFont systemFontOfSize:25]];
            
            
            upperView.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
            crossButton.frame = CGRectMake(5, 40, 30 , 30);
            titleLabel.frame = CGRectMake(self.view.frame.size.width/2 - 45, 30, 90, 50);
            restoreButton.frame = CGRectMake(self.view.frame.size.width -90, 30, 90, 50);
        }
        else
        {
            [titleLabel setFont:[UIFont systemFontOfSize:25]];
            
            upperView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
            crossButton.frame = CGRectMake(5, 10, 30 , 30);
            titleLabel.frame = CGRectMake(self.view.frame.size.width/2 - 45, 0, 90, 50);
            restoreButton.frame = CGRectMake(self.view.frame.size.width -90, 0, 90, 50);
        }
    }
}
-(void)crossButtonAction:(UIButton*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void)unlockAllButtonAction:(UIButton*)sender
{
    if(![[PaymentManager sharedInstance] isAllPackPuchased])
    {
        [[PaymentManager sharedInstance] makePaymentWithProductIdentifier:iapId_allPacks];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Already Purchased"
                                                        message: @"You already purchased this"
                                                       delegate: nil
                                              cancelButtonTitle: @"Dismiss"
                                              otherButtonTitles: nil];
        [alert show];
    }
}
-(void)restoreButtonAction:(UIButton*)sender
{
    [[PaymentManager sharedInstance] restorePurchases];
}
-(void)setTableView
{
    tableView=[[UITableView alloc]init];
    
    if(IS_IPAD)
    {
        tableView.frame = CGRectMake(0,90,self.view.frame.size.width,self.view.frame.size.height-90);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            tableView.frame = CGRectMake(0,80,self.view.frame.size.width,self.view.frame.size.height-80);
        }
        else
        {
            tableView.frame = CGRectMake(0,50,self.view.frame.size.width,self.view.frame.size.height-50);
        }
    }
    
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tableView registerClass:[ShopViewTableCell class] forCellReuseIdentifier:@"Cell"];
    //[tableView reloadData];
    [tableView setShowsHorizontalScrollIndicator:NO];
    [tableView setShowsVerticalScrollIndicator:NO];
    tableView.scrollsToTop = NO;
    [self.view addSubview:tableView];
}
-(void)setParallaxView
{
    parallaxHeaderView = [[UIView alloc] init];
    
    parallaxHeaderView.backgroundColor = [UIColor whiteColor];
    
    backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"headerMain.png"];
    CGFloat tempWidth = self.view.frame.size.width;
    CGFloat tempHeight = 500;
    [parallaxHeaderView addSubview:backImageView];
    
    
    UILabel *title1Label = [[UILabel alloc] init];
    title1Label.text = @"UNLOCK ALL";
    [title1Label setTextColor:[UIColor whiteColor]];
    
    title1Label.textAlignment = NSTextAlignmentCenter;
    [parallaxHeaderView addSubview:title1Label];
    
    UILabel *title2Label = [[UILabel alloc] init];

    title2Label.text = @"ALL-IN-ONE";
    [title2Label setTextColor:[UIColor whiteColor]];
    
    title2Label.textAlignment = NSTextAlignmentCenter;
    [parallaxHeaderView addSubview:title2Label];
    
    UIView *blurSubView = [[UIView alloc] init];

    blurSubView.backgroundColor = [UIColor blackColor];
    blurSubView.alpha = 0.5;
    [parallaxHeaderView addSubview:blurSubView];
    
    UILabel *title3Label = [[UILabel alloc] init];
    
    title3Label.text = @"Unlock All Premium Frames";
    [title3Label setTextColor:[UIColor whiteColor]];
    
    title3Label.textAlignment = NSTextAlignmentCenter;
    [parallaxHeaderView addSubview:title3Label];
    
    UILabel *title4Label = [[UILabel alloc] init];
    
    title4Label.text = @"Remove Watermark From Photos";
    [title4Label setTextColor:[UIColor whiteColor]];
    
    title4Label.textAlignment = NSTextAlignmentCenter;
    [parallaxHeaderView addSubview:title4Label];
    
    UILabel *title5Label = [[UILabel alloc] init];
    
    title5Label.text = @"Remove All Ads";
    [title5Label setTextColor:[UIColor whiteColor]];
    
    title5Label.textAlignment = NSTextAlignmentCenter;
    [parallaxHeaderView addSubview:title5Label];
    
    
    UIView *priceVew = [[UIView alloc] init];
    
    priceVew.backgroundColor = RGBE(90, 184, 163);
    //priceVew.backgroundColor = RGBE(255, 130, 134);
    //priceVew.layer.borderWidth = 2;
    //priceVew.layer.borderColor = RGBE(90, 184, 163).CGColor;
    
    [parallaxHeaderView addSubview:priceVew];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"$3.99 Buy";
    [priceLabel setTextColor:[UIColor whiteColor]];
    
    
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [priceVew addSubview:priceLabel];
    
    UIImageView *saleImage = [[UIImageView alloc] init];
    saleImage.image = [UIImage imageNamed:@"sale.png"];
    [parallaxHeaderView addSubview:saleImage];
    
    unlockAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [unlockAllButton setImage:[UIImage imageNamed:@"transparent.png"] forState:UIControlStateNormal];
    [unlockAllButton addTarget:self
                    action:@selector(unlockAllButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [parallaxHeaderView addSubview:unlockAllButton];
    
    if(IS_IPAD)
    {
        priceVew.layer.cornerRadius = 10;
        
        [title1Label setFont:[UIFont boldSystemFontOfSize:64]];
        [title2Label setFont:[UIFont boldSystemFontOfSize:44]];
        [title3Label setFont:[UIFont systemFontOfSize:36]];
        [title4Label setFont:[UIFont systemFontOfSize:36]];
        [title5Label setFont:[UIFont systemFontOfSize:36]];
        [priceLabel setFont:[UIFont systemFontOfSize:40]];
        
        parallaxHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
        backImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
        
        title1Label.frame = CGRectMake(0, 60,
                                       self.view.frame.size.width, 80);
        title2Label.frame = CGRectMake(0, 140,
                                       self.view.frame.size.width, 60);
        blurSubView.frame = CGRectMake(0, 200, self.view.frame.size.width, 150);
        title3Label.frame = CGRectMake(0, 200,
                                       self.view.frame.size.width, 50);
        title4Label.frame = CGRectMake(0, 250,
                                       self.view.frame.size.width, 50);
        title5Label.frame = CGRectMake(0, 300,
                                       self.view.frame.size.width, 50);
        priceVew.frame = CGRectMake(self.view.frame.size.width/2 - 110, 400,
                                    220, 80);
        priceLabel.frame = CGRectMake(0, 0,220, 80);
        saleImage.frame = CGRectMake(0, 450, 120, 56);
        unlockAllButton.frame = CGRectMake(0, 0, self.view.frame.size.width, 550);
        
        [tableView addParallaxWithView:parallaxHeaderView andHeight:600];
    }
    else
    {
        if(IS_IPHONE_X)
        {
            priceVew.layer.cornerRadius = 5;
            
            [title1Label setFont:[UIFont boldSystemFontOfSize:32]];
            [title2Label setFont:[UIFont boldSystemFontOfSize:22]];
            [title3Label setFont:[UIFont systemFontOfSize:18]];
            [title4Label setFont:[UIFont systemFontOfSize:18]];
            [title5Label setFont:[UIFont systemFontOfSize:18]];
            [priceLabel setFont:[UIFont systemFontOfSize:20]];
            
            parallaxHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 500);
            backImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 500);
            title1Label.frame = CGRectMake(0, 30,
                                           self.view.frame.size.width, 40);
            title2Label.frame = CGRectMake(0, 70,
                                           self.view.frame.size.width, 30);
            blurSubView.frame = CGRectMake(0, 100, self.view.frame.size.width, 75);
            title3Label.frame = CGRectMake(0, 100,
                                           self.view.frame.size.width, 25);
            title4Label.frame = CGRectMake(0, 125,
                                           self.view.frame.size.width, 25);
            title5Label.frame = CGRectMake(0, 150,
                                           self.view.frame.size.width, 25);
            priceVew.frame = CGRectMake(self.view.frame.size.width/2 - 50, 200,
                                        110, 40);
            priceLabel.frame = CGRectMake(0, 0,110, 40);
            saleImage.frame = CGRectMake(0, 250, 60, 28);
            unlockAllButton.frame = CGRectMake(0, 0, self.view.frame.size.width, 500);
            [tableView addParallaxWithView:parallaxHeaderView andHeight:330];
        }
        else
        {
            priceVew.layer.cornerRadius = 5;
            
            [title1Label setFont:[UIFont boldSystemFontOfSize:32]];
            [title2Label setFont:[UIFont boldSystemFontOfSize:22]];
            [title3Label setFont:[UIFont systemFontOfSize:18]];
            [title4Label setFont:[UIFont systemFontOfSize:18]];
            [title5Label setFont:[UIFont systemFontOfSize:18]];
            [priceLabel setFont:[UIFont systemFontOfSize:20]];
            
            parallaxHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 500);
            backImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 500);
            title1Label.frame = CGRectMake(0, 30,
                                           self.view.frame.size.width, 40);
            title2Label.frame = CGRectMake(0, 70,
                                           self.view.frame.size.width, 30);
            blurSubView.frame = CGRectMake(0, 100, self.view.frame.size.width, 75);
            title3Label.frame = CGRectMake(0, 100,
                                           self.view.frame.size.width, 25);
            title4Label.frame = CGRectMake(0, 125,
                                           self.view.frame.size.width, 25);
            title5Label.frame = CGRectMake(0, 150,
                                           self.view.frame.size.width, 25);
            priceVew.frame = CGRectMake(self.view.frame.size.width/2 - 50, 200,
                                        110, 40);
            priceLabel.frame = CGRectMake(0, 0,110, 40);
            saleImage.frame = CGRectMake(0, 250, 60, 28);
            unlockAllButton.frame = CGRectMake(0, 0, self.view.frame.size.width, 500);
            [tableView addParallaxWithView:parallaxHeaderView andHeight:330];
        }
    }
    
    
    
    tableView.parallaxView.delegate = self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPAD)
    {
        return 200;
    }
    else
    {
        if(IS_IPHONE_X)
        {
            return 100;
        }
        else
        {
            return 100;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    ShopViewTableCell *cell = (ShopViewTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ShopViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.tag = 1000+indexPath.row;
    cell = [self getCellPositon:cell withRowNumber:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL tempBool;
    NSInteger tempNumber = [packInedxArr[indexPath.row] integerValue];
    if(tempNumber >=0 && tempNumber<5)
    {
        inAppId=[NSString stringWithFormat:@"%@%ld",iapId_genericPack,(long)(tempNumber+2)];
        tempBool = [[PaymentManager sharedInstance] isPackPuchased:(tempNumber+1)];
    }
    else if(tempNumber==5)
    {
        inAppId = iapId_removeAds;
        tempBool = [[PaymentManager sharedInstance] isAdRemoved];
    }
    else
    {
        inAppId = iapId_waterMark;
        tempBool = [[PaymentManager sharedInstance] isWaterMarkRemoved];
    }
    NSLog(@"InappID------------%@",inAppId);
    if(!tempBool)
        [[PaymentManager sharedInstance] makePaymentWithProductIdentifier:inAppId];
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Already Purchased"
                                                        message: @"You already purchased this"
                                                       delegate: nil
                                              cancelButtonTitle: @"Dismiss"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(ShopViewTableCell*) getCellPositon:(ShopViewTableCell*)cell withRowNumber:(NSInteger)rowNumber
{
    ShopViewTableCell* _cell = cell;
    NSString* tyniImageName = [NSString stringWithFormat:@"header%@.png",packInedxArr[rowNumber]];
    _cell.purchaseMiniImageView.image = [UIImage imageNamed:tyniImageName];
    _cell.descriptionLabel.text = packTextArr[rowNumber];
    _cell.subDescriptionLabel.text = packSubTextArr[rowNumber];
    
    NSInteger tempNumber = [packInedxArr[rowNumber] integerValue];
    BOOL tempBool;
    if(tempNumber >=0 && tempNumber<5)
    {
        tempBool = [[PaymentManager sharedInstance] isPackPuchased:(tempNumber+1)];
    }
    else if(tempNumber==5)
        //inAppId = iapId_removeAds;
        tempBool = [[PaymentManager sharedInstance] isAdRemoved];
    else
        tempBool = [[PaymentManager sharedInstance] isWaterMarkRemoved];
    //_cell.isPurchased =tempBool;
    [_cell setPrice:tempBool withIpadSize:self.view.frame.size.width];
    return _cell;
}
#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
    //NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
    //[self.view insertSubview:view.imageView belowSubview:self.tableView];
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    //NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
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

- (void)didPurchaseProductWithIdentifier:(NSString *)productId
{
    NSLog(@"purchase Complete %@",productId);
    NSString *purchasedID;
    purchasedID = productId;
    [self.editorViewDelegate editorViewCompletePurchase:purchasedID];
    [self.moreViewDelegate moreViewCompletePurchase:purchasedID];
    [self.shareViewDelegate shareViewCompletePurchase:purchasedID];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:^
     {
         //buyPackButton.hidden = YES;
         //[self hideView];
     }];
}

- (void)didRestoreProductWithIdentifier:(NSString *)productId
{
    NSLog(@"purchase Complete %@",productId);
    NSString *purchasedID;
    purchasedID = productId;
    [self.editorViewDelegate editorViewCompletePurchase:purchasedID];
    [self.moreViewDelegate moreViewCompletePurchase:purchasedID];
    [self.shareViewDelegate shareViewCompletePurchase:purchasedID];
    
    [tableView reloadData];
}

- (void)paymentFaild
{
    
}


@end
