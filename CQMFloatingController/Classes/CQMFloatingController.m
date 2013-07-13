//
// CQMFloatingController.m
// Created by cocopon on 2011/05/19.
//
// Copyright (c) 2012 cocopon <cocopon@me.com>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import <QuartzCore/QuartzCore.h>
#import "CQMFloatingController.h"
#import "CQMFloatingContentOverlayView.h"
#import "CQMFloatingFrameView.h"
#import "CQMFloatingMaskControl.h"
#import "CQMFloatingNavigationBar.h"
#import "CQMPathUtilities.h"


#define kDefaultMaskColor  [UIColor colorWithWhite:0 alpha:0.5]
#define kDefaultFrameColor [UIColor colorWithRed:0.10f green:0.12f blue:0.16f alpha:1.00f]
#define kDefaultPortraitFrameSize  CGSizeMake(320 - 66, 460 - 66)
#define kDefaultLandscapeFrameSize CGSizeMake(480 - 66, 300 - 66)
#define kFramePadding      5.0f
#define kRootKey           @"root"
#define kShadowColor       [UIColor blackColor]
#define kShadowOffset      CGSizeMake(0, 2.0f)
#define kShadowOpacity     0.70f
#define kShadowRadius      10.0f
#define kAnimationDuration 0.3f


@interface CQMFloatingController()

@property (nonatomic, readonly, strong) UIControl *maskControl;
@property (nonatomic, readonly, strong) CQMFloatingFrameView *frameView;
@property (nonatomic, readonly, strong) UIView *contentView;
@property (nonatomic, readonly, strong) CQMFloatingContentOverlayView *contentOverlayView;
@property (nonatomic, readonly, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UIImageView *shadowView;

- (void)layoutFrameView;
// Actions
- (void)maskControlDidTouchUpInside:(id)sender;

@end


@implementation CQMFloatingController {
@private
	BOOL presented_;
	CGSize landscapeFrameSize_;
	CGSize portraitFrameSize_;
	// View
	CQMFloatingMaskControl *maskControl_;
	CQMFloatingFrameView *frameView_;
	UIView *contentView_;
	CQMFloatingContentOverlayView *contentOverlayView_;
	UINavigationController *navController_;
	UIViewController *contentViewController_;
}


- (id)init {
	if (self = [super init]) {
		[self setPortraitFrameSize:kDefaultPortraitFrameSize];
		[self setLandscapeFrameSize:kDefaultLandscapeFrameSize];
		[self setFrameColor:kDefaultFrameColor];
	}
	return self;
}




#pragma mark -
#pragma mark Property


- (CGSize)portraitFrameSize {
	return portraitFrameSize_;
}
- (void)setPortraitFrameSize:(CGSize)portraitFrameSize {
	portraitFrameSize_ = portraitFrameSize;
	[self layoutFrameView];
}


- (CGSize)landscapeFrameSize {
	return landscapeFrameSize_;
}
- (void)setLandscapeFrameSize:(CGSize)landscapeFrameSize {
	landscapeFrameSize_ = landscapeFrameSize;
	[self layoutFrameView];
}


- (UIColor*)frameColor {
	return [self.frameView baseColor];
}
- (void)setFrameColor:(UIColor*)frameColor {
	[self.frameView setBaseColor:frameColor];
	[self.contentOverlayView setEdgeColor:frameColor];
	[self.navigationController.navigationBar setTintColor:frameColor];
}


- (CQMFloatingMaskControl*)maskControl {
	if (maskControl_ == nil) {
		maskControl_ = [[CQMFloatingMaskControl alloc] init];
		[maskControl_ setBackgroundColor:kDefaultMaskColor];
		[maskControl_ setResizeDelegate:self];
		[maskControl_ addTarget:self
						 action:@selector(maskControlDidTouchUpInside:)
			   forControlEvents:UIControlEventTouchUpInside];
	}
	return maskControl_;
}


- (UIView*)frameView {
	if (frameView_ == nil) {
		frameView_ = [[CQMFloatingFrameView alloc] init];
		[frameView_.layer setShadowColor:[kShadowColor CGColor]];
		[frameView_.layer setShadowOffset:kShadowOffset];
		[frameView_.layer setShadowOpacity:kShadowOpacity];
		[frameView_.layer setShadowRadius:kShadowRadius];
	}
	return frameView_;
}


- (UIView*)contentView {
	if (contentView_ == nil) {
		contentView_ = [[UIView alloc] init];
		[contentView_ setClipsToBounds:YES];
	}
	return contentView_;
}


- (CQMFloatingContentOverlayView*)contentOverlayView {
	if (contentOverlayView_ == nil) {
		contentOverlayView_ = [[CQMFloatingContentOverlayView alloc] init];
		[contentOverlayView_ setUserInteractionEnabled:NO];
	}
	return contentOverlayView_;
}


- (UINavigationController*)navigationController {
	if (navController_ == nil) {
		UIViewController *dummy = [[UIViewController alloc] init];
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:dummy];
		
		// Archive navigation controller for changing navigationbar class
		[navController navigationBar];
		NSMutableData *data = [[NSMutableData alloc] init];
		NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
		[archiver encodeObject:navController forKey:kRootKey];
		[archiver finishEncoding];
		
		// Unarchive it with changing navigationbar class
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
		[unarchiver setClass:[CQMFloatingNavigationBar class]
				forClassName:NSStringFromClass([UINavigationBar class])];
		navController_ = [unarchiver decodeObjectForKey:kRootKey];
		
	}
	return navController_;
}


