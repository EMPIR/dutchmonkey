//
//  DutchMonkeyViewController.h
//  DutchMonkey
//
//  Created by David Guinnip on 11/16/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Monkey.h"
@interface DutchMonkeyViewController : UIViewController {
	Monkey *m_monkey;
	IBOutlet UIImageView *monkeyHead;
	IBOutlet UIImageView *monkeyRightArm;
	IBOutlet UIImageView *monkeyLeftArm;
	IBOutlet UIImageView *monkeyRightLeg;
	IBOutlet UIImageView *monkeyLeftLeg;
	IBOutlet UIImageView *monkeyTail;
	NSTimer *gameTimer;
}
@property (nonatomic, retain) Monkey *m_monkey;
@property (nonatomic, retain) UIImageView *monkeyHead;
@property (nonatomic, retain) UIImageView *monkeyRightArm;
@property (nonatomic, retain) UIImageView *monkeyLeftArm;
@property (nonatomic, retain) UIImageView *monkeyRightLeg;
@property (nonatomic, retain) UIImageView *monkeyLeftLeg;
@property (nonatomic, retain) UIImageView *monkeyTail;
@property (nonatomic,retain) NSTimer *gameTimer;

@end

