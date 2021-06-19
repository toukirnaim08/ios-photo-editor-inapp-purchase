//
//  ShopViewTableCell.m
//  BirthdayPhotoEditor
//
//  Created by Toukir Naim on 2/20/18.
//  Copyright © 2018 Toukir Naim. All rights reserved.
//

#import "ShopViewTableCell.h"

@implementation ShopViewTableCell
@synthesize descriptionLabel ,purchaseMiniImageView,subDescriptionLabel,isPurchased;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = RGBE(239, 250, 250);
        self.backgroundColor = RGBE(254, 251, 239);
        //self.backgroundColor = [UIColor yellowColor];
        purchaseMiniImageView = [[UIImageView alloc] init];
        //purchaseMiniImageView.image = [UIImage imageNamed:@"familly.png"];
        purchaseMiniImageView.layer.cornerRadius = 5;
        purchaseMiniImageView.layer.masksToBounds = YES;
        
        [self addSubview:purchaseMiniImageView];
        // configure control(s)
        descriptionLabel = [[UILabel alloc] init];
        
        descriptionLabel.textColor = RGBE(75, 81, 115);
        descriptionLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.descriptionLabel];
        
        subDescriptionLabel = [[UILabel alloc] init];
        
        subDescriptionLabel.textColor = [UIColor blackColor];
        subDescriptionLabel.textAlignment = NSTextAlignmentLeft;
        subDescriptionLabel.numberOfLines = 0;
        
        [self addSubview:self.subDescriptionLabel];
        
        purchasedImageView = [[UIImageView alloc] init];
        purchasedImageView.image = [UIImage imageNamed:@"Tick.png"];
        //purchasedImageView.layer.cornerRadius = 5;
        purchasedImageView.layer.masksToBounds = YES;
        
        
        priceVew = [[UIView alloc] init];
        priceVew.layer.cornerRadius = 5;
        priceVew.layer.borderWidth = 2;
        //priceVew.layer.borderColor = RGBE(90, 184, 163).CGColor;
        priceVew.layer.borderColor = RGBE(254, 218, 96).CGColor;
        CGFloat tW = self.frame.size.width;
        CGFloat th = self.frame.size.height;
        
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.text = @"$0.99";
        priceLabel.textColor = RGBE(75, 81, 115);
        priceLabel.textAlignment = NSTextAlignmentCenter;
        [priceVew addSubview:priceLabel];
        
        //UILabel *uiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, /self.superview.frame.size.width, 44)];
        //[self addSubview:uiLabel];
        
        [self addSubview:purchasedImageView];
        [self addSubview:priceVew];
        if(IS_IPAD)
        {
            CGFloat tx =  self.frame.size.width;
            
            descriptionLabel.font = [UIFont fontWithName:@"Arial" size:25.0f];
            subDescriptionLabel.font = [UIFont fontWithName:@"Arial" size:22.0f];
            [priceLabel setFont:[UIFont systemFontOfSize:30]];
            
            purchaseMiniImageView.frame = CGRectMake(10, 10, 180, 180);
            descriptionLabel.frame = CGRectMake(210, 10, 300, 80);
            subDescriptionLabel.frame = CGRectMake(210, 100, 300, 80);
            priceVew.frame = CGRectMake(880, 75,
                                        120, 50);
            priceLabel.frame = CGRectMake(0, 0,120, 50);
            
            purchasedImageView.frame = CGRectMake(880, 75,
                                        120, 50);
        }
        else
        {
            if(IS_IPHONE_X)
            {
                descriptionLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
                subDescriptionLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
                [priceLabel setFont:[UIFont systemFontOfSize:15]];
                purchaseMiniImageView.frame = CGRectMake(5, 5, 90, 90);
                descriptionLabel.frame = CGRectMake(100, 10, 200, 40);
                subDescriptionLabel.frame = CGRectMake(100, 50, 200, 40);
                priceVew.frame = CGRectMake(375 - 70, 35,
                                            60, 25);
                priceLabel.frame = CGRectMake(0, 0,55, 25);
                
                purchasedImageView.frame = CGRectMake(880, 75,
                                                      120, 50);
            }
            else
            {
                descriptionLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
                subDescriptionLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
                [priceLabel setFont:[UIFont systemFontOfSize:15]];
                purchaseMiniImageView.frame = CGRectMake(5, 5, 90, 90);
                descriptionLabel.frame = CGRectMake(100, 10, 200, 40);
                subDescriptionLabel.frame = CGRectMake(100, 50, 200, 40);
                priceVew.frame = CGRectMake(375 - 70, 35,
                                            60, 25);
                priceLabel.frame = CGRectMake(0, 0,55, 25);
                
                purchasedImageView.frame = CGRectMake(375 - 35, 35,
                                                      30, 30);
            }
        }
        
    }
    return self;
}
-(void)setPrice:(BOOL)isPurchase withIpadSize:(CGFloat)ipadSize;
{
    
    if(isPurchase)
    {
        priceVew.hidden = YES;
        purchasedImageView.hidden = NO;
    }
    else
    {
        priceVew.hidden = NO;
        purchasedImageView.hidden = YES;
    }
    if(IS_IPAD)
    {
        priceVew.frame = CGRectMake(ipadSize - 130, 75,
                                    120, 50);
        
        purchasedImageView.frame = CGRectMake(ipadSize - 130, 75,
                                              120, 50);
    }
    else
    {
        if(IS_IPHONE_X)
        {
            priceVew.frame = CGRectMake(ipadSize - 70, 35,
                                        60, 25);
            purchasedImageView.frame = CGRectMake(ipadSize - 35, 35,
                                                  30, 30);
        }
        else
        {
            priceVew.frame = CGRectMake(ipadSize - 70, 35,
                                        60, 25);
            purchasedImageView.frame = CGRectMake(ipadSize - 35, 35,
                                                  30, 30);
        }
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
