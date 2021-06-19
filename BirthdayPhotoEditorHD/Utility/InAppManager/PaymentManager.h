//
//  PaymentManager.h
//  ContactEyeLanse
//
//  Created by Toukir Naim on 12/22/17.
//  Copyright © 2017 Toukir Naim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InAppStorePaymentManager.h"
#import "Config.h"

@protocol PaymentManagerProtocol <NSObject>

- (void)didPurchaseProductWithIdentifier: (NSString*)productId;
- (void)didRestoreProductWithIdentifier: (NSString*)productId;
- (void)paymentFaild;

@end

/*@protocol PaymentManagerProtocol2 <NSObject>
- (void)removeAllAdsEvent;
@end*/

@interface PaymentManager : NSObject<InAppStorePaymentManagerProtocol>
@property (strong, readonly, nonatomic) InAppStorePaymentManager *paymentManager;
@property (assign, nonatomic) id<PaymentManagerProtocol> paymentDelegate;
//@property (assign, nonatomic) id<PaymentManagerProtocol2> removeAdDelegate;
+(PaymentManager *)sharedInstance;
-(void)startProcess;
-(void)makePaymentWithProductIdentifier:(NSString*)identifier;
- (void)restorePurchases;
- (BOOL)isPackPuchased:(NSInteger)packIndex;
- (BOOL)isAllPackPuchased;
- (BOOL)isAdRemoved;
- (BOOL)isWaterMarkRemoved;
@end
