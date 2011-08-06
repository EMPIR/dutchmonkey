//
//  Monkey.m
//  DutchMonkey
//
//  Created by David Guinnip on 11/28/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import "Monkey.h"

@implementation Monkey

@synthesize monkeyHead, monkeyRightArm, monkeyLeftArm, monkeyRightLeg, monkeyLeftLeg, monkeyTail,monkeyBelly, doughnut; 
@synthesize headAngle, headAngleIncrement, footRAngle,footRAngleIncrement, footLAngle,footLAngleIncrement;
@synthesize armRAngle,armRAngleIncrement, armLAngle,armLAngleIncrement, tailAngle, tailAngleIncrement;
@synthesize introAnimationFrame, eatAnimationFrame;

int M_HEAD_PIVOT [] = {0,30};
int M_ARMR_PIVOT [] = {-22,-45};
int M_ARML_PIVOT [] = {21,-47};
int M_LEGR_PIVOT [] = {-24,-20};
int M_LEGL_PIVOT [] = {24,-20};
int M_TAIL_PIVOT [] = {-60,0};


//const int HEAD_PIVOT [] = {0,30};

-(void)startWalk{
	walkAnimationFrame = 100;
}

-(void)startEating:(UIImageView *) imgView{
	eatAnimationFrame = 100;
	//imgView.transform = doughnut.transform;
    doughnut = imgView;
}

-(void) incrementAngles{
	
	if(headAngle > 0.5)
		headAngleIncrement = -0.01;
	
	if(headAngle < -0.5)
		headAngleIncrement = 0.01;
	headAngle += headAngleIncrement;
	
	if(footRAngle > 0.5)
		footRAngleIncrement = -0.02;
	
	if(footRAngle < -0.5)
		footRAngleIncrement = 0.02;
	
	footRAngle +=footRAngleIncrement;
	
	if(footLAngle > 0.5)
		footLAngleIncrement = -0.02;
	
	if(footLAngle < -0.5)
		footLAngleIncrement = 0.02;
	
	footLAngle +=footLAngleIncrement;
	
	
	///
	if(armRAngle > 0.5)
		armRAngleIncrement = -0.02;
	
	if(armRAngle < -0.5)
		armRAngleIncrement = 0.02;
	
	armRAngle +=armRAngleIncrement;
	
	if(armLAngle > 0.5)
		armLAngleIncrement = -0.02;
	
	if(armLAngle < -0.5)
		armLAngleIncrement = 0.02;
	
	armLAngle +=armLAngleIncrement;
	
	
	if(tailAngle < -0.5)
		tailAngleIncrement = 0.01;
	
	if(tailAngle > 0.5)
		tailAngleIncrement = -0.01;
	
	tailAngle +=tailAngleIncrement;
}

