//
//  Point.h
//  PasswordDemo
//
//  Created by Dan Palmer on 19/02/2010.
//  Copyright 2010 Dan Palmer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GridPoint : NSObject {
	int x;
	int y;
}

- (id)initWithPointX:(int)xx Y:(int)yy;
- (int)xValue;
- (int)yValue;


@end
