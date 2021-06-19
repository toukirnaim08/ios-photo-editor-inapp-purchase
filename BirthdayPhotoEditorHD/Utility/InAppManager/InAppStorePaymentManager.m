//
//  InAppStorePaymentManager.m
//  StacheMash
//
//  Created by Konstantin Sokolinskyi on 3/16/12.
//  Copyright (c) 2012 Bright Newt. All rights reserved.
//

#import <StoreKit/StoreKit.h>

#import "InAppStorePaymentManager.h"
//#import "GUIHelper.h"
//#import "NSArray+Functional.h"
//#import "PlayHavenSDK.h"
//#import "DataModel.h"
//#import "secrets.h"
//#import "AdManager.h"


@interface InAppStorePaymentManager ()
<SKProductsRequestDelegate,
SKRequestDelegate,
SKPaymentTransactionObserver>

@property (nonatomic,readwrite,strong) UIView *shadow;
@property (nonatomic,readwrite) BOOL showingShadow;
- (void)dumpProduct: (SKProduct*)product;
- (void)dumpTransaction: (SKPaymentTransaction*)transaction;

- (void)completeTransaction: (SKPaymentTransaction*)transaction;
- (void)failedTransaction: (SKPaymentTransaction*)transaction;
- (void)restoreTransaction: (SKPaymentTransaction*)transaction;
- (void)finishTransaction: (SKPaymentTransaction*)transaction;

@end


@implementation InAppStorePaymentManager

@synthesize products = __products;
@synthesize delegate = __delegate;

- (id)init
{
	if ( self = [super init] ) {
		[[SKPaymentQueue defaultQueue ] addTransactionObserver: self];
	}
	return self;
}


- (void)requestProductsFromApple: (NSSet*)productIDs
{
    if ( 0 == [productIDs count] ) {
        NSLog(@"empty products set supplied");
        return;
    }
	
	SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers: productIDs];
	request.delegate = self;
	[request start];
}

-(void)setShowingShadow:(BOOL)showingShadow {
	if (showingShadow==_showingShadow) return;
	_showingShadow=showingShadow;
	if (showingShadow) {
		UIView *root=[UIApplication sharedApplication].keyWindow;
		_shadow=[[UIView alloc] initWithFrame:root.bounds];
		_shadow.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
		_shadow.opaque=NO;
		_shadow.userInteractionEnabled=YES;
		_shadow.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		[root addSubview:_shadow];
		
		/*UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		indicator.frame=_shadow.bounds;
		indicator.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		[indicator startAnimating];
		[_shadow addSubview:indicator];*/
        [SVProgressHUD show];
	} else {
        [SVProgressHUD dismiss];
		[_shadow removeFromSuperview];
		_shadow=nil;
	}
}

- (void)makePaymentWithProductIdentifier: (NSString*)productIdentifier
{
    if ([SKPaymentQueue canMakePayments]) {
        NSLog( @"making payment with product identifier: %@", productIdentifier );
		
		SKProduct *productSK=nil;
		for (SKProduct *someProduct in self.products)
			if ([someProduct.productIdentifier isEqualToString:productIdentifier]) {
				productSK=someProduct; break;
			}
        
        if(productSK == nil){
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Purchase failed"
                                                                message:@"Cannot connect to iTunes Connect"
                                                               delegate:self
                                                      cancelButtonTitle:@"Dismiss"
                                                      otherButtonTitles:nil];
            [alertView show];
            return;
        }
		self.showingShadow=YES;
        //[SVProgressHUD show];
        SKPayment *payment = [SKPayment paymentWithProduct:productSK];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Cannot make purchases", @"")
                                                        message: NSLocalizedString(@"It looks like you have disabled In-App purchases in your settings. Please enable them and try again.", @"Disabled IAP alert message text")
                                                       delegate: nil
                                              cancelButtonTitle: NSLocalizedString( @"Dismiss", @"")
                                              otherButtonTitles: nil];
        [alert show];
    }
}


- (void)restorePurchases
{
    NSLog(@"initiating restoring tranasction");
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
	self.showingShadow=YES;
    //[SVProgressHUD show];
}


- (void)dumpProduct: (SKProduct*)product
{
	
}


- (void)dumpTransaction: (SKPaymentTransaction*)transaction
{
	
}


#pragma mark - SKRequestDelegate

