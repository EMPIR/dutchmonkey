//
//  DutchMonkeyAppDelegate.h
//  DutchMonkey
//
//  Created by David Guinnip on 11/16/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DutchMonkeyViewController;

@interface DutchMonkeyAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DutchMonkeyViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DutchMonkeyViewController *viewController;

@end

