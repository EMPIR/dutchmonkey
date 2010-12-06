//
//  DoughnutView.m
//  DutchMonkey
//
//  Created by David Guinnip on 12/5/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import "DoughnutView.h"
#import "StringConst.h"


@implementation DoughnutView

@synthesize doughnutImage;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"DoughnutView" bundle:nil]) {
        //pageNumber = page;
    }
	
	
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)setDoughnut:(int)index{
	switch(index)
	{
		case 0:
		{
			UIImage *img = [UIImage imageNamed:[StringConst GetImgConst: IMG_CHOCOLATE]];
			self.doughnutImage.image = img;
			break;
		}
		case 1:
		{
			UIImage *img = [UIImage imageNamed:[StringConst GetImgConst: IMG_DUTCHAPPLE]];
			self.doughnutImage.image = img;
			break;
		}
		case 2:
		{
			UIImage *img = [UIImage imageNamed:[StringConst GetImgConst: IMG_DUTCHMONKEY]];
			self.doughnutImage.image = img;
			break;
		}
		case 3:
		{
			UIImage *img = [UIImage imageNamed:[StringConst GetImgConst: IMG_MAPLEBARS]];
			self.doughnutImage.image = img;
			break;
		}
		case 4:
		{
			UIImage *img = [UIImage imageNamed:[StringConst GetImgConst: IMG_JALAPENO]];
			self.doughnutImage.image = img;
			break;
		}
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
