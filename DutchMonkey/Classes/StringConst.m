//
//  StringConst.m
//  DutchMonkey
//
//  Created by David Guinnip on 12/5/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import "StringConst.h"


@implementation StringConst

+(NSString *) GetImgConst:(const char *) c
{
	NSString *ret = [NSString stringWithFormat:@"%s" , c];
	return ret;
}

@end
