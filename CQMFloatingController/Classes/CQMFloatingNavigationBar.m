//
// CQMFloatingNavigationBar.m
// Created by cocopon on 2011/09/23.
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

#import "CQMFloatingNavigationBar.h"


@implementation CQMFloatingNavigationBar


- (id)init {
	if (self = [super init]) {
		[self setBackgroundColor:[UIColor clearColor]];
	}
	return self;
}


- (id)initWithCoder:(NSCoder*)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self setBackgroundColor:[UIColor clearColor]];
	}
	return self;
}


#pragma mark -
#pragma mark UIView


- (void)drawRect:(CGRect)rect {
	// Draw nothing (transparent background)
}


@end
