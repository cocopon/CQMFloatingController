//
// CQMPathUtilities.m
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

#import "CQMPathUtilities.h"


CGPathRef CQMPathCreateRoundingRect(CGRect rect, CGFloat blRadius, CGFloat brRadius, CGFloat trRadius, CGFloat tlRadius) {
	CGPoint tlPoint = rect.origin;
	CGPoint brPoint = CGPointMake(rect.origin.x + rect.size.width,
								  rect.origin.y + rect.size.height);
	CGMutablePathRef path = CGPathCreateMutable();
	
	CGPathMoveToPoint(path, NULL, tlPoint.x + tlRadius, tlPoint.y);
	CGPathAddArcToPoint(path, NULL,
						brPoint.x, tlPoint.y,
						brPoint.x, tlPoint.y + trRadius,
						trRadius);
	CGPathAddArcToPoint(path, NULL,
						brPoint.x, brPoint.y,
						brPoint.x - brRadius, brPoint.y,
						brRadius);
	CGPathAddArcToPoint(path, NULL,
						tlPoint.x, brPoint.y,
						tlPoint.x, brPoint.y - blRadius,
						blRadius);
	CGPathAddArcToPoint(path, NULL,
						tlPoint.x, tlPoint.y,
						tlPoint.x + tlRadius, tlPoint.y,
						tlRadius);
	CGPathCloseSubpath(path);
	
	return path;
}


CGPathRef CQMPathCreateInvertedRoundingRect(CGRect rect, CGFloat blRadius, CGFloat brRadius, CGFloat trRadius, CGFloat tlRadius) {
	CGPoint tlPoint = rect.origin;
	CGPoint brPoint = CGPointMake(rect.origin.x + rect.size.width,
								  rect.origin.y + rect.size.height);
	CGMutablePathRef path = CGPathCreateMutable();
	
	// Top left
	CGPathMoveToPoint(path, NULL, tlPoint.x, tlPoint.y);
	CGPathAddLineToPoint(path, NULL,
						 tlPoint.x + tlRadius, tlPoint.y);
	CGPathAddArcToPoint(path, NULL,
						tlPoint.x, tlPoint.y,
						tlPoint.x, tlPoint.y + tlRadius,
						tlRadius);
	CGPathCloseSubpath(path);
	
	// Top right
	CGPathMoveToPoint(path, NULL, brPoint.x, tlPoint.y);
	CGPathAddLineToPoint(path, NULL,
						 brPoint.x, tlPoint.y + trRadius);
	CGPathAddArcToPoint(path, NULL,
						brPoint.x, tlPoint.y,
						brPoint.x - trRadius, tlPoint.y,
						trRadius);
	CGPathCloseSubpath(path);
	
	// Bottom right
	CGPathMoveToPoint(path, NULL, brPoint.x, brPoint.y);
	CGPathAddLineToPoint(path, NULL,
						 brPoint.x - brRadius, brPoint.y);
	CGPathAddArcToPoint(path, NULL,
						brPoint.x, brPoint.y,
						brPoint.x, brPoint.y - brRadius,
						brRadius);
	CGPathCloseSubpath(path);
	
	// Bottom left
	CGPathMoveToPoint(path, NULL, tlPoint.x, brPoint.y);
	CGPathAddLineToPoint(path, NULL, tlPoint.x, brPoint.y - blRadius);
	CGPathAddArcToPoint(path, NULL,
						tlPoint.x, brPoint.y,
						tlPoint.x + blRadius, brPoint.y,
						blRadius);
	CGPathCloseSubpath(path);
	
	return path;
}	
						
