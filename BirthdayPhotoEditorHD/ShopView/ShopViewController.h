//
//  TempViewController.h
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/20/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "UIScrollView+APParallaxHeader.h"
#import "ShopViewTableCell.h"
#import "PaymentManager.h"


@protocol EditorViewProtocol <NSObject>
- (void)editorViewCompletePurchase:(NSString*)purchaseID;
- (void)editorViewCompleteRestoring;
@end

@protocol MoreViewProtocol <NSObject>
- (void)moreViewCompletePurchase:(NSString*)purchaseID;
- (void)moreViewCompleteRestoring;
@end

@protocol ShareViewProtocol <NSObject>
- (void)shareViewCompletePurchase:(NSString*)purchaseID;
- (void)shareViewCompleteRestoring;
@end


@interface ShopViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,
APParallaxViewDelegate,PaymentManagerProtocol>
{
    BOOL parallaxWithView;
    UITableView *tableView;
    UIView *parallaxHeaderView;
    UIImageView *backImageView;
    
    UIButton *crossButton;
    UIButton *restoreButton;
    
    NSMutableArray  *packInedxArr;
    NSMutableArray *packTextArr;
    NSMutableArray *packSubTextArr;
    NSString *inAppId;
    
    UIButton *unlockAllButton;
    
    BOOL firstTimeEntry;
}
@property (assign, nonatomic) id<EditorViewProtocol> editorViewDelegate;
@property (assign, nonatomic) id<MoreViewProtocol> moreViewDelegate;
@property (assign, nonatomic) id<ShareViewProtocol> shareViewDelegate;

+(ShopViewController *)sharedInstance;
-(void)setPackNumber;

@end
