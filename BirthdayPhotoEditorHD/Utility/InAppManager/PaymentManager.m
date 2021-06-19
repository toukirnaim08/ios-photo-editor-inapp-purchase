//
//  PaymentManager.m
//  ContactEyeLanse
//
//  Created by Toukir Naim on 12/22/17.
//  Copyright © 2017 Toukir Naim. All rights reserved.
//

#import "PaymentManager.h"

@implementation PaymentManager
@synthesize paymentDelegate;

static PaymentManager *_sharedInstance = nil;

+(PaymentManager *)sharedInstance {
    @synchronized([PaymentManager class]) {
        if (!_sharedInstance)
        {
            _sharedInstance = [[self alloc] init];
            
        }
        return _sharedInstance;
    }
    return nil;
}
- (BOOL)isPackPuchased:(NSInteger)packIndex
{
    if(packIndex==0)
        return YES;
    else
    {
        BOOL tempStatus;
        tempStatus = [[NSUserDefaults standardUserDefaults] boolForKey:iapId_allPacks];
        if(tempStatus)
            return tempStatus;
        
        NSString *packID = [NSString stringWithFormat:@"%@%ld",iapId_genericPack,(long)(packIndex+1)];
        tempStatus = [[NSUserDefaults standardUserDefaults] boolForKey:packID];
        return tempStatus;
    }
    
}
- (BOOL)isAllPackPuchased
{
    BOOL tempStatus = [[NSUserDefaults standardUserDefaults] boolForKey:iapId_allPacks];
    return tempStatus;
}
- (BOOL)isAdRemoved
{
    BOOL tempStatus;
    tempStatus = [[NSUserDefaults standardUserDefaults] boolForKey:iapId_allPacks];
    if(tempStatus)
        return tempStatus;
    
    tempStatus = [[NSUserDefaults standardUserDefaults] boolForKey:iapId_removeAds];
    
    return tempStatus;
}
- (BOOL)isWaterMarkRemoved
{
    BOOL tempStatus;
    tempStatus = [[NSUserDefaults standardUserDefaults] boolForKey:iapId_allPacks];
    if(tempStatus)
        return tempStatus;
    
    tempStatus = [[NSUserDefaults standardUserDefaults] boolForKey:iapId_waterMark];
    
    return tempStatus;
}
-(void)startProcess
{
    _paymentManager = [[InAppStorePaymentManager alloc] init];
    self.paymentManager.delegate = self;
    [self.paymentManager requestProductsFromApple: [self productIDs]];
}
- (NSSet*)productIDs
{
    NSMutableSet *products = [[NSMutableSet alloc] init];
    [products addObject: iapId_removeAds];
    [products addObject: iapId_waterMark];
    [products addObject: iapId_allPacks];
    
    [products addObject: iapId_pack2];
    [products addObject: iapId_pack3];
    [products addObject: iapId_pack4];
    [products addObject: iapId_pack5];
    [products addObject: iapId_pack6];
    return products;
}
-(void)makePaymentWithProductIdentifier:(NSString*)identifier
{
    [self.paymentManager makePaymentWithProductIdentifier:identifier];
}
- (void)restorePurchases
{
    [self.paymentManager restorePurchases];
}
- (void)didPurchaseProductWithIdentifier: (NSString*)productId
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productId];
    [self.paymentDelegate didPurchaseProductWithIdentifier:productId];
}
- (void)didRestoreProductWithIdentifier: (NSString*)productId
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productId];
    [self.paymentDelegate didRestoreProductWithIdentifier:productId];
}

- (void)paymentFaild
{
    [self.paymentDelegate paymentFaild];
}

@end
