//
//  CustomFormatter.m
//  PasswordDemo
//
//  Created by Dan Palmer on 19/02/2010.
//  Copyright 2010 Dan Palmer. All rights reserved.
//

#import "CustomFormatter.h"


@implementation CustomTextFieldFormatter

- init {
	[super init];
	maxLength = INT_MAX;
	return self;
}

- (void)setMaximumLength:(int)len {
	maxLength = len;
}

- (int)maximumLength {
	return maxLength;
}

- (NSString *)stringForObjectValue:(id)object {
	return (NSString *)object;
}

- (BOOL)getObjectValue:(id *)object forString:(NSString *)string errorDescription:(NSString **)error {
	*object = string;
	return YES;
}

- (BOOL)isPartialStringValid:(NSString *)partialString newEditingString:(NSString **)newString errorDescription:(NSString **)error {
	if ((int)[partialString length] > maxLength) {
		*newString = nil;
		return NO;
	}
	
	*newString = [partialString uppercaseString];
	return [*newString isEqual:partialString];
}

- (NSAttributedString *)attributedStringForObjectValue:(id)anObject withDefaultAttributes:(NSDictionary *)attributes {
	return nil;
}

@end