-(void)gameloop{
	
	

	
	monkeyTail.transform = CGAffineTransformIdentity;
	monkeyHead.transform = CGAffineTransformIdentity;
	monkeyRightLeg.transform = CGAffineTransformIdentity;
	monkeyLeftLeg.transform = CGAffineTransformIdentity;
	monkeyRightArm.transform = CGAffineTransformIdentity;
	monkeyLeftArm.transform = CGAffineTransformIdentity;
	
	
	
	if(introAnimationFrame > 0 )
	{
		//monkeyHead.transform = CGAffineTransformIdentity;
		monkeyHead.transform = CGAffineTransformTranslate(monkeyHead.transform,-1*introAnimationFrame,0);
		
		//monkeyRightArm.transform = CGAffineTransformIdentity;
		monkeyRightArm.transform = CGAffineTransformTranslate(monkeyRightArm.transform,-1*introAnimationFrame,0);
		
		//monkeyLeftArm.transform = CGAffineTransformIdentity;
		monkeyLeftArm.transform = CGAffineTransformTranslate(monkeyLeftArm.transform,-1*introAnimationFrame,0);
		
		//monkeyRightLeg.transform = CGAffineTransformIdentity;
		monkeyRightLeg.transform = CGAffineTransformTranslate(monkeyRightLeg.transform,-1*introAnimationFrame,0);
		
		//monkeyLeftLeg.transform = CGAffineTransformIdentity;
		monkeyLeftLeg.transform = CGAffineTransformTranslate(monkeyLeftLeg.transform,-1*introAnimationFrame,0);
		
		//monkeyTail.transform = CGAffineTransformIdentity;
		monkeyTail.transform = CGAffineTransformTranslate(monkeyTail.transform,-1*introAnimationFrame,0);
		
		monkeyBelly.transform = CGAffineTransformIdentity;
		monkeyBelly.transform = CGAffineTransformTranslate(monkeyBelly.transform,-1*introAnimationFrame,0);
		
		
		//introAnimationFrame-=2;
		introAnimationFrame-=2;
	}
	
	
	if(walkAnimationFrame > 0)
	{
		[self incrementAngles];
		monkeyTail.transform = CGAffineTransformTranslate(monkeyTail.transform,M_TAIL_PIVOT[0],M_TAIL_PIVOT[1]);
		monkeyTail.transform = CGAffineTransformRotate(monkeyTail.transform, tailAngle);
		monkeyTail.transform = CGAffineTransformTranslate(monkeyTail.transform,-M_TAIL_PIVOT[0],-M_TAIL_PIVOT[1]);
	
		monkeyHead.transform = CGAffineTransformTranslate(monkeyHead.transform,M_HEAD_PIVOT[0],M_HEAD_PIVOT[1]);
		monkeyHead.transform = CGAffineTransformRotate(monkeyHead.transform, headAngle);
		monkeyHead.transform = CGAffineTransformTranslate(monkeyHead.transform,-M_HEAD_PIVOT[0],-M_HEAD_PIVOT[1]);
	
		monkeyRightLeg.transform = CGAffineTransformTranslate(monkeyRightLeg.transform,M_LEGR_PIVOT[0],M_LEGR_PIVOT[1]);
		monkeyRightLeg.transform = CGAffineTransformRotate(monkeyRightLeg.transform, footRAngle);
		monkeyRightLeg.transform = CGAffineTransformTranslate(monkeyRightLeg.transform,-M_LEGR_PIVOT[0],-M_LEGR_PIVOT[1]);

		monkeyLeftLeg.transform = CGAffineTransformTranslate(monkeyLeftLeg.transform,M_LEGL_PIVOT[0],M_LEGL_PIVOT[1]);
		monkeyLeftLeg.transform = CGAffineTransformRotate(monkeyLeftLeg.transform, footLAngle);
		monkeyLeftLeg.transform = CGAffineTransformTranslate(monkeyLeftLeg.transform,-M_LEGL_PIVOT[0],-M_LEGL_PIVOT[1]);


		monkeyRightArm.transform = CGAffineTransformTranslate(monkeyRightArm.transform,M_ARMR_PIVOT[0],M_ARMR_PIVOT[1]);
		monkeyRightArm.transform = CGAffineTransformRotate(monkeyRightArm.transform, armRAngle);
		monkeyRightArm.transform = CGAffineTransformTranslate(monkeyRightArm.transform,-M_ARMR_PIVOT[0],-M_ARMR_PIVOT[1]);

		monkeyLeftArm.transform = CGAffineTransformTranslate(monkeyLeftArm.transform,M_ARML_PIVOT[0],M_ARML_PIVOT[1]);
		monkeyLeftArm.transform = CGAffineTransformRotate(monkeyLeftArm.transform, armLAngle);
		monkeyLeftArm.transform = CGAffineTransformTranslate(monkeyLeftArm.transform,-M_ARML_PIVOT[0],-M_ARML_PIVOT[1]);
		walkAnimationFrame --;
		
	}		
	
	if(eatAnimationFrame > 0)
	{
		doughnut.hidden = NO;
		[self incrementAngles];
		monkeyLeftArm.transform = CGAffineTransformTranslate(monkeyLeftArm.transform,M_ARML_PIVOT[0],M_ARML_PIVOT[1]);
		monkeyLeftArm.transform = CGAffineTransformRotate(monkeyLeftArm.transform, armLAngle);
		monkeyLeftArm.transform = CGAffineTransformTranslate(monkeyLeftArm.transform,-M_ARML_PIVOT[0],-M_ARML_PIVOT[1]);
		
		doughnut.transform = CGAffineTransformTranslate(doughnut.transform,M_ARML_PIVOT[0],M_ARML_PIVOT[1]);
		doughnut.transform = CGAffineTransformRotate(doughnut.transform, armLAngle);
		doughnut.transform = CGAffineTransformTranslate(doughnut.transform,-M_ARML_PIVOT[0],-M_ARML_PIVOT[1]);
		
		eatAnimationFrame --;
	}
	else {
		//doughnut.hidden = YES;
	}

}

-(id) init{
	if(self = [super init]){
		
		headAngle = 0;
		headAngleIncrement = 0.01;
		
		tailAngle = 0;
		tailAngleIncrement = 0.01;
		
		footRAngle = 0;
		footRAngleIncrement = 0.02;
		footLAngle = 0;
		footLAngleIncrement = 0.02;
		
		armRAngle = 0;
		armRAngleIncrement = 0.02;
		armLAngle = 0;
		armLAngleIncrement = 0.02;
		
		introAnimationFrame = 100;
		eatAnimationFrame = 0;
		
		
		monkeyHead.transform = CGAffineTransformIdentity;
		monkeyHead.transform = CGAffineTransformTranslate(monkeyHead.transform,-20,0);
		
		[self startWalk];
		
		
	}
	
	return self;
}


@end