- (void)requestDidFinish: (SKRequest*)request
{
    NSLog(@"request DID finish: %@", request);
}
          

- (void)request: (SKRequest*)request didFailWithError: (NSError*)error
{
	NSLog(@"error getting products: %@ for request: %@", [error localizedDescription], request);
}


#pragma mark - SKProductsRequestDelegate

- (void)productsRequest: (SKProductsRequest*)request didReceiveResponse: (SKProductsResponse*)response
{
	
    __products = response.products;
	
	
	for ( NSString *invalidIdentifier in response.invalidProductIdentifiers ) {
		NSLog( @"invalid product identifier: %@", invalidIdentifier );
	}
}


#pragma mark SKPaymentTransactionObserver

- (void) paymentQueue: (SKPaymentQueue*)queue updatedTransactions: (NSArray*)transactions
{
    NSLog(@"UPDATED transactions");
    
	for (SKPaymentTransaction* transaction in transactions) {
		
        switch ( transaction.transactionState )
        {
            case SKPaymentTransactionStatePurchased:
				NSLog( @"state = SKPaymentTransactionStatePurchased" );
                [self completeTransaction: transaction ];
				self.showingShadow=NO;
                //[SVProgressHUD dismiss];
                break;
            case SKPaymentTransactionStateFailed:
				NSLog( @"state = SKPaymentTransactionStateFailed" );
                [self failedTransaction: transaction ];
				self.showingShadow=NO;
                //[SVProgressHUD dismiss];
                break;
            case SKPaymentTransactionStateRestored:
				NSLog( @"state = SKPaymentTransactionStateRestored" );
                [self restoreTransaction: transaction ];
			case SKPaymentTransactionStatePurchasing:
				NSLog( @"state = SKPaymentTransactionStatePurchasing... going on" );
				break;
            default:
				NSLog( @"state = unknown. WTF?" );
                break;
        }
    }
}


- (void)paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentQueue*)queue
{
	self.showingShadow=NO;
    //[SVProgressHUD dismiss];
    NSLog(@"RESTORING complete");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Restoring complete", @"Restore purchases OK alert title")
                                                    message: NSLocalizedString(@"All purchases has been successfully restored. Enjoy!!!", @"Restore purchases OK alert text")
                                                   delegate: nil
                                          cancelButtonTitle: NSLocalizedString( @"Dismiss", @"")
                                          otherButtonTitles: nil];
    [alert show];
}


- (void)paymentQueue: (SKPaymentQueue*)queue restoreCompletedTransactionsFailedWithError: (NSError*)error
{
	self.showingShadow=NO;
    //[SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Unable to restore purchases", @"")
                                                    message: [NSString stringWithFormat: NSLocalizedString(@"Restoring purchases failed with error: %@", @"Restore purchases error alert text"), [error localizedDescription]]
                                                   delegate: nil
                                          cancelButtonTitle: NSLocalizedString( @"Dismiss", @"")
                                          otherButtonTitles: nil];
    [alert show];
}



#pragma mark - Transaction completion

- (void)completeTransaction: (SKPaymentTransaction*)transaction
{
    NSLog(@"completed transaction: %@", transaction);

    [self.delegate didPurchaseProductWithIdentifier: transaction.payment.productIdentifier];
    [self finishTransaction: transaction];
	
}


- (void)restoreTransaction: (SKPaymentTransaction*)transaction
{
    NSLog(@"restore transaction: %@", transaction);
    
    [self.delegate didRestoreProductWithIdentifier: transaction.originalTransaction.payment.productIdentifier];
    [self finishTransaction: transaction];
}


- (void)failedTransaction: (SKPaymentTransaction*)transaction
{
  
	
	if ( SKErrorPaymentCancelled != transaction.error.code ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Unable to purchase", @"")
                                                        message: [NSString stringWithFormat: NSLocalizedString(@"Purchase failed with error: %@", @"Purchases failed error alert title"), [transaction.error localizedDescription]]
                                                       delegate: nil
                                              cancelButtonTitle: NSLocalizedString( @"Dismiss", @"")
                                              otherButtonTitles: nil];
        [alert show];
	}
    [self.delegate paymentFaild];
    [self finishTransaction: transaction];
    
}



- (void)finishTransaction: (SKPaymentTransaction*)transaction
{
    NSLog(@"finishing transaction");
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

@end
