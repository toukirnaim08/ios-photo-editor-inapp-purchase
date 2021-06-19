//
//  AppDelegate.m
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/12/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)isAppIDOnWeb
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:webSeriviceFileName];
    
    if(savedValue == nil || [savedValue isEqualToString:@"no"])
    {
        return NO;
        
    }
    if([savedValue isEqualToString:@"yes"])
    {
        return YES;
        
    }
    return NO;
}
-(void)saveServiceStatus:(NSString*)myString
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *tempString = webSeriviceFileName ;
    NSLog(@"webSeriviceFileName->%@",webSeriviceFileName);
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myString forKey:webSeriviceFileName];
        [standardUserDefaults synchronize];
    }
}

-(void)getStringFromUrl
{
    
    responseData = [NSMutableData new];
    NSURL *url = [NSURL URLWithString:StoreStatusWebLink];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString* responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if ([responseString containsString:AppWebID])
    {
        NSLog(@"string contains ID!");
        [self saveServiceStatus:@"yes"];
    } else
    {
        NSLog(@"string does not contain ID");
        [self saveServiceStatus:@"no"];
    }
    
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"something very bad happened here");
    [self saveServiceStatus:@"no"];
}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}
///

////
-(void)saveVersion:(NSString*)myString
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults)
    {
        [standardUserDefaults setObject:myString forKey:@"VersionStatus"];
        [standardUserDefaults synchronize];
    }
}
////

////
-(void)saveRateStatus:(NSString*)myString
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myString forKey:RateFileName];
        [standardUserDefaults synchronize];
    }
}
////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[GADMobileAds configureWithApplicationID:@"ca-app-pub-7420765399335412~4530597876"];
    // Override point for customization after application launch.
    [Config sharedInstance].purchaseIDType = NoType;
    [Config sharedInstance].applovinAdStatus = HideAd;
    [[PaymentManager sharedInstance] startProcess];
    //[ALSdk initializeSdk];
    
    NSString *savedVersion = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"VersionStatus"];
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
    
    if (![savedVersion isEqualToString:currentVersion])
    {
        [self saveServiceStatus:@"no"];
        [self saveRateStatus:@"no"];
        [self saveVersion:currentVersion];
    }
    
    BOOL bl = [self isAppIDOnWeb];
    if(bl == NO)
    {
        [self getStringFromUrl];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
