//
//  Monkey.h
//  DutchMonkey
//
//  Created by David Guinnip on 11/28/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Monkey : NSObject {
	IBOutlet UIImageView *monkeyHead;
	IBOutlet UIImageView *monkeyRightArm;
	IBOutlet UIImageView *monkeyLeftArm;
	IBOutlet UIImageView *monkeyRightLeg;
	IBOutlet UIImageView *monkeyLeftLeg;
	IBOutlet UIImageView *monkeyTail;
	IBOutlet UIButton *monkeyBelly;
	IBOutlet UIImageView *doughnut;
	double headAngle;
	double headAngleIncrement;
	double tailAngle;// = 0;
	double tailAngleIncrement;// = 0.01;
	
	double footRAngle;// = 0;
	double footRAngleIncrement;// = 0.02;
	double footLAngle;// = 0;
	double footLAngleIncrement;// = 0.02;
	
	double armRAngle;// = 0;
	double armRAngleIncrement;// = 0.02;
	double armLAngle;// = 0;
	double armLAngleIncrement;// = 0.02;
	
	double introAnimationFrame;
	double walkAnimationFrame;
	double eatAnimationFrame;
	
	
	
}

-(void)gameloop;
-(id) init;
-(void)startWalk;
-(void)startEating;

@property (nonatomic, retain) UIImageView *monkeyHead;
@property (nonatomic, retain) UIImageView *monkeyRightArm;
@property (nonatomic, retain) UIImageView *monkeyLeftArm;
@property (nonatomic, retain) UIImageView *monkeyRightLeg;
@property (nonatomic, retain) UIImageView *monkeyLeftLeg;
@property (nonatomic, retain) UIImageView *monkeyTail;
@property (nonatomic, retain) UIButton *monkeyBelly;
@property (nonatomic, retain) UIImageView *doughnut;

@property (nonatomic, assign) double headAngle;
@property (nonatomic, assign) double headAngleIncrement;

@property (nonatomic, assign) double tailAngle;
@property (nonatomic, assign) double tailAngleIncrement;

@property (nonatomic, assign) double footRAngle;
@property (nonatomic, assign) double footRAngleIncrement;

@property (nonatomic, assign) double footLAngle;
@property (nonatomic, assign) double footLAngleIncrement;

@property (nonatomic, assign) double armRAngle;
@property (nonatomic, assign) double armRAngleIncrement;

@property (nonatomic, assign) double armLAngle;
@property (nonatomic, assign) double armLAngleIncrement;

@property (nonatomic, assign) double introAnimationFrame;
@property (nonatomic, assign) double eatAnimationFrame;



@end
