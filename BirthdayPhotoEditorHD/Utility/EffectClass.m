//
//  EffectClass.m
//  CLImageEditorDemo
//
//  Created by Mac on 3/30/17.
//  Copyright © 2017 CALACULU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EffectClass.h"


@implementation MyClass
static NSString *fullName=@"Hello World";
//static UIImage *selectedImage;
+(void)setEffect:(NSString *)effect
{
    fullName = effect;
}

+(NSString *)myFullName;{
    return fullName;
}

/*+(void)setImage:(UIImage *)image
{
    selectedImage = image;
}

+(UIImage *)getImage
{
    return selectedImage;
}

+(UIColor *) setRGB_R:(float)r G:(float)g B:(float)b
{
    UIColor *Colour = [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1];
    return Colour;
}*/
@end
