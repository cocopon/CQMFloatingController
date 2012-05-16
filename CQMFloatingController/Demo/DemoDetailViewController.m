//
// DemoDetailViewController.m
// Created by cocopon on 2012/05/15.
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

#import "DemoDetailViewController.h"


#define kBackgroundColor [UIColor colorWithWhite:0.8f alpha:1.0f]
#define kLabelFont       [UIFont boldSystemFontOfSize:30.0f]
#define kShadowOffset    CGSizeMake(0, 1.0f)
#define kTextColor       [UIColor blackColor]
#define kTextShadowColor [UIColor colorWithWhite:1.0f alpha:0.5f]


@interface DemoDetailViewController()

@property (nonatomic, readonly, retain) UILabel *textLabel;

@end


@implementation DemoDetailViewController {
@private
	// View
	UILabel *label_;
}

- (void)dealloc {
	[label_ release];
	[super dealloc];
}


#pragma mark -
#pragma mark Property


- (NSString*)text {
	return [self.textLabel text];
}
- (void)setText:(NSString*)text {
	[self.textLabel setText:text];
	[self.navigationItem setTitle:text];
}


- (UILabel*)textLabel {
	if (label_ == nil) {
		label_ = [[UILabel alloc] init];
		[label_ setBackgroundColor:[UIColor clearColor]];
		[label_ setFont:kLabelFont];
		[label_ setShadowColor:kTextShadowColor];
		[label_ setShadowOffset:kShadowOffset];
		[label_ setTextAlignment:UITextAlignmentCenter];
		[label_ setTextColor:kTextColor];
	}
	return label_;
}


#pragma mark -
#pragma mark UIViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.view setBackgroundColor:kBackgroundColor];
	
	UILabel *label = [self textLabel];
	CGSize viewSize = [self.view frame].size;
	[label setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
	[label setFrame:CGRectMake(0, 0, viewSize.width, viewSize.height)];
	[self.view addSubview:label];
}


@end
