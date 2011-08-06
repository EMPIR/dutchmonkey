//
//  DutchMonkeyViewController.m
//  DutchMonkey
//
//  Created by David Guinnip on 11/16/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import "DutchMonkeyViewController.h"
#import "Monkey.h"
#import "DoughnutView.h"


static NSUInteger kNumberOfPages = 5;

@interface DutchMonkeyViewController()
-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event;
-(void)dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position;
-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position;
-(void)loadScrollViewWithPage:(int)page;
-(void)scrollViewDidScroll:(UIScrollView *)sender;
@end	


@implementation DutchMonkeyViewController
@synthesize scrollView, viewControllers, m_monkey, monkeyHead, monkeyRightArm, monkeyLeftArm, monkeyRightLeg,monkeyLeftLeg,monkeyTail,monkeyBelly;
@synthesize gameTimer, doughnut;
@synthesize doughnut1, doughnut2, doughnut3, doughnut4, doughnut5;

CGPoint firstPoint;
CGPoint lastPoint;
BOOL touching;
UIImageView *imgView = NULL;
int bodypart;
CGPoint translatePivot;
CGRect rect;

UIImageView *imgView2 = NULL;

//double headAngle = 0;
//double headAngleIncrement = 0.01;


double tailAngle = 0;
double tailAngleIncrement = 0.01;

double footRAngle = 0;
double footRAngleIncrement = 0.02;
double footLAngle = 0;
double footLAngleIncrement = 0.02;

double armRAngle = 0;
double armRAngleIncrement = 0.02;
double armLAngle = 0;
double armLAngleIncrement = 0.02;

const int HEAD_PIVOT [] = {0,30};
const int ARMR_PIVOT [] = {-22,-45};
const int ARML_PIVOT [] = {21,-47};
const int LEGR_PIVOT [] = {-24,-20};
const int LEGL_PIVOT [] = {24,-20};
const int TAIL_PIVOT [] = {-60,0};



/*
typedef enum BodyPart{
	HEAD = 1,
	BELLY = 2,
	ARMLEFT = 3,
	ARMRIGHT = 4,
	LEGLEFT = 5,
	LEGRIGHT = 6,
	TAIL = 7
};
*/
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

-(CGPoint) getPivot: (int)bodyPart: (CGRect) rect
{
	CGPoint p;
	/*
	p.x =  rect.origin.x + rect.size.width / 2.0;
	p.y =  rect.origin.y + rect.size.height / 2.0;
	*/
	
	switch(bodyPart)
	{
		case 0: //head
		{
			
			translatePivot.x = HEAD_PIVOT[0];
			translatePivot.y = HEAD_PIVOT[1];
			break;
		}
		case 1: //right arm
		{
			translatePivot.x = ARMR_PIVOT[0];
			translatePivot.y = ARMR_PIVOT[1];
			break;
		}
		case 2: //left arm
		{
			translatePivot.x = ARML_PIVOT[0];
			translatePivot.y = ARML_PIVOT[1];

			break;
		}
		case 3: //right leg
		{
			translatePivot.x = LEGR_PIVOT[0];
			translatePivot.y = LEGR_PIVOT[1];
			
			break;
		}
		case 4: //left leg
		{
			translatePivot.x = LEGL_PIVOT[0];
			translatePivot.y = LEGR_PIVOT[1];
			break;
		}
		case 5: //tail
		{
			translatePivot.x = TAIL_PIVOT[0];
			translatePivot.y = TAIL_PIVOT[1];
			break;
		}
		default:
		{
			translatePivot.x = 0;
			translatePivot.y = -20;

			
		}
	}
	
	p.x = (rect.origin.x + (rect.size.width / 2.0));// + xp;
	p.y = (rect.origin.y + (rect.size.height / 2.0));// + yp;;

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
	if(len == 0)
		return 0;
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
	
	int bodypart2 = 0;
	CGRect rect2;
	
	
	//NSLog(@"dispatchTouchEvent");
	
	if(imgView2 == NULL)
	{
		if(CGRectContainsPoint([doughnut1 frame],position)){
			
			imgView2 = doughnut1;
		}
		else if(CGRectContainsPoint([doughnut2 frame],position)){
			//[doughnut2 setCenter:position];
			imgView2 = doughnut2;
		}
		else if(CGRectContainsPoint([doughnut3 frame],position)){
			//[doughnut3 setCenter:position];
			imgView2 = doughnut3;
		}
		else if(CGRectContainsPoint([doughnut4 frame],position)){
			//[doughnut4 setCenter:position];
			imgView2 = doughnut4;
		}
		else 	if(CGRectContainsPoint([doughnut5 frame],position)){
			//[doughnut5 setCenter:position];
			imgView2 = doughnut5;
		}
	}
	if(CGRectContainsPoint([monkeyBelly frame],position)){
		imgView2.hidden = YES;
		[m_monkey startEating:imgView2];
	}
	else{
		[imgView2 setCenter:position];
		[self.view bringSubviewToFront:imgView2];
		
	}
	
	
	
	/*if (CGRectContainsPoint([monkeyHead frame], position)) {
		imgView2 = monkeyHead;
		bodypart2 = 0;
		rect2 = monkeyHead.frame;
	}
	else if(CGRectContainsPoint([monkeyRightArm frame],position)){
		imgView2 = monkeyRightArm;
		bodypart2 = 1;
		rect2 = monkeyRightArm.frame;
	}
	else if(CGRectContainsPoint([monkeyLeftArm frame],position)){
		imgView2 = monkeyLeftArm;
		bodypart2 = 2;
		rect2 = monkeyLeftArm.frame;
	}
	else if(CGRectContainsPoint([monkeyRightLeg frame],position)){
		imgView2 = monkeyRightLeg;
		bodypart2 = 3;
		rect2 = monkeyRightLeg.frame;
	}
	else if(CGRectContainsPoint([monkeyLeftLeg frame],position)){
		imgView2 = monkeyLeftLeg;
		bodypart2 = 4;
		rect2 = monkeyLeftLeg.frame;
	}
	else if (CGRectContainsPoint([monkeyTail frame], position)) {
		imgView2 = monkeyTail;
		bodypart2 = 5;
		rect2 = monkeyLeftLeg.frame;
	}
	
	if(firstPoint.x == -1)
	{
		firstPoint.x = position.x;
		firstPoint.y = position.y;
		lastPoint.x = position.x;
		lastPoint.y = position.y;
	}
	
	
	if(imgView2 != NULL)
	{
		if(imgView == NULL)
		{
			imgView = imgView2;
			bodypart = bodypart2;
			rect = rect2;
		}
		//CGPoint origin = frame.origin;
		CGPoint origin = [self getPivot:bodypart:rect];
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
			imgView.transform = CGAffineTransformTranslate(imgView.transform,translatePivot.x,translatePivot.y);
			imgView.transform = CGAffineTransformRotate(imgView.transform, angle);
			imgView.transform = CGAffineTransformTranslate(imgView.transform,-translatePivot.x,-translatePivot.y);		}
	}*/
	 
	
}

