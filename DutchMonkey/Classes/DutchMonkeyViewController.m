//
//  DutchMonkeyViewController.m
//  DutchMonkey
//
//  Created by David Guinnip on 11/16/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import "DutchMonkeyViewController.h"


@interface DutchMonkeyViewController()
-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event;
-(void)dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position;
-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position;
@end	


@implementation DutchMonkeyViewController

@synthesize monkeyHead, monkeyRightLeg, monkeyLeftLeg, monkeyRightArm, monkeyLeftArm, monkeyTail;

CGPoint firstPoint;
CGPoint lastPoint;
BOOL touching;

// Checks to see which view, or views, the point is in and then calls a method to perform the opening animation,
// which  makes the piece slightly larger, as if it is being picked up by the user.
-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event
{
	/*if (CGRectContainsPoint([rotateButton frame], touchPoint)) {
		NSLog(@"Touch Inside Rotate Button %f %f", touchPoint.x, touchPoint.y );
		firstPoint = touchPoint;
		lastPoint = firstPoint;
	}*/
	
	
}

-(CGPoint) getCenter: (CGRect )rect
{
	CGPoint p;
	p.x =  rect.origin.x + rect.size.width / 2.0;
	p.y =  rect.origin.y + rect.size.height / 2.0;
	return p;
}

-(double) getAngle: (CGPoint) origin: (CGPoint) a: (CGPoint) b
{
	CGPoint _a;// = a - origin;
	CGPoint _b;// = b - origin;
	_a.x = a.x - origin.x;
	_a.y = a.y - origin.y;
	
	_b.x = b.x - origin.x;
	_b.y = b.y - origin.y;
	
	
	double len = sqrt(_a.x * _a.x + _a.y * _a.y);
	_a.x = _a.x / len;
	_a.y = _a.y / len;
	double cprod = _a.x * _b.y - _a.y * _b.x;
	NSLog(@"Cross Product %f", cprod);
	
	len = sqrt(_b.x * _b.x + _b.y * _b.y);
	_b.x = _b.x / len;
	_b.y = _b.y / len;
	
	
	
	double prod = _a.x * _b.x + _a.y * _b.y;
	double rad = (double) acos(prod);
	//double deg = (double) rad * (180 / (double)3.1415926535898);
	if(cprod < 0)
		rad *= -1;
	
	return rad;
}

// Checks to see which view, or views, the point is in and then sets the center of each moved view to the new postion.
// If views are directly on top of each other, they move together.
-(void)dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position
{
	
	UIImageView *imgView = NULL;
	CGRect frame;
	
	//NSLog(@"dispatchTouchEvent");
	
	if(CGRectContainsPoint([monkeyRightArm frame],position)){
		frame = monkeyRightArm.frame;
		imgView = monkeyRightArm;
	}
	else if(CGRectContainsPoint([monkeyLeftArm frame],position)){
		frame = monkeyLeftArm.frame;
		imgView = monkeyLeftArm;
	}
	else if(CGRectContainsPoint([monkeyRightLeg frame],position)){
		frame = monkeyRightLeg.frame;
		imgView = monkeyRightLeg;
	}
	else if(CGRectContainsPoint([monkeyLeftLeg frame],position)){
		frame = monkeyLeftLeg.frame;
		imgView = monkeyLeftLeg;
	}
	else if (CGRectContainsPoint([monkeyHead frame], position)) {
		frame = monkeyHead.frame;
		imgView = monkeyHead;
	}
	else if (CGRectContainsPoint([monkeyTail frame], position)) {
		frame = monkeyTail.frame;
		imgView = monkeyTail;
	}
	
	if(imgView != NULL)
	{
		//CGPoint origin = frame.origin;
		CGPoint origin = [self getCenter:frame];
		if(firstPoint.x == -1)
		{
			firstPoint.x = position.x;
			firstPoint.y = position.y;
			lastPoint.x = position.x;
			lastPoint.y = position.y;
		}
		else {
			firstPoint = lastPoint;
			lastPoint = position;
		
			double angle = [self getAngle:origin:firstPoint:lastPoint];
			NSLog(@"dispatch Touch event. Origin: %f, %f. First Point: %f %f. Last Point: %f %f. Angle: %f", 
				  origin.x, origin.y, firstPoint.x, firstPoint.y, lastPoint.x, lastPoint.y, angle );
			imgView.transform = CGAffineTransformRotate(imgView.transform, angle);
		}
	}
	 
	
}

// Checks to see which view, or views,  the point is in and then calls a method to perform the closing animation,
// which is to return the piece to its original size, as if it is being put down by the user.
-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position
{   
	/*// Check to see which view, or views,  the point is in and then animate to that position.
	 if (CGRectContainsPoint([firstPieceView frame], position)) {
	 [self animateView:firstPieceView toPosition: position];
	 } 
	 if (CGRectContainsPoint([secondPieceView frame], position)) {
	 [self animateView:secondPieceView toPosition: position];
	 } 
	 if (CGRectContainsPoint([thirdPieceView frame], position)) {
	 [self animateView:thirdPieceView toPosition: position];
	 }
	 // If one piece obscures another, display a message so the user can move the pieces apart
	 if (CGPointEqualToPoint(firstPieceView.center, secondPieceView.center) ||
	 CGPointEqualToPoint(firstPieceView.center, thirdPieceView.center) ||
	 CGPointEqualToPoint(secondPieceView.center, thirdPieceView.center)) {
	 touchInstructionsText.text = @"Double tap the background to move the pieces apart.";
	 piecesOnTop = YES;
	 } else {
	 piecesOnTop = NO;
	 }*/
	firstPoint.x = -1;
	firstPoint.y = -1;
	lastPoint = firstPoint;
}

// Handles the start of a touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"Touch Began");
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchFirstTouchAtPoint:[touch locationInView:self.view] forEvent:nil];
		
		touchCount++;  
	}	
}
// Handles the continuation of a touch.
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"Touches Moved");
	NSUInteger touchCount = 0;
	// Enumerates through all touch objects
	for (UITouch *touch in touches) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEvent:[touch view] toPosition:[touch locationInView:self.view]];
		touchCount++;
	}
}
// Handles the end of a touch event.
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"Touches Ended");
	//touchPhaseText.text = @"Phase: Touches ended";
	// Enumerates through all touch object
	for (UITouch *touch in touches) {
		// Sends to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self.view]];
	}
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do  additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);	
//#ifdef IPAD	
//	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
	
//#else
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//#endif
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
