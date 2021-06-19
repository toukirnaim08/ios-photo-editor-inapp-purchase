//
//  ShopViewTableCell.h
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/20/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@interface ShopViewTableCell : UITableViewCell
{
    //UILabel *descriptionLabel;
    UILabel *priceLabel;
    UIView *priceVew;
    UIImageView *purchasedImageView;
    
}
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *subDescriptionLabel;
@property (nonatomic, strong) UIImageView *purchaseMiniImageView;
@property (nonatomic) BOOL isPurchased;
-(void)setPrice:(BOOL)isPurchase withIpadSize:(CGFloat)ipadSize;


@end
