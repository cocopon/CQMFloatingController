//
// CQMFloatingContentOverlayView.m
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

#import "CQMFloatingContentOverlayView.h"
#import "CQMPathUtilities.h"


#define kDefaultCornerRadius 5.0f
#define kShadowOffset        CGSizeMake(0, 1.0f)
#define kShadowBlur          2.0f
#define kShadowColor         [UIColor colorWithWhite:0 alpha:0.8f]


@implementation CQMFloatingContentOverlayView {
@private
	CGFloat cornerRadius_;
	UIColor *edgeColor_;
}


- (id)init {
	if (self = [super init]) {
		[self setBackgroundColor:[UIColor clearColor]];
		[self setCornerRadius:kDefaultCornerRadius];
	}
	return self;
}




#pragma mark -
#pragma mark Property


+ (CGFloat)frameWidth {
	return kShadowBlur;
}


- (CGFloat)cornerRadius {
	return cornerRadius_;
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
	cornerRadius_ = cornerRadius;
	[self setNeedsDisplay];
}


- (UIColor*)edgeColor {
	return edgeColor_;
}
- (void)setEdgeColor:(UIColor*)edgeColor {
	edgeColor_ = edgeColor;
	[self setNeedsDisplay];
}


#pragma mark -
#pragma mark UIView


- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGSize viewSize = [self frame].size;
	CGFloat radius = [self cornerRadius];
	CGPathRef path;
	
	CGContextSaveGState(context);
	CGFloat frameWidth = [CQMFloatingContentOverlayView frameWidth];
	path = CQMPathCreateRoundingRect(CGRectMake(frameWidth, frameWidth,
												viewSize.width - frameWidth * 2,
												viewSize.height - frameWidth * 2),
									 radius, radius, radius, radius);
	CGContextAddRect(context, CGRectMake(0, 0,
										 viewSize.width, viewSize.height));
	CGContextAddPath(context, path);
	CGContextSetFillColorWithColor(context, [self.edgeColor CGColor]);
	CGContextSetShadowWithColor(context, kShadowOffset, kShadowBlur, [kShadowColor CGColor]);
	CGContextEOFillPath(context);
	CGContextDrawPath(context, 0);
	CGPathRelease(path);
	CGContextRestoreGState(context);
}


@end