@synthesize shadowView = shadowView_;


#pragma mark -
#pragma mark Singleton


+ (CQMFloatingController*)sharedFloatingController {
	static CQMFloatingController *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^ {
		instance = [[CQMFloatingController alloc] init];
	});
	return instance;
}


#pragma mark -


- (void)showInView:(UIView*)view withContentViewController:(UIViewController*)viewController animated:(BOOL)animated {
	@synchronized(self) {
		if (presented_) {
			return;
		}
		presented_ = YES;
	}
	
	[self.view setAlpha:0];
	
	if (contentViewController_ != viewController) {
		[[contentViewController_ view] removeFromSuperview];
		contentViewController_ = viewController;

		NSArray *viewControllers = [NSArray arrayWithObject:contentViewController_];
		[self.navigationController setViewControllers:viewControllers];
	}
	
	[self.view setFrame:[view bounds]];
	[view addSubview:[self view]];
	
	[self layoutFrameView];
	
	__block CQMFloatingController *me = self;
	[UIView animateWithDuration:(animated ? kAnimationDuration : 0)
					 animations:
	 ^(void) {
		 [me.view setAlpha:1.0f];
	 }];
}


- (void)dismissAnimated:(BOOL)animated {
    if (animated) {
        __block CQMFloatingController *me = self;
        [UIView animateWithDuration: kAnimationDuration
                         animations:
         ^(void) {
             [me.view setAlpha:0];
         }
                         completion:
         ^(BOOL finished) {
             if (finished) {
                 [me.view removeFromSuperview];
                 presented_ = NO;
             }
         }];
        
    } else {
        [self.view removeFromSuperview];
        presented_ = NO;
    }
}


- (void)layoutFrameView {
	// Frame
	CGSize maskSize = [self.maskControl frame].size;
	BOOL isPortrait = (maskSize.width <= maskSize.height);
	CGSize frameSize = isPortrait ? [self portraitFrameSize] : [self landscapeFrameSize];
	CGSize viewSize = [self.view frame].size;
	UIView *frameView = [self frameView];
	[frameView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
	[frameView setFrame:CGRectMake(round((viewSize.width - frameSize.width) / 2),
								   round((viewSize.height - frameSize.height) / 2),
								   frameSize.width,
								   frameSize.height)];
	[frameView setNeedsDisplay];
	
	// Content
	UIView *contentView = [self contentView];
	CGRect contentFrame = CGRectMake(kFramePadding, 0,
									 frameSize.width - kFramePadding * 2,
									 frameSize.height - kFramePadding);
	CGSize contentSize = contentFrame.size;
	[contentView setFrame:contentFrame];
	
	// Navigation
	UIView *navView = [self.navigationController view];
	CGFloat navBarHeight = [self.navigationController.navigationBar sizeThatFits:[contentView bounds].size].height;
	[navView setFrame:CGRectMake(0, 0,
								 contentSize.width, contentSize.height)];
	[self.navigationController.navigationBar setFrame:CGRectMake(0, 0,
																 contentSize.width, navBarHeight)];
	
	// Content overlay
	UIView *contentOverlay = [self contentOverlayView];
	CGFloat contentFrameWidth = [CQMFloatingContentOverlayView frameWidth];
	[contentOverlay setFrame:CGRectMake(contentFrame.origin.x - contentFrameWidth,
										contentFrame.origin.y + navBarHeight - contentFrameWidth,
										contentSize.width  + contentFrameWidth * 2,
										contentSize.height - navBarHeight + contentFrameWidth * 2)];
	[contentOverlay setNeedsDisplay];
	[contentOverlay.superview bringSubviewToFront:contentOverlay];
	
	// Shadow
	CGFloat radius = [self.frameView cornerRadius];
	CGPathRef shadowPath = CQMPathCreateRoundingRect(CGRectMake(0, 0,
																frameSize.width, frameSize.height),
													 radius, radius, radius, radius);
	[frameView.layer setShadowPath:shadowPath];
	CGPathRelease(shadowPath);
}


#pragma mark -
#pragma mark Actions


- (void)maskControlDidTouchUpInside:(id)sender {
	[self dismissAnimated:YES];
}


#pragma mark -
#pragma mark Delegates


- (void)floatingMaskControlDidResize:(CQMFloatingMaskControl*)maskControl {
	[self layoutFrameView];
}


#pragma mark -
#pragma mark UIViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor clearColor]];
	
	UIView *maskControl = [self maskControl];
	CGSize viewSize = [self.view frame].size;
	[maskControl setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
	[maskControl setFrame:CGRectMake(0, 0,
									 viewSize.width, viewSize.height)];
	[self.view addSubview:maskControl];
	
	[self.view addSubview:[self frameView]];
	[self.frameView addSubview:[self contentView]];
	[self.contentView addSubview:[self.navigationController view]];
	[self.frameView addSubview:[self contentOverlayView]];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}


@end
