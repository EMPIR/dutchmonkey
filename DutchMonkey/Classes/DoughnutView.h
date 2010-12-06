//
//  DoughnutView.h
//  DutchMonkey
//
//  Created by David Guinnip on 12/5/10.
//  Copyright 2010 ArchVision. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DoughnutView : UIViewController {
	IBOutlet UIImageView *doughnutImage;
}

@property (nonatomic,retain) UIImageView *doughnutImage;

- (id)initWithPageNumber:(int)page;
- (void)setDoughnut:(int)index;
@end
