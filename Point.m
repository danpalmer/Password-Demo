//
//  Point.m
//  PasswordDemo
//
//  Created by Dan Palmer on 19/02/2010.
//  Copyright 2010 Dan Palmer. All rights reserved.
//

#import "Point.h"


@implementation GridPoint

- (id)initWithPointX:(int)xx Y:(int)yy {
	x = xx;
	y = yy;
	return self;
}

- (int)xValue {
	return x;
}

- (int)yValue {
	return y;
}

@end
