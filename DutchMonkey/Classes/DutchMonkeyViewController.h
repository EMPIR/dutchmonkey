//
//  DutchMonkeyViewController.h
//  DutchMonkey
//
//  Created by David Guinnip on 11/16/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Monkey.h"
@interface DutchMonkeyViewController : UIViewController 
<UIScrollViewDelegate>
{
	Monkey *m_monkey;
	IBOutlet UIImageView *monkeyHead;
	IBOutlet UIImageView *monkeyRightArm;
	IBOutlet UIImageView *monkeyLeftArm;
	IBOutlet UIImageView *monkeyRightLeg;
	IBOutlet UIImageView *monkeyLeftLeg;
	IBOutlet UIImageView *monkeyTail;
	IBOutlet UIImageView *doughnut;
	IBOutlet UIButton *monkeyBelly;
	
	IBOutlet UIImageView *doughnut1;
	IBOutlet UIImageView *doughnut2;
	IBOutlet UIImageView *doughnut3;
	IBOutlet UIImageView *doughnut4;
	IBOutlet UIImageView *doughnut5;
	
	NSTimer *gameTimer;
	UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
	
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
	
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (IBAction)changePage:(id)sender;


-(IBAction) BellyTouch:(id) sender;
-(IBAction) button1Down:(id)sender;
//-(IBAction) doughnutTouch:(id)sender;
//-(IBAction) doughnutDrag:(id)sender;

@property (nonatomic, retain) Monkey *m_monkey;
@property (nonatomic, retain) UIImageView *monkeyHead;
@property (nonatomic, retain) UIImageView *monkeyRightArm;
@property (nonatomic, retain) UIImageView *monkeyLeftArm;
@property (nonatomic, retain) UIImageView *monkeyRightLeg;
@property (nonatomic, retain) UIImageView *monkeyLeftLeg;
@property (nonatomic, retain) UIImageView *monkeyTail;
@property (nonatomic, retain) UIButton *monkeyBelly;
@property (nonatomic, retain) UIImageView *doughnut;
@property (nonatomic,retain)  NSTimer *gameTimer;

@property (nonatomic, retain) UIImageView *doughnut1;
@property (nonatomic, retain) UIImageView *doughnut2;
@property (nonatomic, retain) UIImageView *doughnut3;
@property (nonatomic, retain) UIImageView *doughnut4;
@property (nonatomic, retain) UIImageView *doughnut5;


@end

