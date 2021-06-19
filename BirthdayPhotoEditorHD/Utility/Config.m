//
//  Config.m
//  ContactEyeLanse
//
//  Created by Toukir Naim on 12/26/17.
//  Copyright © 2017 Toukir Naim. All rights reserved.
//

#import "Config.h"

@implementation Config
@synthesize purchaseIDType,adShowingType,applovinAdStatus;

static Config *_Config = nil;

+(Config *)sharedInstance {
    @synchronized([Config class]) {
        if (!_Config)
        {
            _Config = [[self alloc] init];
            
        }
        return _Config;
    }
    return nil;
}

@end
