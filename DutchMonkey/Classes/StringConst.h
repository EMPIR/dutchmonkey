//
//  StringConst.h
//  DutchMonkey
//
//  Created by David Guinnip on 12/5/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef STRINGCONST
#define STRINGCONST

static const char	IMG_CHOCOLATE []				= "ChocolateIcedSpinkles.png";
static const char	IMG_DUTCHAPPLE []				= "DutchApple.png";
static const char	IMG_DUTCHMONKEY []				= "DutchMonkey.png";
static const char	IMG_MAPLEBARS []				= "MapleBars.png";
static const char	IMG_JALAPENO []					= "JalapenoCheddarSpirals.png";

#endif

@interface StringConst : NSObject {

}

+(NSString *) GetImgConst:(const char *) c;

@end