-(IBAction) doughnutTouch:(id)sender{
	
	if(sender == doughnut1)
	{
		int debug = 0;
	}
	else if(sender == doughnut2)
	{
		int debug = 0;
	}
	else if(sender == doughnut3)
	{
		int debug = 0;
	}
	else if(sender == doughnut4)
	{
		int debug = 0;
	}
	else if(sender == doughnut5)
	{
		int debug = 0;
	}
}

/*-(IBAction) doughnutDrag:(id)sender{
	
	if(sender == doughnut1)
	{
		int debug = 0;
	}
	else if(sender == doughnut2)
	{
		int debug = 0;
	}
	else if(sender == doughnut3)
	{
		int debug = 0;
	}
	else if(sender == doughnut4)
	{
		int debug = 0;
	}
	else if(sender == doughnut5)
	{
		int debug = 0;
	}
}*/



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
	touching = YES;
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
	touching = NO;
	NSLog(@"Touches Ended");
	//touchPhaseText.text = @"Phase: Touches ended";
	// Enumerates through all touch object
	for (UITouch *touch in touches) {
		// Sends to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self.view]];
	}
	imgView = NULL;
	imgView2 = NULL;
}


-(IBAction) button1Down:(id)sender{
	[m_monkey startWalk];
}
-(IBAction) BellyTouch:(id) sender{
	//[m_monkey startWalk];
	//[m_monkey startEating];
	[self reset];
}

-(void)gameloop{
	[m_monkey gameloop];
	
		
	
}
- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	
    // replace the placeholder if necessary
    DoughnutView *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[DoughnutView alloc] initWithPageNumber:page];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
	else {
		[controller setDoughnut:page];
		
		
	}
	
	if(nil == controller.view)
	{
		int debug = 0;
	}
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        //frame.origin.x = frame.size.width * page;
        //frame.origin.y = 0;
		frame.origin.x=  0;
		frame.origin.y  = (frame.size.height) * page;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    //CGFloat pageWidth = scrollView.frame.size.width;
    //int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	//pageControl.currentPage = page;
	
	
	CGFloat pageHeight = scrollView.frame.size.height;
	int page = floor((scrollView.contentOffset.y - pageHeight / 2) / pageHeight) +1;
	pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    //frame.origin.x = frame.size.width * page;
    //frame.origin.y = 0;
    frame.origin.y = frame.size.height * page;
	frame.origin.x = 0;
	[scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}


-(void) viewWillAppear:(BOOL)animated{
	touching = NO;
	pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

-(void) reset{
	[m_monkey init];
	imgView2 = NULL;
	doughnut.hidden = YES;
	doughnut1.hidden = NO;
	doughnut2.hidden = NO;
	doughnut3.hidden = NO;
	doughnut4.hidden = NO;
	doughnut5.hidden = NO;
	
	firstPoint.x = -1;
	CGPoint position;
	position.x = 291+ 37.5;
	position.y = 48 + 37.5;
	
	doughnut1.transform = CGAffineTransformIdentity;
	
	[doughnut1 setCenter:position];
}

// Implement viewDidLoad to do  additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[m_monkey init];
	m_monkey = [[[Monkey  alloc] init] retain];
	m_monkey.monkeyHead = monkeyHead;
	m_monkey.monkeyLeftArm = monkeyLeftArm;
	m_monkey.monkeyRightArm = monkeyRightArm;
	m_monkey.monkeyLeftLeg = monkeyLeftLeg;
	m_monkey.monkeyRightLeg = monkeyRightLeg;
	m_monkey.monkeyTail = monkeyTail;
	m_monkey.monkeyBelly = monkeyBelly;
	m_monkey.doughnut = doughnut;
	doughnut.hidden = YES;
	doughnut1.hidden = NO;
	firstPoint.x = -1;
	
	
	/*
	//paging stuff
	// view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
	
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
	NSLog(@"Scroll Size %d", scrollView.frame.size.width);
	//scrollView.contentSize = CGSizeMake(267 * kNumberOfPages, 200);
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, (scrollView.frame.size.height) * kNumberOfPages);
	scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	//scrollView.canCancelContentTouches = NO;
	*/
	gameTimer = [[NSTimer scheduledTimerWithTimeInterval:.025 target:self selector:@selector(gameloop) userInfo:nil repeats:YES] retain];
	

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
	[m_monkey release];
}

@end
